# Домашнее задание к занятию 7 «Жизненный цикл ПО»

## Подготовка к выполнению

1. Получить бесплатную версию [Jira](https://www.atlassian.com/ru/software/jira/free).
2. Настроить её для своей команды разработки.
3. Создать доски Kanban и Scrum.

## Основная часть

Необходимо создать собственные workflow для двух типов задач: bug и остальные типы задач. Задачи типа bug должны проходить жизненный цикл:

1. Open -> On reproduce.
2. On reproduce -> Open, Done reproduce.
3. Done reproduce -> On fix.
4. On fix -> On reproduce, Done fix.
5. Done fix -> On test.
6. On test -> On fix, Done.
7. Done -> Closed, Open.

![Схемы  workflow для bug](https://github.com/Igor-99/devops-23/assets/29104612/e9ecce61-cf39-42f5-909a-190db37c0e70)

Остальные задачи должны проходить по упрощённому workflow:

1. Open -> On develop.
2. On develop -> Open, Done develop.
3. Done develop -> On test.
4. On test -> On develop, Done.
5. Done -> Closed, Open.

![Схемы  workflow для всех](https://github.com/Igor-99/devops-23/assets/29104612/8d12fac4-ee3d-439e-90d7-fd576b989d53)

![Схемы  workflow](https://github.com/Igor-99/devops-23/assets/29104612/0e6678fe-f965-4a4b-a862-d756348ef6e6)

**Что нужно сделать**

1. Создайте задачу с типом bug, попытайтесь провести его по всему workflow до Done. 
![Задание 1](https://github.com/Igor-99/devops-23/assets/29104612/ef77f2e6-8dd2-49d0-b82a-fe2bd548872f)
1. Создайте задачу с типом epic, к ней привяжите несколько задач с типом task, проведите их по всему workflow до Done. 
Выглядит так же как и скрин выше
1. При проведении обеих задач по статусам используйте kanban. 
1. Верните задачи в статус Open.
1. Перейдите в Scrum, запланируйте новый спринт, состоящий из задач эпика и одного бага, стартуйте спринт, проведите задачи до состояния Closed. Закройте спринт.
все отлично отработало
![1](https://github.com/Igor-99/devops-23/assets/29104612/2a1daf04-6419-4b56-acba-838b31a34a91)
2. Если всё отработалось в рамках ожидания — выгрузите схемы workflow для импорта в XML. Файлы с workflow и скриншоты workflow приложите к решению задания.

[схема workflow для остальных статусов](./lesson/images/All.xml) 
---
[схема workflow для статуса bug](./lesson/images/Bug.xml) 

---
### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
