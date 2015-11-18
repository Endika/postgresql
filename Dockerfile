FROM endika/base

MAINTAINER me@endikaiglesias.com

ENV ODOO_PASS 'welcome'

RUN aptitude install -y postgresql-9.3
WORKDIR /tmp
VOLUME ["/var/log/postgresql", \
        "/var/log/supervisor", \
        "/etc/postgresql/9.3/main", \
        "/var/lib/postgresql/9.3/main"]


USER postgres
RUN echo "CREATE USER odoo WITH PASSWORD $ODOO_PASS;" | psql
RUN echo "ALTER USER odoo WITH SUPERUSER;" | psql
CMD ["postgres"]
EXPOSE 5432
