# homelab

## Install Docker


```bash
curl -sSL https://get.docker.com | sh
sudo usermod -aG docker $(whoami)
exit

# OR 

sudo apt install docker.io



OR

# Maintained by Docker
sudo apt install docker-ce docker-ce-cli containerd.io -y

OR

# Maintained by Debian
sudo apt install docker.io docker-compose -y
chmod 666 path

OR

curl -sSL https://get.docker.com | sh
sudo usermod -aG docker $(whoami)
exit

OR

sudo curl -sSL https://get.docker.com/ | CHANNEL=stable bash
sudo systemctl enable docker --now

```

---

## Install Portainer

```bash

docker compose -f portainer.docker-compose.yml up -d

```


## Mount external drive on startup

1. Identify UUID
```bash
sudo blkid /dev/sda1
```
Copy the `UUID="..."` value (e.g., `UUID="1234-abcd-..."`).

2. Backup and edit fstab
```bash
sudo cp /etc/fstab /etc/fstab.bak  # Backup first!
sudo nano /etc/fstab
```

Add this line at the end (replace UUID and path as needed):
```
# External 1TB drive (sda1) - added [date]
UUID="PUT-YOUR-UUID-HERE" /mnt/wd1tb ext4 defaults,nofail 0 2
```
- `nofail`: Allows boot if drive unplugged.
- Save (Ctrl+O, Enter, Ctrl+X).

3. Test
```bash
sudo mount -a  # No errors? Good.
df -h /mnt/wd1tb  # Verify mounted.
```
4. Reboot test
```bash
sudo reboot
```
Drive should auto-mount at `/mnt/wd1tb`.
```


## Basic Setup

```bash

pyinfra helidon infra/basic_setup.py

```




---

## HACS Setup under Home Assistant:
docker ps
docker exec -it [CONTAINER_NAME] bash
wget -O - https://get.hacs.xyz | bash -
docker restart [CONTAINER_NAME]

### Development Notes

```bash


sudo apt-get install docker-ce docker-ce-cli containerd.io


sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

sudo apt-get install kubelet kubeadm kubectl

sudo swapoff -a


sudo kubeadm init --control-plane-endpoint=$IPADDR --pod-network-cidr=$POD_CIDR --node-name $NODENAME --apiserver-cert-extra-sans=$IPADDR --ignore-preflight-errors Swap

kubeadm token create --print-join-command

docker run -d --restart=unless-stopped \
 -p 80:80 -p 443:443 \
 --privileged \
 rancher/rancher:latest



curl -sfL https://get.k3s.io | sh -
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644





https://phoenixnap.com/kb/how-to-install-kubernetes-on-a-bare-metal-server

https://dockerlabs.collabnix.com/kubernetes/beginners/install/ubuntu/18.04/install-k8s.html


oci session authenticate


terraform init

terraform plan

terraform validate

terraform apply


https://github.com/wemake-services/caddy-gen

```
