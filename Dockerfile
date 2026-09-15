FROM arp242/goatcounter:latest

COPY start.sh /start.sh

ENTRYPOINT ["sh", "/start.sh"]
