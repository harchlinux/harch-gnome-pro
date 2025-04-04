#!/bin/bash

# Set timezone to your desired timezone, for example "Asia/Tehran"
ln -sf /usr/share/zoneinfo/Asia/Tehran /etc/localtime
# Generate /etc/adjtime
hwclock --systohc

# ایجاد fstab
#genfstab -U /mnt >> /mnt/etc/fstab

# فعال کردن سرویس‌ها
systemctl enable --now udisks2
systemctl set-default graphical.target
enabled_services=('choose-mirror.service' 'dbus' 'pacman-init' 'NetworkManager' 'irqbalance' 'vboxservice')
systemctl enable ${enabled_services[@]}
systemctl enable NetworkManager
systemctl enable bluetooth

# پیکربندی xfce4
#cp -r ${ROOT}/etc/skel/.config/ ${ROOT}
#cp -r ${ROOT}/etc/skel/.local/ ${ROOT}
#rm ${ROOT}/etc/arch-release
#rm ${ROOT}/etc/lsb-release
#cp ${ROOT}/etc/harch-release ${ROOT}/etc/lsb-release

# تنظیم کاربر harch
useradd -m -g users -G wheel,power,audio,video,storage -s /bin/zsh harch
echo "harch:harch" | chpasswd
mkdir -p /home/harch/Desktop
chown -R harch:users /home/harch/Desktop
chmod -R 755 /home/harch/Desktop
mkdir -p /home/harch/.config/autostart/
cp /root/.config/autostart/* /home/harch/.config/autostart/

#کپی کردن کانفیگ xfce4 از یوزر روت
cp -r /root/.config/xfce4 /home/harch/.config/

#حذف پس زمینه های پیشفرض xfce4
rm -fr /usr/share/backgrounds/xfce

# فعال کردن lightdm
systemctl enable sddm