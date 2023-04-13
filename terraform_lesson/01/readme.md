## Задание 1
![1](https://user-images.githubusercontent.com/29104612/230908015-6af1966b-c64e-41b8-a23f-3bdc72aac556.png)

2) Секретные данные храняться в personal.auto.tfvars
3) random_password = v2lUizI3Sk1gZcYC
4) в 24 строке не хватало метки, так как далее мы ссылаемся на нее. в 29 происходило обращение к несуществующей метке
5) 
![2](https://user-images.githubusercontent.com/29104612/230908089-5bf42e1c-4ef5-4f89-ac64-b05068082c6b.png)
```
vagrant@vagrant:~/terraform_lesson/01/src$ sudo docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
a1180d9d06eb   080ed0ed8312   "/docker-entrypoint.…"   3 minutes ago   Up 3 minutes   0.0.0.0:8000->80/tcp   example_v2lUizI3Sk1gZcYC
5cb4bbc9d491   mysql:8        "docker-entrypoint.s…"   4 weeks ago     Up 2 hours     3306/tcp, 33060/tcp    root_db_1
```
6) При запуске вместе с -auto-approve флагом команда создает план на основе изменений, внесенных в инфраструктуру. 
Использование флага очень опасно, поскольку некоторые ошибки могут привести к необратимой потере данных или уничтожению базы данных. 
Эти ошибки будут применены без запроса одобрения.
7)
```
vagrant@vagrant:~/terraform_lesson/01/src$ cat terraform.tfstate
{
  "version": 4,
  "terraform_version": "1.4.4",
  "serial": 16,
  "lineage": "ad7cc7ae-761c-8402-c75e-9cd9c9e18bfc",
  "outputs": {},
  "resources": [],
  "check_results": null
}
```
8) В коде файла main.tf указан параметр keep_locally = true, следовательно файлы храняться локально. Что бы terraform удалил образ необходимо ставить параметр false.
