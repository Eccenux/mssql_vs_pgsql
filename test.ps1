# powershell

# INIT -> psql.bat
# set PATH=%PATH%;"c:\Program Files\PostgreSQL\9.6\bin\"

##
# INSERT
##

# INSERT MS
osql -E -d test -i create.ms.sql
Measure-Command {osql -E -d test -i insert_1000000.ms.sql -o insert.ms.log}

# INSERT PG
.\psql -U postgres --port 5432 -d test -f create.pg.sql
Measure-Command {.\psql -U postgres --port 5432 -d test -f insert_1000000.sql > insert.pg93.log}

##
# Check
##
osql -E -d test -Q "SELECT count(*) FROM alog"
.\psql -U postgres --port 5432 -d test -c "SELECT count(*) FROM alog"

##
# UPDATE
##
# ms/pg int
Measure-Command {osql -E -d test -Q "update alog set deltaT = 0" -o update.ms.log}
Measure-Command {.\psql -U postgres --port 5432 -d test -c "update alog set deltaT = 0" > update.pg93.log}

# pg text
Measure-Command {.\psql -U postgres --port 5432 -d test -c "update alog set url = left(url, 10)" > updatetxt.pg93.log}

# ms text
Measure-Command {osql -E -d test -Q "update alog set url = left(cast(url as varchar), 10)" -o updatetxt.ms.log}