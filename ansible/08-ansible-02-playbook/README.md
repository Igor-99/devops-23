# Домашнее задание к занятию 2 «Работа с Playbook»

## Подготовка к выполнению

1. * Необязательно. Изучите, что такое [ClickHouse](https://www.youtube.com/watch?v=fjTNS2zkeBs) и [Vector](https://www.youtube.com/watch?v=CgEhyffisLY).
2. Создайте свой публичный репозиторий на GitHub с произвольным именем или используйте старый.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.
4. Подготовьте хосты в соответствии с группами из предподготовленного playbook.

## Основная часть

1. Подготовьте свой inventory-файл `prod.yml`.
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev).
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
4. Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.

```
[ubuntu@vagrant]# ansible-playbook -i inventory/prod.yml site.yml --check

PLAY [Install Clickhouse] *******************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Clickhouse | Get clickhouse distrib] **************************************************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 2, "gid": 0, "group": "root", "item": "clickhouse-common-static", "mode": "0644", "msg": "Request failed", "owner": "root", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:admin_home_t:s0", "size": 38090, "state": "file", "status_code": 404, "uid": 0, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Clickhouse | Get clickhouse distrib] **************************************************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
ok: [clickhouse-01] => (item=clickhouse-common-static)

TASK [Clickhouse | Install clickhouse packages] *********************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Clickhouse | Create database] *********************************************************************************************************************************************************************************************************
skipping: [clickhouse-01]

PLAY [Install Vector] ***********************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Vector | Download packages] ***********************************************************************************************************************************************************************************************************
changed: [vector-01]

TASK [Vector | Install packages] ***********************************************************************************************************************************************************************
ok: [vector-01]

PLAY RECAP **********************************************************************************************************************************************************************************************************************************
clickhouse-01              : ok=3    changed=0    unreachable=0    failed=0    skipped=1    rescued=1    ignored=0
vector-01                  : ok=2    changed=1    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0
```
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.

```
[ubuntu@vagrant]# ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [Install Clickhouse] *******************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Clickhouse | Get clickhouse distrib] **************************************************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 1, "gid": 0, "group": "root", "item": "clickhouse-common-static", "mode": "0644", "msg": "Request failed", "owner": "root", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:admin_home_t:s0", "size": 38090, "state": "file", "status_code": 404, "uid": 0, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Clickhouse | Get clickhouse distrib] **************************************************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
ok: [clickhouse-01] => (item=clickhouse-common-static)

TASK [Clickhouse | Install clickhouse packages] *********************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Clickhouse | Create database] *********************************************************************************************************************************************************************************************************
changed: [clickhouse-01]

PLAY [Install Vector] ***********************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Vector | Download packages] ***********************************************************************************************************************************************************************************************************
changed: [vector-01]

TASK [Vector | Install packages] ************************************************************************************************************************************************************************************************************

changed: [vector-01]

TASK [Vector | Apply template] **************************************************************************************************************************************************************************************************************
--- before
+++ after: /ubuntu/.ansible/tmp/ansible-local-10199EKJ0tP/tmpbHR2cH/vector.yml.j2
@@ -0,0 +1,15 @@
+sinks:
+    to_clickhouse:
+        compression: gzip
+        database: logs
+        endpoint: http://84.252.143.0:8123
+        healthcheck: true
+        inputs:
+        - demo_logs
+        skip_unknown_fields: true
+        table: vector_table
+        type: clickhouse
+sources:
+    demo_logs:
+        format: syslog
+        type: demo_logs

[WARNING]: The value 0 (type int) in a string field was converted to u'0' (type string). If this does not look like what you expect, quote the entire value to ensure it does not change.
changed: [vector-01]

TASK [Vector | change systemd unit] *********************************************************************************************************************************************************************************************************
--- before: /usr/lib/systemd/system/vector.service
+++ after: /ubuntu/.ansible/tmp/ansible-local-10199EKJ0tP/tmpxwrDdO/vector.service.j2
@@ -5,15 +5,10 @@
 Requires=network-online.target

 [Service]
-User=vector
-Group=vector
-ExecStartPre=/usr/bin/vector validate
-ExecStart=/usr/bin/vector
-ExecReload=/usr/bin/vector validate
+User=ubuntu
+Group=ubuntu
+ExecStart=/usr/bin/vector --config /etc/vector/vector.yml
 ExecReload=/bin/kill -HUP $MAINPID
-Restart=no
-AmbientCapabilities=CAP_NET_BIND_SERVICE
-EnvironmentFile=-/etc/default/vector
-
+Restart=always
 [Install]
 WantedBy=multi-user.target

changed: [vector-01]

RUNNING HANDLER [Start Vector service] 
changed: [vector-01]
***********************************************************************************************************************************************************************PLAY RECAP **********************************************************************************************************************************************************************************************************************************
changed: [vector-01]

clickhouse-01              : ok=4    changed=1    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0
vector-01                  : ok=6    changed=5    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```

8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.

```
[ubuntu@vagrant]# ansible-playbook -i inventory/prod.yml site.yml --diff

PLAY [Install Clickhouse] *******************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Clickhouse | Get clickhouse distrib] **************************************************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.3.3.44.rpm", "elapsed": 0, "gid": 0, "group": "root", "item": "clickhouse-common-static", "mode": "0644", "msg": "Request failed", "owner": "root", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:admin_home_t:s0", "size": 38090, "state": "file", "status_code": 404, "uid": 0, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.3.3.44.noarch.rpm"}

TASK [Clickhouse | Get clickhouse distrib] **************************************************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
ok: [clickhouse-01] => (item=clickhouse-common-static)

TASK [Clickhouse | Install clickhouse packages] *********************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Clickhouse | Create database] *********************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

PLAY [Install Vector] ***********************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] **********************************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Vector | Download packages] ***********************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Vector | Install packages] ************************************************************************************************************************************************************************************************************
ok: [vector-01]

TASK [Vector | Apply template] **************************************************************************************************************************************************************************************************************
[WARNING]: The value 0 (type int) in a string field was converted to u'0' (type string). If this does not look like what you expect, quote the entire value to ensure it does not change.
ok: [vector-01]

TASK [Vector | change systemd unit] *********************************************************************************************************************************************************************************************************
ok: [vector-01]

PLAY RECAP **********************************************************************************************************************************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0
vector-01                  : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.

Ответ: 


---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
