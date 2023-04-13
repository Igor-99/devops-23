## Задание 1
4) Было не допустимое количество ядер 1, а допустимое количество ядер: 2, 4
5) scheduling_policy — политика планирования. Чтобы создать прерываемую ВМ, укажите preemptible = true
core_fraction	Базовый уровень производительности vCPU. Выбрав данный уровень производимлсти мы экономим денежные средства на гранте, а прерывание позваляет прервать работу ВМ.
![s1](https://user-images.githubusercontent.com/29104612/231841081-ae67e0b9-880e-4654-8f41-5b91cab69379.png)
![s2](https://user-images.githubusercontent.com/29104612/231841099-24b44fc7-354f-4837-a319-3483d5d572c1.png)

## Задание 4
![s3](https://user-images.githubusercontent.com/29104612/231841330-fc205e51-88c0-4b06-87a0-cf061df18df2.png)

## Задание 7
1) 
```
local.test_list[1]
"staging"
```
2)
```
length(local.test_list)
3
```
3)
```
local.test_map.admin
"John"
```
4)
```
"${local.test_map.admin} is admin for ${local.test_list[2]} server based on OS ${local.servers.stage.image} with ${local.servers.stage.cpu} vcpu, ${local.servers.stage.ram} ram and ${length(local.servers.stage.disks)} virtual disks"
"John is admin for production server based on OS ubuntu-20-04 with 4 vcpu, 8 ram and 2 virtual disks"
```
