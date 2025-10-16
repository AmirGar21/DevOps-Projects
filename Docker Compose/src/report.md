# Part 1. Запуск нескольких контейнеров Docker с помощью Docker Compose

Пишем докерфайлы для каждого сервиса

Размер одного образа

![iso](screenshots/isosize.png)

Пишем docker compose и  пробросываем порты для доступа к службе шлюза и службе сеансов на локальной машине.

![porting](screenshots/porting.png)


![porting](screenshots/porting2.png)

Собираем и разворачиваем веб-сервис через compose up, а затем проводим тесты через postman

![test](screenshots/test.png)

# Part 2. Созадние виртуальных машин

Пишем Vagrantfile для одной виртуальной машины, перенося туда весь исходный код сервиса.

![file](screenshots/vagrantfile.png)

Заходим через консоль внутрь машины и проверяем что исходный код был перемещен

![vagrant](screenshots/insidevm.png)

# Part 3. Создание простейшего docker swarm

Модифицируем Vagrantfile для создания трех машин: manager01, worker01, worker02.
Также пишем bash-scripts для инициализации кластера Docker swarm (см. scripts)

Загружаем наши образы на докер хаб и меняем docker-compose.yml для подгрузки образов из репозитория

![docker hub](screenshots/dockeerhub.png)

Поднимием виртуальные машины через vagrant compose up. Запускаем стек сервисов, используя написанный docker-compose файл.

![stack](screenshots/stackrun.png)

Настраиваем прокси на базе nginx для доступа к gateway service и session service по оверлейной сети. Сами gateway service и session service делаем недоступными напрямую.

![nginx](screenshots/nginx.png)

Прогоняем заготовленные тесты через postman 

![test](screenshots/newtest.png)

Используя команды docker, отображаем в отчете распределение контейнеров по узлам.

![noderun](screenshots/noderun.png)

Установливаем отдельным стеком Portainer внутри кластера.

![portainer](screenshots/stackportainer.png)

Отображаем визуализацию распределения задач по узлам с помощью Portainer.

![visual](screenshots/visualisation.png)