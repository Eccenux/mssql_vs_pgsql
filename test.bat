powershell

rem INIT
set PATH=%PATH%;"c:\Program Files\PostgreSQL\9.6\bin\"

rem INSERT MS
osql -E -d test -i create.ms.sql
Measure-Command {osql -E -d test -i insert_1000000.sql}

rem INSERT PG
psql -U postgres --port 5433 -d test -f create.pg.sql
Measure-Command {psql -U postgres --port 5433 -d test -f insert_1000000.sql}


rem ms/pg int
Measure-Command {psql -U postgres --port 5433 -d test -c "update alog set deltaT = 0"}

rem pg text
update alog set url = left(url, 10)

rem ms text
update alog set url = left(cast(url as varchar), 10)