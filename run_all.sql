:ON ERROR EXIT

-- Bu dosyayı proje klasöründen sqlcmd ile veya SSMS SQLCMD Mode açıkken çalıştırın.
-- Örnek:
-- sqlcmd -S .\SQLEXPRESS -E -C -f 65001 -i run_all.sql

:r .\create.sql
:r .\veriler.sql
:r .\function.sql
:r .\view.sql
:r .\sp.sql
:r .\trigger.sql
:r .\index.sql
