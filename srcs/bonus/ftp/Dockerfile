FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

# Installe le serveur FTP sécurisé "vsftpd" ainsi que le client FTP (programme ftp)
RUN apt-get install -y vsftpd ftp

COPY ./tools/configurate.sh /configurate.sh

RUN chmod +x /configurate.sh

ENTRYPOINT [ "/configurate.sh" ]
