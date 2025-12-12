sqlite3 -list /var/db/pkg/local.sqlite "select origin as spudro from packages where (select count(*) from deps where origin=spudro) < 1;"
