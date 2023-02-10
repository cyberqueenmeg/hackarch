FROM archlinux

WORKDIR /root/
RUN pacman -Syyuu --noconfirm --needed --overwrite='*'

RUN touch /root/.ssh/known_hosts
RUN ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN curl -O https://blackarch.org/strap.sh
RUN chmod +x strap.sh
RUN ./strap.sh
RUN pacman -Syyuu --noconfirm --needed --overwrite='*'

RUN git clone https://github.com/danielmiessler/SecLists.git /opt/seclists
RUN git clone https://github.com/PowerShellMafia/PowerSploit.git /opt/powersploit
ENV PATH=$PATH:/opt/powersploit

EXPOSE 443/tcp
