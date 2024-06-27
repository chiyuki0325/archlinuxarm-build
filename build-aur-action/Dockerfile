FROM agners/archlinuxarm-arm64v8

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN date
RUN ls
RUN pacman -Syu archlinuxarm-keyring archlinux-keyring --noconfirm
RUN pacman -S base-devel git python --noconfirm --overwrite '*' && sed -i '/E_ROOT/d' /usr/bin/makepkg
COPY build-aur-action/entrypoint.sh /entrypoint.sh
