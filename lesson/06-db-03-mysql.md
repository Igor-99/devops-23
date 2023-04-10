## Задача 1

Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-03-mysql/test_data) и 
восстановитесь из него.

Перейдите в управляющую консоль `mysql` внутри контейнера.

Используя команду `\h` получите список управляющих команд.

Найдите команду для выдачи статуса БД и **приведите в ответе** из ее вывода версию сервера БД.

Подключитесь к восстановленной БД и получите список таблиц из этой БД.

**Приведите в ответе** количество записей с `price` > 300.

В следующих заданиях мы будем продолжать работу с данным контейнером.

## Решение  

Создадим .yml файл:  

```
version: '3.7'

volumes:
 my-db:
services:
 db:
  image: mysql:8
  restart: always
  environment:
    MYSQL_DATABASE: 'revinii_db'
    MYSQL_USER: 'revinii'
    MYSQL_PASSWORD: 'qwerty12'
    MYSQL_ROOT_PASSWORD: 'qwerty21'
  volumes:
    - my-db:/var/lib/mysql
```

Запустим проект  

```
$ docker-compose up -d
Creating volume "root_my-db" with default driver
Pulling db (mysql:8)...
8: Pulling from library/mysql
b4ddc423e046: Pull complete
b338d8e4ffd1: Pull complete
b2b1b06949ab: Pull complete
daf393284da9: Pull complete
1cb8337ae65d: Pull complete
f6c2cc79221c: Pull complete
4cec461351e0: Pull complete
ab6bf0cba08e: Pull complete
8df43cafbd11: Pull complete
c6d0aac53df5: Pull complete
b24148c7c251: Pull complete
Digest: sha256:d8dc78532e9eb3759344bf89e6e7236a34132ab79150607eb08cc746989aa047
Status: Downloaded newer image for mysql:8
Creating root_db_1 ... done
```
Копируем бэкап в запущенный контейнер
```
root@vagrant:~# docker cp test_dump.sql root_db_1:/var/tmp/test_dump.sql
```
Запускаем командную строку в контейнере и восстановим дамп
```
root@vagrant:~# sudo docker exec -it root_db_1 bash
bash-4.4# mysql -u revinii -p revinii_db < /var/tmp/test_dump.sql
```
Версия сервера БД
```
mysql> \s
--------------
mysql  Ver 8.0.32 for Linux on x86_64 (MySQL Community Server - GPL)

Connection id:          26
Current database:       revinii_db
Current user:           revinii@localhost
SSL:                    Not in use
Current pager:          stdout
Using outfile:          ''
Using delimiter:        ;
Server version:         8.0.32 MySQL Community Server - GPL
Protocol version:       10
Connection:             Localhost via UNIX socket
Server characterset:    utf8mb4
Db     characterset:    utf8mb4
Client characterset:    latin1
Conn.  characterset:    latin1
UNIX socket:            /var/run/mysqld/mysqld.sock
Binary data as:         Hexadecimal
Uptime:                 54 min 9 sec

Threads: 2  Questions: 98  Slow queries: 0  Opens: 181  Flush tables: 3  Open tables: 98  Queries per second avg: 0.030
--------------
```
Список таблиц БД
```
mysql> SHOW TABLES;
+-----------------------+
| Tables_in_lodyanyy_db |
+-----------------------+
| orders                |
+-----------------------+
1 row in set (0.00 sec)
```
Приведем в ответе количество записей с price > 300
```
mysql> select count(*) from orders where price > 300;
+----------+
| count(*) |
+----------+
|        1 |
+----------+
1 row in set (0.00 sec)
```

## Задача 2

Создайте пользователя test в БД c паролем test-pass, используя:
- плагин авторизации mysql_native_password
- срок истечения пароля - 180 дней 
- количество попыток авторизации - 3 
- максимальное количество запросов в час - 100
- аттрибуты пользователя:
    - Фамилия "Pretty"
    - Имя "James"

Предоставьте привелегии пользователю `test` на операции SELECT базы `test_db`.
    
Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю `test` и 
**приведите в ответе к задаче**.  

## Решение

Создадим пользователя с требуемыми параметрами:  
```
CREATE USER 'test'@'localhost' IDENTIFIED WITH mysql_native_password BY 'test-pass' WITH MAX_CONNECTIONS_PER_HOUR 100 PASSWORD EXPIRE INTERVAL 180 DAY FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 2 ATTRIBUTE '{"first_name":"James", "last_name":"Pretty"}';
```
Предоставим привелегии пользователю test на операции SELECT:  
```
GRANT SELECT ON revinii_db.* to 'test'@'localhost';
```  
Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получим данные по пользователю test:
```
SELECT * from INFORMATION_SCHEMA.USER_ATTRIBUTES where USER = 'test';
+------+-----------+------------------------------------------------+
| USER | HOST      | ATTRIBUTE                                      |
+------+-----------+------------------------------------------------+
| test | localhost | {"last_name": "Pretty", "first_name": "James"} |
+------+-----------+------------------------------------------------+
1 row in set (0.00 sec)
```

## Задача 3

Установите профилирование `SET profiling = 1`.
Изучите вывод профилирования команд `SHOW PROFILES;`.

Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.

Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:
- на `MyISAM`
- на `InnoDB`  

## Решение

Установим профилирование и изучим вывод профилирования команд:
```
SET profiling = 1 
SHOW PROFILES;
+----------+------------+----------------------------------------------------------------------+
| Query_ID | Duration   | Query                                                                |
+----------+------------+----------------------------------------------------------------------+
|        1 | 0.00094600 | SELECT * from INFORMATION_SCHEMA.USER_ATTRIBUTES where USER = 'test' |
|        2 | 0.00175075 | show databases                                                       |
|        3 | 0.00036200 | SHOW GRANTS                                                          |
+----------+------------+----------------------------------------------------------------------+
3 rows in set, 1 warning (0.00 sec)
```  
В  таблице БД `revinii_db` используется engine InnoDB:
```
 SELECT table_schema,table_name,engine FROM information_schema.tables WHERE table_schema = DATABASE();
+--------------+------------+--------+
| TABLE_SCHEMA | TABLE_NAME | ENGINE |
+--------------+------------+--------+
| revinii_db   | orders     | InnoDB |
+--------------+------------+--------+
1 row in set (0.00 sec)
```
Измените engine и **приведите время выполнения и запрос на изменения из профайлера в ответе**:
```
mysql> SHOW PROFILES;
+----------+------------+------------------------------------+
| Query_ID | Duration   | Query                              |
+----------+------------+------------------------------------+
|        1 | 0.02193775 | ALTER TABLE orders ENGINE = MyISAM |
|        2 | 0.02124875 | ALTER TABLE orders ENGINE = InnoDB |
+----------+------------+------------------------------------+
2 rows in set, 1 warning (0.00 sec)

```  

## Задача 4 

Изучите файл `my.cnf` в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):
- Скорость IO важнее сохранности данных
- Нужна компрессия таблиц для экономии места на диске
- Размер буффера с незакомиченными транзакциями 1 Мб
- Буффер кеширования 30% от ОЗУ
- Размер файла логов операций 100 Мб

Приведите в ответе измененный файл `my.cnf`.

## Решение 

Изучим файл my.cnf:
```
root@vagrant:/# cat /etc/mysql/my.cnf
# Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA

#
# The MySQL  Server configuration file.
#
# For explanations see
# http://dev.mysql.com/doc/mysql/en/server-system-variables.html

[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
secure-file-priv= NULL

# Custom config should go here
!includedir /etc/mysql/conf.d/
```
Изменим его согласно ТЗ (движок InnoDB):
```
root@vagrant:/# cat /etc/mysql/my.cnf
# Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA

#
# The MySQL  Server configuration file.
#
# For explanations see
# http://dev.mysql.com/doc/mysql/en/server-system-variables.html

[mysqld]
pid-file        = /var/run/mysqld/mysqld.pid
socket          = /var/run/mysqld/mysqld.sock
datadir         = /var/lib/mysql
secure-file-priv= NULL

# Custom config should go here
!includedir /etc/mysql/conf.d/
innodb_flush_log_at_trx_commit = 0
innodb_file_format=Barracuda
innodb_log_buffer_size= 1M
key_buffer_size = 300M
max_binlog_size= 100M
```
