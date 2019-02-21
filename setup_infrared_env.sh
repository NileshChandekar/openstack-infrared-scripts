sudo yum install git gcc libffi-devel openssl-devel python-virtualenv libselinux-python redhat-rpm-config -y
virtualenv ~/.venv_infrared
source ~/.venv_infrared/bin/activate
pip install --upgrade pip
pip install --upgrade setuptools
cd ~/.venv_infrared
git clone https://github.com/redhat-openstack/infrared.git
cd infrared
pip install .
echo ". $(pwd)/etc/bash_completion.d/infrared" >> ${VIRTUAL_ENV}/bin/activate
ssh-keygen -f ~/.ssh/key_sbr_hackfest
export YOURLABSERVER=127.0.0.2
echo $YOURLABSERVER
ssh-copy-id -i ~/.ssh/key_sbr_hackfest.pub root@$YOURLABSERVER
yum -y install libvirt libvirt-python
cd /var/lib/libvirt
rm -rf images
mkdir /home/images
chcon -t virt_image_t /home/images
ln -s /home/images .
modprobe nf_reject_ipv6
echo "net.ipv6.conf.enp22s0f4.accept_ra = 2" >> /etc/sysctl.d/98-ipv6.conf 
sysctl -w net.ipv6.conf.enp22s0f4.accept_ra=2

