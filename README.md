# mssql vs pgsql -- large data sets updates
This repo contains helper files and results of some tests for MS SQL and PG SQL.
These tests were meant to compare time performance of engines when updating one column in many rows.

Important files
-------------------------
* `results.ods` -- summary of my test results. Tests were done in MS SQL 2016 Express and PG SQL 9.6. So both free engines.
* `generate.php` -- simple inserts generator. Roughly simulates parts of an access log data.
* `test.ps1` -- contains commands I used to test. That's for copy-pasting. Not an actual test script.

Tests execution
-------------------------
Just a note about results -- they are more of comparatory then a benchmark.
They are meant to compare engines tested in the same enviroment. Not to test my computer.

Tests where run with the same apps and services running.

1. First part (100k rows) was run with managment tools (MS SQL Server Management Studio and pgAdmin 4).
2. Second part (1M rows) was rum with console tools (via `powershell` for easy time measuring).
