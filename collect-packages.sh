#!/bin/bash
mkdir /packages
cd /packages
chmod -R a+rw .

pacman -S --noconfirm rclone

cp /build/*/*.pkg* ./
ls

if [ ! -f ~/.config/rclone/rclone.conf ]; then
    mkdir --parents ~/.config/rclone
    echo "[onedrive]" >> ~/.config/rclone/rclone.conf
    echo "type = onedrive" >> ~/.config/rclone/rclone.conf
    echo "drive_type=$RCLONE_ONEDRIVE_DRIVE_TYPE" >> ~/.config/rclone/rclone.conf
    echo "token=$RCLONE_ONEDRIVE_TOKEN" >> ~/.config/rclone/rclone.conf
    echo "drive_id=$RCLONE_ONEDRIVE_DRIVE_ID" >> ~/.config/rclone/rclone.conf
fi


repo-add "./${repo_name:?}.db.tar.gz" ./*pkg*
python3 /sync-packages.py
rm "./${repo_name:?}.db.tar.gz"
rm "./${repo_name:?}.files.tar.gz"

rclone copy ./ "onedrive:${dest_path:?}" --copy-links
