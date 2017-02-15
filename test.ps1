# powershell

# INIT -> psql.bat
# set PATH=%PATH%;"c:\Program Files\PostgreSQL\9.6\bin\"

# INSERT MS
osql -E -d test -i create.ms.sql
Measure-Command {osql -E -d test -i insert_1000000.sql -o insert.ms.log}

# INSERT PG
.\psql -U postgres --port 5433 -d test -f create.pg.sql
Measure-Command {.\psql -U postgres --port 5433 -d test -f insert_1000000.sql > insert.pg.log}

# Check
osql -E -d test -Q "SELECT count(*) FROM alog"
.\psql -U postgres --port 5433 -d test -c "SELECT count(*) FROM alog"

# ms/pg int
Measure-Command {osql -E -d test -Q "update alog set deltaT = 0"}
Measure-Command {.\psql -U postgres --port 5433 -d test -c "update alog set deltaT = 0"}

# pg text
update alog set url = left(url, 10)

# ms text
update alog set url = left(cast(url as varchar), 10)