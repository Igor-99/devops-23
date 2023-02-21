### Домашнее задание к занятию "6.2. SQL"

#### Введение

Перед выполнением задания вы можете ознакомиться с 
[дополнительными материалами](https://github.com/netology-code/virt-homeworks/tree/master/additional/README.md).

#### Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.  

docker-compose.yml:
```yaml
version: '3.6'

volumes:
 data: {}
 backup: {}
services:
 postgres:
  image: postgres:12
  container_name: psql
  ports:
    - "0.0.0.0:5432:5432"
  volumes:
    - data:/home/postgresql/data
    - backup:/home/postgresql/backup
  environment:
    POSTGRES_USER: "revinii"
    POSTGRES_PASSWORD: "1111"
    POSTGRES_DB: "pg_db"
```
```bash
root@vagrant:~# root@vagrant:~# docker-compose up -d
Creating psql ... done
root@vagrant:~# docker exec -it psql bash
root@3b65cbc578a0:/# export PGPASSWORD=1111 && psql -h localhost -U revinii pg_db
psql (12.14 (Debian 12.14-1.pgdg110+1))
Type "help" for help.

pg_db=#
```

#### Задача 2

В БД из задачи 1: 
- создайте пользователя test-admin-user и БД test_db
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
- создайте пользователя test-simple-user  
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db

Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)

Приведите:
- итоговый список БД после выполнения пунктов выше,
- описание таблиц (describe)
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
- список пользователей с правами над таблицами test_db
```bash
pg_db=# CREATE USER "admin-user";
CREATE ROLE
pg_db=# CREATE DATABASE test_db;
CREATE DATABASE
pg_db=# CREATE TABLE orders ( id SERIAL, наименование VARCHAR, цена INTEGER, PRIMARY KEY (id));
CREATE TABLE
pg_db=# CREATE TABLE clients (id SERIAL, фамилия VARCHAR, "страна проживания" VARCHAR, заказ INTEGER, PRIMARY KEY (id), CONSTRAINT fk_заказ FOREIGN KEY(заказ) REFERENCES orders(id));
CREATE TABLE
pg_db=# CREATE INDEX ON clients("страна проживания");
CREATE INDEX
pg_db=# GRANT ALL ON TABLE orders, clients TO "admin-user";
GRANT
pg_db=# CREATE USER "simple-user" WITH PASSWORD '1111';
CREATE ROLE
pg_db=# GRANT CONNECT ON DATABASE pg_db TO "simple-user";
GRANT
pg_db=# GRANT USAGE ON SCHEMA public TO "simple-user";
GRANT
pg_db=# GRANT SELECT, INSERT, UPDATE, DELETE ON orders, clients TO "simple-user";
GRANT
```
- итоговый список БД после выполнения пунктов выше,
```
pg_db=# \l+
                                                                   List of databases
   Name    |  Owner  | Encoding |  Collate   |   Ctype    |    Access privileges    |  Size   | Tablespace |                Description
-----------+---------+----------+------------+------------+-------------------------+---------+------------+--------------------------------------------
 pg_db     | revinii | UTF8     | en_US.utf8 | en_US.utf8 | =Tc/revinii            +| 8121 kB | pg_default |
           |         |          |            |            | revinii=CTc/revinii    +|         |            |
           |         |          |            |            | "simple-user"=c/revinii |         |            |
 postgres  | revinii | UTF8     | en_US.utf8 | en_US.utf8 |                         | 7969 kB | pg_default | default administrative connection database
 template0 | revinii | UTF8     | en_US.utf8 | en_US.utf8 | =c/revinii             +| 7825 kB | pg_default | unmodifiable empty database
           |         |          |            |            | revinii=CTc/revinii     |         |            |
 template1 | revinii | UTF8     | en_US.utf8 | en_US.utf8 | =c/revinii             +| 7825 kB | pg_default | default template for new databases
           |         |          |            |            | revinii=CTc/revinii     |         |            |
 test_db   | revinii | UTF8     | en_US.utf8 | en_US.utf8 |                         | 7825 kB | pg_default |
(5 rows)

```
- описание таблиц (describe)
```
pg_db=# \d+ clients
                                                           Table "public.clients"
      Column       |       Type        | Collation | Nullable |               Default               | Storage  | Stats target | Description
-------------------+-------------------+-----------+----------+-------------------------------------+----------+--------------+-------------
 id                | integer           |           | not null | nextval('clients_id_seq'::regclass) | plain    |              |
 фамилия           | character varying |           |          |                                     | extended |              |
 страна проживания | character varying |           |          |                                     | extended |              |
 заказ             | integer           |           |          |                                     | plain    |              |
Indexes:
    "clients_pkey" PRIMARY KEY, btree (id)
    "clients_страна проживания_idx" btree ("страна проживания")
Foreign-key constraints:
    "fk_заказ" FOREIGN KEY ("заказ") REFERENCES orders(id)
Access method: heap

pg_db=# \d+ orders
                                                        Table "public.orders"
    Column    |       Type        | Collation | Nullable |              Default               | Storage  | Stats target | Description
--------------+-------------------+-----------+----------+------------------------------------+----------+--------------+-------------
 id           | integer           |           | not null | nextval('orders_id_seq'::regclass) | plain    |              |
 наименование | character varying |           |          |                                    | extended |              |
 цена         | integer           |           |          |                                    | plain    |              |
Indexes:
    "orders_pkey" PRIMARY KEY, btree (id)
Referenced by:
    TABLE "clients" CONSTRAINT "fk_заказ" FOREIGN KEY ("заказ") REFERENCES orders(id)
Access method: heap
```
- SQL-запрос для выдачи списка пользователей с правами над таблицами pg_db
```sql
SELECT grantee, table_name, privilege_type FROM information_schema.table_privileges WHERE grantee in ('admin-user','simple-user') and table_name in ('clients','orders') order by 1,2,3;
```
- список пользователей с правами над таблицами test_db
```
     grantee   | table_name | privilege_type
-------------+------------+----------------
 admin-user  | clients    | DELETE
 admin-user  | clients    | INSERT
 admin-user  | clients    | REFERENCES
 admin-user  | clients    | SELECT
 admin-user  | clients    | TRIGGER
 admin-user  | clients    | TRUNCATE
 admin-user  | clients    | UPDATE
 admin-user  | orders     | DELETE
 admin-user  | orders     | INSERT
 admin-user  | orders     | REFERENCES
 admin-user  | orders     | SELECT
 admin-user  | orders     | TRIGGER
 admin-user  | orders     | TRUNCATE
 admin-user  | orders     | UPDATE
 simple-user | clients    | DELETE
 simple-user | clients    | INSERT
 simple-user | clients    | SELECT
 simple-user | clients    | UPDATE
 simple-user | orders     | DELETE
 simple-user | orders     | INSERT
 simple-user | orders     | SELECT
 simple-user | orders     | UPDATE
(22 rows)
```

#### Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|

Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
- приведите в ответе:
    - запросы 
    - результаты их выполнения.
```sql
pg_db=#  INSERT INTO orders VALUES (1, 'Шоколад', 10), (2, 'Принтер', 3000), (3, 'Книга', 500), (4, 'Монитор', 7000), (5, 'Гитара', 4000);
INSERT 0 5
pg_db=# SELECT * FROM orders;
 id | наименование | цена
----+--------------+------
  1 | Шоколад      |   10
  2 | Принтер      | 3000
  3 | Книга        |  500
  4 | Монитор      | 7000
  5 | Гитара       | 4000
(5 rows)

pg_db=# SELECT count(1) FROM orders;
 count
-------
     5
(1 row)

pg_db=# INSERT INTO clients VALUES (1, 'Иванов Иван Иванович', 'USA'), (2, 'Петров Петр Петрович', 'Canada'), (3, 'Иоганн Себастьян Бах', 'Japan'), (4, 'Ронни Джеймс Дио', 'Russia'), (5, 'Ritchie Blackmore', 'Russia');
INSERT 0 5
pg_db=# SELECT * FROM clients;
 id |       фамилия        | страна проживания | заказ
----+----------------------+-------------------+-------
  1 | Иванов Иван Иванович | USA               |
  2 | Петров Петр Петрович | Canada            |
  3 | Иоганн Себастьян Бах | Japan             |
  4 | Ронни Джеймс Дио     | Russia            |
  5 | Ritchie Blackmore    | Russia            |
(5 rows)

pg_db=# SELECT count(1) FROM clients;
 count
-------
     5
(1 row)
```

#### Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.

Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
 
Подсказка - используйте директиву `UPDATE`.
```sql
pg_db=# UPDATE clients SET "заказ" = (SELECT id FROM orders WHERE "наименование"='Книга') WHERE "фамилия"='Иванов Иван Иванович';
UPDATE 1
pg_db=# UPDATE clients SET "заказ" = (SELECT id FROM orders WHERE "наименование"='Монитор') WHERE "фамилия"='Петров Петр Петрович';
UPDATE 1
pg_db=# UPDATE clients SET "заказ" = (SELECT id FROM orders WHERE "наименование"='Гитара') WHERE "фамилия"='Иоганн Себастьян Бах';
UPDATE 1
pg_db=# SELECT c.* FROM clients c JOIN orders o ON c.заказ = o.id;
 id |       фамилия        | страна проживания | заказ
----+----------------------+-------------------+-------
  1 | Иванов Иван Иванович | USA               |     3
  2 | Петров Петр Петрович | Canada            |     4
  3 | Иоганн Себастьян Бах | Japan             |     5
(3 rows)
```

#### Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

Приведите получившийся результат и объясните что значат полученные значения.
```sql
pg_db=# EXPLAIN SELECT c.* FROM clients c JOIN orders o ON c.заказ = o.id;
                               QUERY PLAN
------------------------------------------------------------------------
 Hash Join  (cost=37.00..57.24 rows=810 width=72)
   Hash Cond: (c."заказ" = o.id)
   ->  Seq Scan on clients c  (cost=0.00..18.10 rows=810 width=72)
   ->  Hash  (cost=22.00..22.00 rows=1200 width=4)
         ->  Seq Scan on orders o  (cost=0.00..22.00 rows=1200 width=4)
(5 rows)

```
```
1. Построчно прочитана таблица orders
2. Создан кеш по полю id для таблицы orders
3. Прочитана таблица clients
4. Для каждой строки по полю "заказ" будет проверено, соответствует ли она чему-то в кеше orders
- если соответствия нет - строка будет пропущена
- если соответствие есть, то на основе этой строки и всех подходящих строках кеша СУБД сформирует вывод

При запуске просто explain, Postgres напишет только примерный план выполнения запроса и для каждой операции предположит:
- сколько процессорного времени уйдёт на поиск первой записи и сбор всей выборки: cost=первая_запись..вся_выборка
- сколько примерно будет строк: rows
- какой будет средняя длина строки в байтах: width
Postgres делает предположения на основе статистики, которую собирает периодический выполня analyze запросы на выборку данных из служебных таблиц.
Если запустить explain analyze, то запрос будет выполнен и к плану добавятся уже точные данные по времени и объёму данных.
explain verbose и explain analyze verbose - для каждой операции выборки будут написаны поля таблиц, которые в выборку попали.
```

#### Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).

Остановите контейнер с PostgreSQL (но не удаляйте volumes).

Поднимите новый пустой контейнер с PostgreSQL.

Восстановите БД test_db в новом контейнере.

Приведите список операций, который вы применяли для бэкапа данных и восстановления.
```bash
root@3b65cbc578a0:/# export PGPASSWORD=1111 && pg_dumpall -h localhost -U revinii > /home/postgresql/backup/test_db.sql
root@3b65cbc578a0:/# ls /home/postgresql/backup/
test_db.sql
root@vagrant:~# docker-compose stop
Stopping psql ... done
root@vagrant:~# docker ps -a
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS                      PORTS     NAMES
3b65cbc578a0   postgres:12   "docker-entrypoint.s…"   24 minutes ago   Exited (0) 13 seconds ago             psql
root@vagrant:~# docker run --rm -d -e POSTGRES_USER=revinii -e POSTGRES_PASSWORD=1111 -e POSTGRES_DB=pg_db -v vagrant_backup:/home/postgresql/backup --name psql2 postgres:12
1c3e7c9e60813ebbf0ec2755c0c6d7aabb894830c6e493c7e297fa034eeaed76
root@vagrant:~# docker ps -a
CONTAINER ID   IMAGE         COMMAND                  CREATED          STATUS                          PORTS      NAMES
1c3e7c9e6081   postgres:12   "docker-entrypoint.s…"   12 seconds ago   Up 10 seconds                   5432/tcp   psql2
3b65cbc578a0   postgres:12   "docker-entrypoint.s…"   25 minutes ago   Exited (0) About a minute ago              psql
root@vagrant:~# docker exec -it psql2  bash
root@1c3e7c9e6081:/# ls /home/postgresql/backup/
test_db.sql
root@1c3e7c9e6081:/# export PGPASSWORD=1111 && psql -h localhost -U revinii -f /home/postgresql/backup/test_db.sql pg_db
root@1c3e7c9e6081:/# psql -h localhost -U revinii pg_db
psql (12.14 (Debian 12.14-1.pgdg110+1))
Type "help" for help.
```
