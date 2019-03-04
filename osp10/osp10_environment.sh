export YOURLABSERVER=127.0.0.2
source ~/.venv_infrared/bin/activate
cd ~/.venv_infrared/infrared

infrared virsh --host-address $YOURLABSERVER --host-key ~/.ssh/key_sbr_hackfest --cleanup yes

infrared virsh \
--host-address $YOURLABSERVER \
--host-key ~/.ssh/key_sbr_hackfest \
--topology-nodes undercloud:1,controller:3,compute:2 \
--topology-network 3_nets \
--collect-ansible-facts True \
-e override.undercloud.cpu=4 \
-e override.undercloud.memory=10240 \
-e override.undercloud.disks.disk1.size=40G \
--disk-pool=/home/images/ \
--image-url http://rhos-qe-mirror-tlv.usersys.redhat.com/brewroot/packages/rhel-guest-image/7.6/217/images/rhel-guest-image-7.6-217.x86_64.qcow2

infrared tripleo-undercloud -v --version 10 --images-task=rpm --build=ga

infrared tripleo-overcloud \
--deployment-files virt \
--introspect yes \
--tagging yes \
--deploy yes \
--version 10
