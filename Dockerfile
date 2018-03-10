FROM debian:stretch

ARG mc_ver="1.12.2"
ARG mc_client="https://launcher.mojang.com/mc/game/1.12.2/client/0f275bc1547d01fa5f56ba34bdc87d981ee12daf/client.jar"

RUN apt update
RUN apt install -y gnupg wget
RUN wget -O - https://overviewer.org/debian/overviewer.gpg.asc | apt-key add -
RUN echo "deb http://overviewer.org/debian ./" >> /etc/apt/sources.list
RUN apt update
RUN apt install -y minecraft-overviewer

ADD ${mc_client} /home/daemon/.minecraft/versions/${mc_ver}/${mc_ver}.jar

RUN chown -R 1000:1000 /home/daemon
ENV HOME=/home/daemon

USER 1000:1000

CMD ["/usr/bin/overviewer.py", "--config=/minecraft/overviewer.cfg"]
