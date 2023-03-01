## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД
- подключения к БД
- вывода списка таблиц
- вывода описания содержимого таблиц
- выхода из psql

## Решение  
- поднять инстанс PostgresSQL
```
root@vagrant:~# docker pull postgres:13
13: Pulling from library/postgres
bb263680fed1: Already exists
75a54e59e691: Already exists
3ce7f8df2b36: Already exists
f30287ef02b9: Already exists
dc1f0e9024d8: Already exists
7f0a68628bce: Already exists
32b11818cae3: Already exists
48111fe612c1: Already exists
53d17e3561d4: Pull complete
4574cb861f6a: Pull complete
0f24d68ef30d: Pull complete
54bf55f1b694: Pull complete
ed4b4d1b8ce2: Pull complete
Digest: sha256:0876afe95f304506a42c6fcd5b3b272340c394389086dcd33fe4c1ac999ff118
Status: Downloaded newer image for postgres:13
docker.io/library/postgres:13
root@vagrant:~# docker volume create vol1
vol1
root@vagrant:~# docker run --name postgres1 -e POSTGRES_PASSWORD=p123 -d -p 5432:5432 -v vol1:/var/lib/postgresql/data p
ostgres:13
e91d7ef332ee7ceb0a8342e024ba5f8ebd36afe3ef1df9cff4b294b1dc0d0372
root@vagrant:~# docker exec -it postgres1 bash
root@e91d7ef332ee:/# psql -U postgres
psql (13.10 (Debian 13.10-1.pgdg110+1))
Type "help" for help.

```


- вывод списка БД

```
postgres=# \l
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
(3 rows)
```  
- подключение к БД  

```
postgres=# \c postgres
You are now connected to database "postgres" as user "postgres".
```  
- вывод списка таблиц  

```
  postgres=# \dtS
                    List of relations
   Schema   |          Name           | Type  |  Owner
------------+-------------------------+-------+----------
 pg_catalog | pg_aggregate            | table | postgres
 pg_catalog | pg_am                   | table | postgres
 pg_catalog | pg_amop                 | table | postgres
 pg_catalog | pg_amproc               | table | postgres
 pg_catalog | pg_attrdef              | table | postgres
 pg_catalog | pg_attribute            | table | postgres
 pg_catalog | pg_auth_members         | table | postgres
 pg_catalog | pg_authid               | table | postgres
 pg_catalog | pg_cast                 | table | postgres
 pg_catalog | pg_class                | table | postgres
 pg_catalog | pg_collation            | table | postgres
 pg_catalog | pg_constraint           | table | postgres
 pg_catalog | pg_conversion           | table | postgres
 pg_catalog | pg_database             | table | postgres
 pg_catalog | pg_db_role_setting      | table | postgres
 pg_catalog | pg_default_acl          | table | postgres
 pg_catalog | pg_depend               | table | postgres
 pg_catalog | pg_description          | table | postgres
 pg_catalog | pg_enum                 | table | postgres
 pg_catalog | pg_event_trigger        | table | postgres
 pg_catalog | pg_extension            | table | postgres
 pg_catalog | pg_foreign_data_wrapper | table | postgres
 pg_catalog | pg_foreign_server       | table | postgres
 pg_catalog | pg_foreign_table        | table | postgres
 pg_catalog | pg_index                | table | postgres
 pg_catalog | pg_inherits             | table | postgres
 pg_catalog | pg_init_privs           | table | postgres
```  
- вывод описания содержимого таблиц  

```
postgres=# \dS+ pg_aggregate
                                   Table "pg_catalog.pg_aggregate"
      Column      |   Type   | Collation | Nullable | Default | Storage  | Stats target | Description
------------------+----------+-----------+----------+---------+----------+--------------+-------------
 aggfnoid         | regproc  |           | not null |         | plain    |              |
 aggkind          | "char"   |           | not null |         | plain    |              |
 aggnumdirectargs | smallint |           | not null |         | plain    |              |
 aggtransfn       | regproc  |           | not null |         | plain    |              |
 aggfinalfn       | regproc  |           | not null |         | plain    |              |
 aggcombinefn     | regproc  |           | not null |         | plain    |              |
 aggserialfn      | regproc  |           | not null |         | plain    |              |
 aggdeserialfn    | regproc  |           | not null |         | plain    |              |
 aggmtransfn      | regproc  |           | not null |         | plain    |              |
 aggminvtransfn   | regproc  |           | not null |         | plain    |              |
 aggmfinalfn      | regproc  |           | not null |         | plain    |              |
 aggfinalextra    | boolean  |           | not null |         | plain    |              |
 aggmfinalextra   | boolean  |           | not null |         | plain    |              |
 aggfinalmodify   | "char"   |           | not null |         | plain    |              |
 aggmfinalmodify  | "char"   |           | not null |         | plain    |              |
 aggsortop        | oid      |           | not null |         | plain    |              |
 aggtranstype     | oid      |           | not null |         | plain    |              |
 aggtransspace    | integer  |           | not null |         | plain    |              |
 aggmtranstype    | oid      |           | not null |         | plain    |              |
 aggmtransspace   | integer  |           | not null |         | plain    |              |
 agginitval       | text     | C         |          |         | extended |              |
 aggminitval      | text     | C         |          |         | extended |              |
Indexes:
    "pg_aggregate_fnoid_index" UNIQUE, btree (aggfnoid)
Access method: heap
```
- выход из psql
```
postgres=# \q
root@e91d7ef332ee:/#
```

## Задача 2

Используя `psql` создайте БД `test_database`.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.

## Решение

Создадим БД test_database:
```
postgres=# CREATE DATABASE test_database;
CREATE DATABASE
postgres=# \l
                                   List of databases
     Name      |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
---------------+----------+----------+------------+------------+-----------------------
 postgres      | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 template0     | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
               |          |          |            |            | postgres=CTc/postgres
 template1     | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
               |          |          |            |            | postgres=CTc/postgres
 test_database | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
(4 rows)
```
Восстановим бэкап:
```
root@e91d7ef332ee:/# psql -U postgres -d test_database < /var/tmp/test_dump.sql
SET
SET
SET
SET
SET
 set_config
------------

(1 row)

SET
SET
SET
SET
SET
SET
CREATE TABLE
ALTER TABLE
CREATE SEQUENCE
ALTER TABLE
ALTER SEQUENCE
ALTER TABLE
COPY 8
 setval
--------
      8
(1 row)

ALTER TABLE
```
Подключимся к БД test_database, посмотрим список существующих таблиц и соберем статистику с помощью ANALYZE:
```
test_database=# root@5a070ae8235e:/# psql -U lodyanyy -d test_database
psql (13.7 (Debian 13.7-1.pgdg110+1))
Type "help" for help.

test_database=# \dt
         List of relations
 Schema |  Name  | Type  |  Owner   
--------+--------+-------+----------
 public | orders | table | postgres
(1 row)

test_database=#  ANALYZE verbose orders;
INFO:  analyzing "public.orders"
INFO:  "orders": scanned 1 of 1 pages, containing 8 live rows and 0 dead rows; 8 rows in sample, 8 estimated total rows
ANALYZE
```
Найдем столбец таблицы orders с наибольшим средним значением размера элементов в байтах (это title):
```
test_database=# select attname, avg_width from pg_stats where tablename='orders';
 attname | avg_width 
---------+-----------
 id      |         4
 title   |        16
 price   |         4
(3 rows)
```


## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?

## Решение

SQL-транзакция:

```
test_database=# alter table orders rename to orders2;
ALTER TABLE
test_database=# create table orders (id integer, title varchar(80), price integer) partition by range(price);
CREATE TABLE
test_database=# create table orders_2 partition of orders for values from (0) to (499);
CREATE TABLE
test_database=# create table orders_1 partition of orders for values from (499) to (999999999);
CREATE TABLE
test_database=# insert into orders (id, title, price) select * from orders2;
INSERT 0 8
```
Можно изначально исключить "ручное" разбиение при проектировании таблицы orders, если использовать декларативное секционирование.  

## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?

## Решение  

Создадим бэкап:
```
pg_dump -U postgres -d test_database >test_database_dump.sql
```  
Уникальность столбца title можно выполнить следующим образом:
```
test_database=# CREATE unique INDEX title_un ON public.orders_2(title);
CREATE INDEX
```
