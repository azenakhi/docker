systemctl stop docker 
rm -rf /var/lib/docker

mkdir /etc/systemd/system/docker.service.d

vim /etc/systemd/system/docker.service.d/docker.conf

[Service]
EnvironmentFile=-/etc/sysconfig/docker
EnvironmentFile=-/etc/sysconfig/docker-storage
ExecStart=
ExecStart=/usr/bin/dockerd $OPTIONS \
                           $DOCKER_STORAGE_OPTIONS 


vim /etc/sysconfig/docker
OPTIONS="-g /docker"

pvcreate /dev/sdd
vgcreate dockervg2 /dev/sdd
lvcreate --wipesignatures y -n thinpool dockervg2 -l 95%VG
lvcreate --wipesignatures y -n thinpoolmeta dockervg2 -l 1%VG
lvconvert -y --zero n -c 512K --thinpool dockervg2/thinpool --poolmetadata dockervg2/thinpoolmeta

vim /etc/lvm/profile/docker-thinpool.profile
activation {
    thin_pool_autoextend_threshold=80
    thin_pool_autoextend_percent=20
}

lvchange --metadataprofile docker-thinpool dockervg2/thinpool
lvs -o+seg_monitor

vim /etc/sysconfig/docker-storage
DOCKER_STORAGE_OPTIONS="--storage-driver=devicemapper --storage-opt=dm.thinpooldev=/dev/mapper/dockervg2-thinpool --storage-opt=dm.use_deferred_removal=true --storage-opt=dm.use_deferred_deletion=true"

systemctl daemon-reload
systemctl start docker

journalctl -fu dm-event.service
lsblk
docker info
