# Дипломный практикум в Yandex.Cloud
  * [Цели:](#цели)
  * [Этапы выполнения:](#этапы-выполнения)
     * [Создание облачной инфраструктуры](#создание-облачной-инфраструктуры)
     * [Создание Kubernetes кластера](#создание-kubernetes-кластера)
     * [Создание тестового приложения](#создание-тестового-приложения)
     * [Подготовка cистемы мониторинга и деплой приложения](#подготовка-cистемы-мониторинга-и-деплой-приложения)
     * [Установка и настройка CI/CD](#установка-и-настройка-cicd)
  * [Что необходимо для сдачи задания?](#что-необходимо-для-сдачи-задания)
  * [Как правильно задавать вопросы дипломному руководителю?](#как-правильно-задавать-вопросы-дипломному-руководителю)

**Перед началом работы над дипломным заданием изучите [Инструкция по экономии облачных ресурсов](https://github.com/netology-code/devops-materials/blob/master/cloudwork.MD).**

---
## Цели:

1. Подготовить облачную инфраструктуру на базе облачного провайдера Яндекс.Облако.
2. Запустить и сконфигурировать Kubernetes кластер.
3. Установить и настроить систему мониторинга.
4. Настроить и автоматизировать сборку тестового приложения с использованием Docker-контейнеров.
5. Настроить CI для автоматической сборки и тестирования.
6. Настроить CD для автоматического развёртывания приложения.

---
## Этапы выполнения:


### Создание облачной инфраструктуры

Для начала необходимо подготовить облачную инфраструктуру в ЯО при помощи [Terraform](https://www.terraform.io/).

Особенности выполнения:

- Бюджет купона ограничен, что следует иметь в виду при проектировании инфраструктуры и использовании ресурсов;
Для облачного k8s используйте региональный мастер(неотказоустойчивый). Для self-hosted k8s минимизируйте ресурсы ВМ и долю ЦПУ. В обоих вариантах используйте прерываемые ВМ для worker nodes.
- Следует использовать версию [Terraform](https://www.terraform.io/) не старше 1.5.x .

Предварительная подготовка к установке и запуску Kubernetes кластера.

1. Создайте сервисный аккаунт, который будет в дальнейшем использоваться Terraform для работы с инфраструктурой с необходимыми и достаточными правами. Не стоит использовать права суперпользователя
2. Подготовьте [backend](https://www.terraform.io/docs/language/settings/backends/index.html) для Terraform:  
   а. Рекомендуемый вариант: S3 bucket в созданном ЯО аккаунте(создание бакета через TF)
   б. Альтернативный вариант:  [Terraform Cloud](https://app.terraform.io/)  
3. Создайте VPC с подсетями в разных зонах доступности.
4. Убедитесь, что теперь вы можете выполнить команды `terraform destroy` и `terraform apply` без дополнительных ручных действий.
5. В случае использования [Terraform Cloud](https://app.terraform.io/) в качестве [backend](https://www.terraform.io/docs/language/settings/backends/index.html) убедитесь, что применение изменений успешно проходит, используя web-интерфейс Terraform cloud.

Ожидаемые результаты:

1. Terraform сконфигурирован и создание инфраструктуры посредством Terraform возможно без дополнительных ручных действий.
2. Полученная конфигурация инфраструктуры является предварительной, поэтому в ходе дальнейшего выполнения задания возможны изменения.

---
### Решение:
---
1. Создан сервисный аккаунт tf-state с правами editor 

---
![d_1_1.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_1_1.png)
---

2. Подготовил [backend](https://app.terraform.io/app/revinii/workspaces/tf-stage/runs/run-bmScc1YWVtbjZmhi) для Terraform:

---
![d_1_2.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_1_2.png)
---

3. Создайте VPC с подсетями в разных зонах доступности:

---
![d_1_3.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_1_3.png)
---

4-5. Убедился:

---
![d_1_4.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_1_4.png)
---

---
### Создание Kubernetes кластера

На этом этапе необходимо создать [Kubernetes](https://kubernetes.io/ru/docs/concepts/overview/what-is-kubernetes/) кластер на базе предварительно созданной инфраструктуры.   Требуется обеспечить доступ к ресурсам из Интернета.

Это можно сделать двумя способами:

1. Рекомендуемый вариант: самостоятельная установка Kubernetes кластера.  
   а. При помощи Terraform подготовить как минимум 3 виртуальных машины Compute Cloud для создания Kubernetes-кластера. Тип виртуальной машины следует выбрать самостоятельно с учётом требовании к производительности и стоимости. Если в дальнейшем поймете, что необходимо сменить тип инстанса, используйте Terraform для внесения изменений.  
   б. Подготовить [ansible](https://www.ansible.com/) конфигурации, можно воспользоваться, например [Kubespray](https://kubernetes.io/docs/setup/production-environment/tools/kubespray/)  
   в. Задеплоить Kubernetes на подготовленные ранее инстансы, в случае нехватки каких-либо ресурсов вы всегда можете создать их при помощи Terraform.
2. Альтернативный вариант: воспользуйтесь сервисом [Yandex Managed Service for Kubernetes](https://cloud.yandex.ru/services/managed-kubernetes)  
  а. С помощью terraform resource для [kubernetes](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_cluster) создать **региональный** мастер kubernetes с размещением нод в разных 3 подсетях      
  б. С помощью terraform resource для [kubernetes node group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_node_group)
  
Ожидаемый результат:

1. Работоспособный Kubernetes кластер.
2. В файле `~/.kube/config` находятся данные для доступа к кластеру.
3. Команда `kubectl get pods --all-namespaces` отрабатывает без ошибок.


---
### Решение:
---

Подключаемся к master-ноде и проверяем работу `ansible`:

![d_2_1.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_2_1.png)

 Запускаем на master-ноде создание кластера `Kubernetes` через `Kuberspray`:

```
ansible-playbook ~/kuberspray/cluster.yml -i ~/k8s/sample/k8s.ini --diff
```

Результат работы:
---
![d_2_2.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_2_2.png)
---
![d_2_3.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_2_3.png)
---
![d_2_4.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_2_4.png)
---

---
### Создание тестового приложения

Для перехода к следующему этапу необходимо подготовить тестовое приложение, эмулирующее основное приложение разрабатываемое вашей компанией.

Способ подготовки:

1. Рекомендуемый вариант:  
   а. Создайте отдельный git репозиторий с простым nginx конфигом, который будет отдавать статические данные.  
   б. Подготовьте Dockerfile для создания образа приложения.  
2. Альтернативный вариант:  
   а. Используйте любой другой код, главное, чтобы был самостоятельно создан Dockerfile.

Ожидаемый результат:

1. Git репозиторий с тестовым приложением и Dockerfile.
2. Регистри с собранным docker image. В качестве регистри может быть DockerHub или [Yandex Container Registry](https://cloud.yandex.ru/services/container-registry), созданный также с помощью terraform.


---
### Решение:
---

1. Создадим отдельный репозиторий, в который поместим конфиг и файлы для статического веб-сайта:

---
[`nginx`](https://github.com/Igor-99/nginx/tree/main) 
---

Создадим [`Dockerfile`](https://github.com/Igor-99/nginx/blob/main/Dockerfile)

```
FROM nginx:latest
RUN rm -rf /usr/share/nginx/html/*
RUN mkdir -p /usr/share/nginx/html/
COPY index.html /usr/share/nginx/html/
COPY ./images/red.png /usr/share/nginx/html/images/
COPY ./images/blue.jpg /usr/share/nginx/html/images/
```

Создадим образ `nginx-stage` с помощью команды `docker build . -t revinii/nginx-stage`  и проверим созданный образ:

---
![d_3_1.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_3_1.png)
---
![d_3_2.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_3_2.png)
---

Загрузим созданный образ в `Docker Hub`:

---
![d_3_3.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_3_3.png)
---

Ссылка на загруженный образ в `Docker Hub`: [revinii/nginx-stage](https://hub.docker.com/repository/docker/revinii/nginx-stage/general)

Ссылка на репозиторий [`nginx`](https://github.com/Igor-99/nginx)

---
### Подготовка cистемы мониторинга и деплой приложения

Уже должны быть готовы конфигурации для автоматического создания облачной инфраструктуры и поднятия Kubernetes кластера.  
Теперь необходимо подготовить конфигурационные файлы для настройки нашего Kubernetes кластера.

Цель:
1. Задеплоить в кластер [prometheus](https://prometheus.io/), [grafana](https://grafana.com/), [alertmanager](https://github.com/prometheus/alertmanager), [экспортер](https://github.com/prometheus/node_exporter) основных метрик Kubernetes.
2. Задеплоить тестовое приложение, например, [nginx](https://www.nginx.com/) сервер отдающий статическую страницу.

Способ выполнения:
1. Воспользовать пакетом [kube-prometheus](https://github.com/prometheus-operator/kube-prometheus), который уже включает в себя [Kubernetes оператор](https://operatorhub.io/) для [grafana](https://grafana.com/), [prometheus](https://prometheus.io/), [alertmanager](https://github.com/prometheus/alertmanager) и [node_exporter](https://github.com/prometheus/node_exporter). При желании можете собрать все эти приложения отдельно.
2. Для организации конфигурации использовать [qbec](https://qbec.io/), основанный на [jsonnet](https://jsonnet.org/). Обратите внимание на имеющиеся функции для интеграции helm конфигов и [helm charts](https://helm.sh/)
3. Если на первом этапе вы не воспользовались [Terraform Cloud](https://app.terraform.io/), то задеплойте и настройте в кластере [atlantis](https://www.runatlantis.io/) для отслеживания изменений инфраструктуры. Альтернативный вариант 3 задания: вместо Terraform Cloud или atlantis настройте на автоматический запуск и применение конфигурации terraform из вашего git-репозитория в выбранной вами CI-CD системе при любом комите в main ветку. Предоставьте скриншоты работы пайплайна из CI/CD системы.

Ожидаемый результат:
1. Git репозиторий с конфигурационными файлами для настройки Kubernetes.
2. Http доступ к web интерфейсу grafana.
3. Дашборды в grafana отображающие состояние Kubernetes кластера.
4. Http доступ к тестовому приложению.


---
### Решение:
---

Скачал репозиторий `kube-prometeus release-0.11`:

---
![d_4_1.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_4_1.png)
---

Так как нам необходимо организовать HTTP-доступ к web интерфейсу `Grafana`, перед установкой `kube-prometeus` изменим настройки сервиса `Grafana` и настройки сети `Grafana`:

Изменим в `grafana-service.yaml` тип сетевого сервиса с `ClusterIP` на `NodePort` и укажем конкретный порт из диапазона 30000-32767

```
## grafana-service.yaml

apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/component: grafana
    app.kubernetes.io/name: grafana
    app.kubernetes.io/part-of: kube-prometheus
    app.kubernetes.io/version: 9.3.2
  name: grafana
  namespace: monitoring
spec:
  ports:
  - name: http
    port: 3000
    targetPort: http
    nodePort: 30003
  type: NodePort
  selector:
    app.kubernetes.io/component: grafana
    app.kubernetes.io/name: grafana
    app.kubernetes.io/part-of: kube-prometheus
```

Ссылка на измененый [grafana-service.yaml](https://github.com/psvitov/devops-netology/blob/main/Diplom/kube-prometheus/grafana-service.yaml)

Отключим в `grafana-networkPolicy.yaml` настройки ingress:

```
## grafana-networkPolicy.yaml

apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  labels:
    app.kubernetes.io/component: grafana
    app.kubernetes.io/name: grafana
    app.kubernetes.io/part-of: kube-prometheus
    app.kubernetes.io/version: 9.3.2
  name: grafana
  namespace: monitoring
spec:
  egress:
  - {}
  ingress:
  - {}
#  - from:
#    - podSelector:
#        matchLabels:
#          app.kubernetes.io/name: prometheus
#    ports:
#    - port: 3000
#      protocol: TCP
  podSelector:
    matchLabels:
      app.kubernetes.io/component: grafana
      app.kubernetes.io/name: grafana
      app.kubernetes.io/part-of: kube-prometheus
  policyTypes:
  - Egress
  - Ingress
```
Создадим пространство имен и `CRD`:

---
![d_4_2.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_4_2.png)
---
![d_4_3.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_4_3.png)
---

Проверяем работу сервса `Grafana`:

---
![d_4_4.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_4_4.png)
---

Для деплоя тестового приложения, созданного на 3-м этапе используем `Qbec`

Добавим в первоначальный манифест `Ansible`, который использовали для предварительной настройки ВМ кластера установку Qbec.

```
  - name: Install Qbec
    hosts: master
    become: yes
    tasks:

      - name: Create a directory golang
        become_user: root
        ansible.builtin.file:
          path: ~/golang
          state: directory
          mode: '0755'

      - name: Create a directory qbec
        become_user: root
        ansible.builtin.file:
          path: ~/qbec
          state: directory
          mode: '0755'

      - name: Download Golang
        ansible.builtin.get_url:
          url: https://go.dev/dl/go1.19.7.linux-amd64.tar.gz
          dest: /root/golang/go1.19.7.linux-amd64.tar.gz

      - name: Download Qbec
        ansible.builtin.get_url:
          url: https://github.com/splunk/qbec/releases/download/v0.15.2/qbec-linux-amd64.tar.gz
          dest: /root/qbec/qbec-linux-amd64.tar.gz

      - name: Extract Golang
        ansible.builtin.unarchive:
          src: /root/golang/go1.19.7.linux-amd64.tar.gz
          dest: /usr/local
          remote_src: yes

      - name: Extract Qbec
        ansible.builtin.unarchive:
          src: /root/qbec/qbec-linux-amd64.tar.gz
          dest: /usr/local/bin
          remote_src: yes

      - name: Add usr/local/go/bin in $PATH
        become_user: root
        lineinfile:
          path: "~/.bashrc"
          line: "export PATH=$PATH:/usr/local/go/bin"
```

Cоздадим окружение: `stage` с явным указанием параметров в файле:

```
## stage.jsonnet

local prefix = 'stage';

[
  {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: 'diplom-' + prefix,
    },
    spec: {
      replicas: 1,
      selector: {
        matchLabels: {
          app: 'app-' + prefix,
          tier: prefix
        },
      },
      template: {
        metadata: {
          labels: {
            app: 'app-' + prefix,
            tier: prefix
          },
        },
        spec: {
          containers: [
            {
              name: 'front-' + prefix,
              image: 'docker.io/revinii/nginx-stage',
              imagePullPolicy: 'Always',
            },
          ],
        },
      },
    },
  },
]
```

Изменим файл `qbec.yaml` добавим созданные ранее `namespace`:

```
## qbec.yaml

apiVersion: qbec.io/v1alpha1
kind: App
metadata:
  name: qbec-stage
spec:
  environments:
    stage:
      defaultNamespace: qbec
      server: https://127.0.0.1:6443
  vars: {}
```

Проверим созданные файлы на валидацию и развернем окружение:

---
![d_4_5.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_4_5.png)
---

Результат выполнения:

---
![d_4_6.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_4_6.png)
---

Проверяем доступность статического сайта:

---
![d_4_7.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_4_7.png)
---
![d_4_8.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_4_8.png)
---

### Установка и настройка CI/CD

Осталось настроить ci/cd систему для автоматической сборки docker image и деплоя приложения при изменении кода.

Цель:

1. Автоматическая сборка docker образа при коммите в репозиторий с тестовым приложением.
2. Автоматический деплой нового docker образа.

Можно использовать [teamcity](https://www.jetbrains.com/ru-ru/teamcity/), [jenkins](https://www.jenkins.io/), [GitLab CI](https://about.gitlab.com/stages-devops-lifecycle/continuous-integration/) или GitHub Actions.

Ожидаемый результат:

1. Интерфейс ci/cd сервиса доступен по http.
2. При любом коммите в репозиторие с тестовым приложением происходит сборка и отправка в регистр Docker образа.
3. При создании тега (например, v1.0.0) происходит сборка и отправка с соответствующим label в регистри, а также деплой соответствующего Docker образа в кластер Kubernetes.


---
### Решение
---

 Для автоматической сборки docker image и деплоя приложения при изменении кода развернем в ЯО сервер и агент `Jenkins`

 Сформируем манифест `Terraform` для создания инфраструктуры и воспользуемся манифестом `Ansible` для развертывания самого сервиса `Jenkins`

 Чтобы предварительно настроить и сервер и агент, добавим их в инвентори-файл `inventory.ini` через ранее созданный скрипт `terraform.sh`

После создания инфраструктуры настраиваем сам сервер `Jenkins`  и настраиваем новый `Pipeline` для сборки и отправки в регистр Docker образа на основе репозитория с тестовым приложением:

---
![d_5_1.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_5_1.png)
---

Так как нам необходимо, чтобы при каждом коммите происходила сборка образа, то указываем созданный на 2-м этапе репозиторий в пунктах `GitHub project` и  Управление конфигурацией`Git`, проверяем основную ветку репозитория, а так же отмечаем пункт `GitHub hook trigger for GITScm polling`

Шаг сборки добавляем `Выполнить команду shell` и добавим тестовый скрипт:

---
![d_5_2.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_5_2.png)
---

Для того, чтобы происходило отслеживание в репозитории, необходимо настроить `webhook` в самом репозитории:

---
![d_5_3.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_5_3.png)
---

Первую сборку необходимо провести вручную. Проверяем тестовый скрипт:

---
![d_5_4.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_5_4.png)
---

Изменим скрипт: пропишем в нем создание Docker-образа из Dockerfile, а так же отправим Docker-образ на `DockerHub`:

---
![d_5_5.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_5_5.png)
---

Результат выполнения: [Jenkins Job 1](

Проверим запись образа в DockerHub:

---
![d_5_6.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_5_6.png)
---

Внесем изменения в файл `index.html` для проверки автоматической сборки:

---
![d_5_7.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_5_7.png)
---
![d_5_8.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_5_8.png)
---

Происходит автоматический запуск сборки и размещения образа в `DockerHub`

Результат выполнения: [Jenkins Job 2](

Для автоматического деплоя нового docker образа на основе тега доработаем конфигурационныей файлы `Qbec`.

Определим внешнюю переменную `image_tag` в файле `qbec.yaml`:

```
## qbec.yaml

apiVersion: qbec.io/v1alpha1
kind: App
metadata:
  name: qbec-stage
spec:
  environments:
    stage:
      defaultNamespace: qbec
      server: https://127.0.0.1:6443
  vars:
    external:
      - name: image_tag
        default: latest
```

Добавим в конфигурацию `stage.jsonnet` внешнюю переменную для определения тега :

```
## stage.jsonnet

local prefix = 'stage';
local imageTag = std.extVar('image_tag');

[
  {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: 'diplom-' + prefix,
    },
    spec: {
      replicas: 1,
      selector: {
        matchLabels: {
          app: 'app-' + prefix,
          tier: prefix
        },
      },
      template: {
        metadata: {
          labels: {
            app: 'app-' + prefix,
            tier: prefix
          },
	},
	spec: {
          containers: [
            {
              name: 'front-' + prefix,
              image: 'docker.io/revinii/nginx-stage:' + imageTag,
              imagePullPolicy: 'Always',
            },
          ],
	},
      },
    },
  },
]
```

В `Jenkins` к нашему основному заданию добавим создание тегов и задачу тестовой проверки:

---
![d_5_9.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_5_9.png)
---

Так же добавим, при положительном тестировании, а именно при необходимом нам теге, деплой приложения в кластер `Kubernetes`:

---
![d_5_10.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_5_10.png)
---

Проведем тестирование с условием, что при теге `v0.1.10` произойдет деплой приложения в кластер `Kubernetes`:

Дважды запустили задачу вручную, 7-я и 8-я сборка завершились неудачно, потому что не прошли тест

---
![d_5_11.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_5_11.png)
---

Ссылка на [8-ю сборку]
9-я и 10-я сборка пройдет в автоматическом режиме - дважды изменим файл `index.html` в репозитории:

---
![d_5_12.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_5_12.png)
---

Проверим под в кластере `Kubernetes` и веб-страницу:

---
![d_5_13.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_5_13.png)
---
![d_5_14.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_5_14.png)
---
![d_5_15.png](https://github.com/Igor-99/devops-23/blob/main/diplom/img/d_5_15.png)
---


---
## Что необходимо для сдачи задания?

1. Репозиторий с конфигурационными файлами Terraform и готовность продемонстрировать создание всех ресурсов с нуля.
2. Пример pull request с комментариями созданными atlantis'ом или снимки экрана из Terraform Cloud или вашего CI-CD-terraform pipeline.
3. Репозиторий с конфигурацией ansible, если был выбран способ создания Kubernetes кластера при помощи ansible.
4. Репозиторий с Dockerfile тестового приложения и ссылка на собранный docker image.
5. Репозиторий с конфигурацией Kubernetes кластера.
6. Ссылка на тестовое приложение и веб интерфейс Grafana с данными доступа.
7. Все репозитории рекомендуется хранить на одном ресурсе (github, gitlab)

