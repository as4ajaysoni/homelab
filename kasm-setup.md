# Kasm Workspaces

## Step 1: Stop Conflicting Containers

Kasm's installer needs port 443 free during setup. Stop any container using it (e.g. Caddy):

```bash
sudo docker stop caddy-internal
sudo lsof -i :443
```

## Step 2: Create Swap Space

Kasm is memory-intensive. Add swap on your WD drive to be safe:

```bash
sudo dd if=/dev/zero bs=1M count=4096 of=/mnt/wd1tb/kasm.swap
sudo chmod 600 /mnt/wd1tb/kasm.swap
sudo mkswap /mnt/wd1tb/kasm.swap
sudo swapon /mnt/wd1tb/kasm.swap

# Make swap permanent across reboots
echo '/mnt/wd1tb/kasm.swap none swap sw 0 0' | sudo tee -a /etc/fstab
```

## Step 3: Download and Install Kasm

```bash
cd /tmp

# Download Kasm release
wget https://kasm-static-content.s3.amazonaws.com/kasm_release_1.17.0.bab4b6.tar.gz

# Extract
tar -xf kasm_release_*.tar.gz

# Install on port 8443 (avoids conflict with Caddy on 443)
sudo bash kasm_release/install.sh -L 8443
```

Note: During install, press N if prompted about config file changes (e.g. initramfs.conf) to keep your current version.

Note: At the end of installation, Kasm will display generated credentials. Save these immediately:
- Admin: admin@kasm.local / generated password
- User: user@kasm.local / generated password

## Step 4: Restart Caddy

```bash
sudo docker start caddy-internal
```

## Step 5: Useful Aliases (Optional)

```bash
echo 'alias kasm-start="sudo /opt/kasm/bin/start"' >> ~/.bashrc
echo 'alias kasm-stop="sudo /opt/kasm/bin/stop"' >> ~/.bashrc
source ~/.bashrc
```

## Step 6: Access Kasm

Open in your browser:

```
https://YOUR_PI_IP:8443
```

You will see a self-signed certificate warning. This is normal. Click Advanced then Proceed anyway.

Log in with the credentials saved in Step 3 and change your passwords immediately.

## Step 7: Embed in Home Assistant

Add to your configuration.yaml:

```yaml
panel_iframe:
  kasm:
    title: "Kasm"
    url: "https://YOUR_PI_IP:8443"
    icon: mdi:television-play
    require_admin: false
```

Then restart Home Assistant.

Important: Before the HA panel will load, you must visit https://YOUR_PI_IP:8443 directly in your browser once and accept the certificate. After that, the HA sidebar panel will work.

## Notes

| Item          | Value                    |
|---------------|--------------------------|
| Kasm URL      | https://YOUR_PI_IP:8443  |
| Admin login   | admin@kasm.local         |
| Data location | /opt/kasm                |
| Swap file     | /mnt/wd1tb/kasm.swap     |
| Start/Stop    | kasm-start / kasm-stop   |
