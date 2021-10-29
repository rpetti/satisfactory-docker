FROM steamcmd/steamcmd:ubuntu

RUN apt-get update && apt-get install -y supervisor bash rsync && rm -rf /var/lib/apt/lists/*

RUN useradd -d /home/satisfactory satisfactory

EXPOSE 15777/udp
EXPOSE 15000/udp
EXPOSE 7777/udp

COPY supervisord.conf /etc/supervisord.conf
COPY auto-update.sh /
COPY satisfactory.sh /

VOLUME ["/data/Satisfactory", "/saves"]

RUN mkdir -p /home/satisfactory/.config/Epic/FactoryGame/Saved/ /saves && \
    ln -s /saves /home/satisfactory/.config/Epic/FactoryGame/Saved/SaveGames && \
    chown -R satisfactory:satisfactory /data
    chown -R satisfactory:satisfactory /home/satisfactory && \
    chown satisfactory:satisfactory /saves

ENTRYPOINT [ ]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
