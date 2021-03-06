FROM steamcmd/steamcmd:ubuntu

RUN apt-get update && apt-get install -y curl ca-certificates supervisor bash rsync busybox-syslogd && rm -rf /var/lib/apt/lists/*

RUN useradd -d /home/satisfactory satisfactory

EXPOSE 15777/udp
EXPOSE 15000/udp
EXPOSE 7777/udp

ENV HEARTBEAT_INTERVAL 30

COPY supervisord.conf /etc/supervisord.conf
COPY auto-update.sh /
COPY satisfactory.sh /
COPY bootstrap.sh /
COPY heartbeat.sh /

VOLUME ["/data/Satisfactory", "/saves"]

RUN mkdir -p /home/satisfactory/.config/Epic/FactoryGame/Saved/ /data /saves && \
    ln -s /saves /home/satisfactory/.config/Epic/FactoryGame/Saved/SaveGames && \
    chown -R satisfactory /data && \
    chown -R satisfactory /home/satisfactory && \
    chown satisfactory /saves

ENTRYPOINT [ ]
CMD ["/bootstrap.sh"]
