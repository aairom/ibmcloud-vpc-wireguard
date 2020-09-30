#!/bin/bash

## Update machine
DEBIAN_FRONTEND=noninteractive apt-get -qqy update
DEBIAN_FRONTEND=noninteractive apt-get -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' upgrade

## Install Wireguard and basic tools 
DEBIAN_FRONTEND=noninteractive apt-get -qqy -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' install curl git wireguard at unzip resolvconf

systemctl enable --now atd

echo "net.ipv4.ip_forward=1" | tee -a /etc/sysctl.conf
sysctl -p

## Generate Wireguard Public and Private Keys and Preshared Key
/usr/bin/wg genkey | tee /etc/wireguard/privatekey | /usr/bin/wg pubkey | tee /etc/wireguard/publickey
/usr/bin/wg genpsk | tee /etc/wireguard/presharedkey

## Download Wireguard configuration file 
wget https://raw.githubusercontent.com/greyhoundforty/wireguard-us-east/master/wg0.conf-example -O /etc/wireguard/wg0.conf

## Update Wireguard configuration with client public key, client preshared key, and server private key
export PRESHARED_KEY=${client_preshared_key}
export CLIENT_PUBLIC_KEY=${client_public_key}
sed -i "s|CLIENT_PUBLIC_KEY_PLACEHOLDER|$CLIENT_PUBLIC_KEY|" /etc/wireguard/wg0.conf
sed -i "s|PRESHARED_KEY_PLACEHOLDER|$PRESHARED_KEY|" /etc/wireguard/wg0.conf

PRIVATE_KEY=`cat /etc/wireguard/privatekey`
sed -i "s|PRIVATE_KEY_PLACEHOLDER|$PRIVATE_KEY|" /etc/wireguard/wg0.conf

## Enable Wireguard interface on next boot
systemctl enable wg-quick@wg0

## Add script for adding peer
wget https://raw.githubusercontent.com/greyhoundforty/wireguard-us-east/master/add-wg-peer.sh -O /root/add-wg-peer.sh
sed -i "s|CLIENT_PUBLIC_KEY_PLACEHOLDER|$CLIENT_PUBLIC_KEY|" /root/add-wg-peer.sh
chmod +x /root/add-wg-peer.sh

## Wait one minute and then reboot instance. This is needed to pick up wireguard module in the updated kernel
/usr/bin/at now + 1 minutes <<END
reboot
END

## Bring up tunnel 5 minutes after every boot up of the instance
cat <<EOF > /var/lib/cloud/scripts/per-boot/schedule-tunnel.sh
#!/bin/bash
/usr/bin/at now + 5 minutes <<END
/root/add-wg-peer.sh
END

EOF

## Mark tunnel peer script as executable
chmod +x /var/lib/cloud/scripts/per-boot/schedule-tunnel.sh
