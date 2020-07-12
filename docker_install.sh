#sudo dnf update -y
#sudo dnf upgrade -y
sudo systemctl start firewalld
sudo timedatectl set-timezone America/Sao_Paulo
sudo dnf install -y net-tools vim nano epel-release wget curl tcpdump #git
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf clean all
sudo dnf install -y https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
sudo dnf install -y docker-ce
sudo systemctl enable --now docker
sudo firewall-cmd --zone=public --add-masquerade --permanent
sudo firewall-cmd --reload
sudo docker swarm init --advertise-addr 192.168.0.150
sudo docker network create --driver overlay monitoring-network
#sudo git clone https://github.com/sharlyelias/maratonazabbix.git
#sudo cp -r maratonazabbix/* .
sudo cp -r /vagrant/* .
sudo mkdir -p /mnt/data-docker/grafana/data && \
sudo chown -R 472:472 /mnt/data-docker/grafana/data && \
sudo chmod -R 775 /mnt/data-docker/grafana && mkdir -p /mnt/data-docker/grafana/certs && \
sudo chown -R 472:472 /mnt/data-docker/grafana/certs
sudo docker stack deploy -c docker-compose.yaml maratonazabbix
