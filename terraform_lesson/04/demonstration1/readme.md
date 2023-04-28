# Домашнее задание к занятию "Продвинутые методы работы с Terraform"


## Задание 1
1. Возьмите из [демонстрации к лекции готовый код](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1) для создания ВМ с помощью remote модуля.
2. Создайте 1 ВМ, используя данный модуль. В файле cloud-init.yml необходимо использовать переменную для ssh ключа вместо хардкода. Передайте ssh-ключ в функцию template_file в блоке vars ={} .
Воспользуйтесь [**примером**](https://grantorchard.com/dynamic-cloudinit-content-with-terraform-file-templates/). Обратите внимание что ssh-authorized-keys принимает в себя список, а не строку!
3. Добавьте в файл cloud-init.yml установку nginx.
4. Предоставьте скриншот подключения к консоли и вывод команды ```sudo nginx -t```.

## Ответ:

![task_1_2](https://user-images.githubusercontent.com/29104612/234784213-6b743016-690a-47c2-a519-dfd8fdb86ba5.png)


![task_1_3](https://user-images.githubusercontent.com/29104612/234784225-4ead722d-ccb8-4d4e-ae04-d5af38e7a969.png)


![task_1_4](https://user-images.githubusercontent.com/29104612/234784237-e6f41568-e9ac-46a2-98f0-9eb61fdcd05f.png)



## Задание 2
1. Напишите локальный модуль vpc, который будет создавать 2 ресурса: **одну** сеть и **одну** подсеть в зоне, объявленной при вызове модуля. например: ```ru-central1-a```.
2. Модуль должен возвращать значения vpc.id и subnet.id
3. Замените ресурсы yandex_vpc_network и yandex_vpc_subnet, созданным модулем.
4. Сгенерируйте документацию к модулю с помощью terraform-docs.    
 
Пример вызова:
```
module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  zone = "ru-central1-a"
  cidr = "10.0.1.0/24"
}
```


### Ответ:

![task_2](https://user-images.githubusercontent.com/29104612/234784342-d5867c7c-9399-48f9-a3df-16b4c31bb189.png)

Для генарации документации (файл readme для модуля в директории с модулем):

docker run --rm --volume "$(pwd):/terraform-docs" -u $(id -u) quay.io/terraform-docs/terraform-docs:0.16.0 markdown /terraform-docs

## Задание 3
1. Выведите список ресурсов в стейте.
2. Удалите из стейта модуль vpc.
3. Импортируйте его обратно. Проверьте terraform plan - изменений быть не должно.
Приложите список выполненных команд и вывод.

## Ответ:

![task_3](https://user-images.githubusercontent.com/29104612/234784488-c299f573-f833-4d24-8924-7168dfa4b0aa.png)
