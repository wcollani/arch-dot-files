FROM nfnty/arch-mini

RUN pacman --noconfirm -Syy archlinux-keyring && \
    pacman --noconfirm -Su base-devel ansible && \
    pacman-db-upgrade && \
    useradd -m -G wheel -s /bin/bash wcollani && \
    sed -Ei 's/^# (%wheel.*NOPASSWD.*)/\1/' /etc/sudoers

COPY . /usr/src/ansible-provisioner/
WORKDIR /usr/src/ansible-provisioner
RUN chmod -R 0777 /usr/src/ansible-provisioner

USER wcollani
RUN make run-arch
# CMD run tests
CMD echo success
