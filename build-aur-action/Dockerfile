FROM agners/archlinuxarm-arm64v8

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN date
RUN pacman -Syu archlinuxarm-keyring archlinux-keyring
RUN pacman -S base-devel git python --noconfirm --overwrite '*' && sed -i '/E_ROOT/d' /usr/bin/makepkg
COPY entrypoint.sh /entrypoint.sh
