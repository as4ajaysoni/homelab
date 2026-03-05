# Kasm on Raspberry Pi 4 — Setup Guide

## Step 1 — Create Swap Space

Kasm recommends 1GB swap per concurrent session. SSH into your Pi and run:

```bash
sudo dd if=/dev/zero bs=1M count=4096 of=/mnt/4GiB.swap
sudo chmod 600 /mnt/4GiB.swap
sudo mkswap /mnt/4GiB.swap
sudo swapon /mnt/4GiB.swap

# Make it persistent across reboots
echo '/mnt/4GiB.swap none swap sw 0 0' | sudo tee -a /etc/fstab
```

---

## Step 2 — Deploy Kasm

```yaml
services:
  kasm:
    image: lscr.io/linuxserver/kasm:latest
    container_name: kasm
    privileged: true
    environment:
      - KASM_PORT=8443
    volumes:
      - /opt/kasm/data:/opt
      - /opt/kasm/profiles:/profiles
      - /dev/input:/dev/input
      - /run/udev/data:/run/udev/data
    ports:
      - 3000:3000
      - 8443:443
    restart: unless-stopped
```

> 💡 `KASM_PORT` and **both sides** of the port mapping must match. The LinuxServer image is ARM64-compatible and pulls automatically for your Pi.

Click **Deploy the Stack**.

---

## Step 3 — First Boot

The first run downloads workspace images — this can take **5–10 minutes**. Monitor progress in Portainer under the container's **Logs** tab.

---

## Step 4 — Run the Setup Wizard

Once the container is up, open your browser and go to:

```
https://<raspberry-pi-ip>:3000
```

Complete the installation wizard here. After setup, Kasm will be available at:

```
https://<raspberry-pi-ip>:8443
```

> ⚠️ You'll see a self-signed certificate warning — click **Advanced → Proceed**. This is expected.

---

## Step 5 — Log In

| Field    | Value                        |
|----------|------------------------------|
| URL      | `https://<ip>:8443`          |
| Username | `admin@kasm.local`           |
| Password | Set during the setup wizard  |
