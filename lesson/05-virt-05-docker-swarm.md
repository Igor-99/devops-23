
**Задание №1**   
1. В чём отличие режимов работы сервисов в Docker Swarm кластере: replication и global?  
Отличие в том, что в режиме global метрики передаются всем хостам. В режиме replication метрики передаются только тем хостам,у которых он указан.  
2. Какой алгоритм выбора лидера используется в Docker Swarm кластере?  
Алгоритм выбора лидера следующий. Провидится голосование среди хостов. Каждый хост голосует за кандитата на лидера. Кто наберет больше голосов тот и будет кандитатом на лидера. Каждый сервер может проголосовать не более чем за один сервер в установленный срок. Не более одного кандидата может выйграть.
3. Что такое Overlay Network? Это оверлейная сеть. Она позволяет соединять несколько сервисов Docker и позволяет службам Docker Swarm взаимодействовать друг с другом. Применение такого типа сети устраняет необходимость проведения маршрутизации между контейнерами.  
  
**Задание №2**   
Создали Docker Swarm кластер в Яндекс.Облаке.
![Снимок экрана от 2021-11-22 12-55-52](https://user-images.githubusercontent.com/87299405/142831774-ed41cdb7-b013-4437-9456-53af5e592adb.png)
   
**Задание №3**   
![Снимок экрана от 2021-11-22 13-05-22](https://user-images.githubusercontent.com/87299405/142833067-12114902-398a-4560-9b39-448b7649731b.png)
  
