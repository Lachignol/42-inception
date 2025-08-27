FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install -y vsftpd ftp

COPY ./tools/configurate.sh /configurate.sh

RUN chmod +x /configurate.sh

ENTRYPOINT [ "/configurate.sh" ]
