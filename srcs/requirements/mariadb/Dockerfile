FROM debian:bookworm

RUN apt-get update -y && apt-get install -y mariadb-server mariadb-client

COPY conf/mariadb.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

CMD ["/bin/bash", "/tools/mariadb_setup.sh"]
