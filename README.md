# homelab


## Raspberry Pi SD Card Life Optimization

Reduces SD card wear by configuring systemd journald to store logs in RAM instead of disk.

### What This Does

- **Storage=volatile** - Stores journal logs in RAM only (lost on reboot)
- **SystemMaxUse=50M** - Limits journal size to 50MB
- **Compress=yes** - Compresses older logs to save space
- **SyncIntervalSec=1m** - Reduces disk sync frequency

### Usage

Run the setup script:

```bash
sudo ./sd-card-optimize.sh
```

Reboot to apply changes.

### Optional: Move /var/log to tmpfs

For additional SD card protection, add tmpfs for logs:

```bash
sudo tee -a /etc/fstab > /dev/null << 'EOF'
tmpfs   /var/log   tmpfs   defaults,noatime,size=50M   0 0
```

> **Warning**: Logs will be lost on reboot. Only use if you don't need persistent logging.


## Local File Transfer Tools — Comparison

| | PairDrop | PsiTransfer | dufs |
|---|---|---|---|
| **GitHub Stars** | ⭐ ~10k | ⭐ ~1.4k | ⭐ ~9.7k |
| **Local-only by design** | ❌ has global rooms | ✅ | ✅ |
| **No login / no auth** | ✅ | ⚠️ needs password for file listing | ✅ |
| **Persistent file listing** | ❌ | ⚠️ admin password required | ✅ always visible |
| **Upload & Download** | ✅ | ✅ | ✅ |
| **Drag & Drop** | ✅ | ✅ | ✅ |
| **Shareable links** | ✅ | ✅ | ❌ |
| **Browse folders** | ❌ | ❌ | ✅ |
| **File size limit option** | ❌ | ✅ | ✅ |
| **Docker support** | ✅ official | ✅ official | ✅ official |
| **Best for** | Quick peer-to-peer drops | One-time send with link | Persistent local file server |

---

**Verdict:** For local LAN use with no passwords and persistent file access → **dufs** is the best fit.


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

## Ricoh SP 111 — Printer Driver Setup on Raspberry Pi

#### 1. Install Required Packages



```bash
sudo apt install printer-driver-gutenprint
sudo apt install openprinting-ppds
sudo apt install usbutils
lsusb #to confirm USB detection
```

#### 2. Restart CUPS

#### 3. Add Printer via CUPS Web Interface

```
http://<ip>:631
```

Then follow these steps:

1. Go to **Administration** → **Add Printer**
2. Log in with your username and password
3. Select your Ricoh printer from the USB devices list
4. Click **Continue**
5. Fill in Name, Description, and Location → **Continue**

4. Choose Make and Model
> **Make:** Ricoh
> **Model:** `SP 112 Foomatic/foo2ddst`

## Misc

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
