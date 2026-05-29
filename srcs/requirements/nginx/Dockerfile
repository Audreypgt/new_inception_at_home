FROM debian:bookworm

RUN apt-get update -y 
RUN apt-get install -y nginx openssl
RUN rm -rf /var/lib/apt/lists/*


# TLS part
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key \
-subj "/C=FR/L=Marseille/O=42/CN=apeuget.42.fr/UID=apeuget42"
# we generate an SSL certificate with a precise format (-x509), -nodes allows us to bypass the password
# asked by the command, with -out and -keyout, we give the storing places for the certificate and the key,
# at this point, the command would ask us for informations on the user for the certificate, to avoid the build
# from being interrupted, we add -subj to give them directly in the command (see IBM link for details)

# NGINX folders creation
RUN chown -R www-data:www-data /etc/nginx/
RUN chmod 755 /etc/nginx/
RUN mkdir -p /var/run/nginx
# folder to store config files


EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
# tells nginx to run in the foreground instead of the background like a daemon (whence the daemon off)
# to prevent it from exiting abruptly after turning it on
