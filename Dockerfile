FROM endika/base

MAINTAINER me@endikaiglesias.com

ENV ODOO_PASS 'welcome'

RUN aptitude install -y postgresql-9.3
WORKDIR /tmp
VOLUME ["/var/log/postgresql", \
        "/var/log/supervisor", \
        "/etc/postgresql/9.3/main", \
        "/var/lib/postgresql/9.3/main"]

RUN locale-gen en_US en_US.UTF-8 es_ES es_ES.UTF-8 && \
	dpkg-reconfigure locales && \
	pg_dropcluster 9.3 main && \
	pg_createcluster 9.3 main && \
	/etc/init.d/postgresql restart

USER postgres
RUN psql -c "CREATE USER odoo WITH PASSWORD $ODOO_PASS;"
RUN psql -c "ALTER USER odoo WITH SUPERUSER;"
CMD ["postgres"]
EXPOSE 5432
