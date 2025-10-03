# Part 1. Готовый Docker
Загружаем образ nginx через docker pull
![pulling ngix](screenshots/nginxpull.png)

Проверяем наличие образа через docker images
![docker images](screenshots/dockerimages.png)

Запускаем контейнер через docker run
![docker run](screenshots/dockerrun.png)

Проверяем что докер работает
![dockerps](screenshots/dockerps.png)

Смотрим информацию о Docker через inspect

![docker inspect](screenshots/dockerinspect.png)


Размер докеры (shmSize) 
![size](screenshots/size.png)

Заспамленные порты 
![port](screenshots/ports.png)

IP adress контейнеры
![ip](screenshots/ipadr.png)

Остановливаем докер контейнер через docker stop и проверяем что он прекратил работу 
![stop](screenshots/stop.png)

Запускаем докер с портами 80 и 443 в контейнере, замапленными на такие же порты на локальной машине, через команду run.
![running](screenshots/runningports.png)

Провеяем, что в браузере по адресу localhost:80 доступна стартовая страница nginx.

![browser](screenshots/browser.png)

Перезапуск докера

![restart](screenshots/restart.png)


# Part 2. Операции с контейнером 

Читаем конфигурационный файл nginx.conf внутри докер контейнера через команду exec.
![conf](screenshots/confcat.png)

Создаем свой nginx.conf 
![custom](screenshots/customconf.png)

Копируем созданный файл nginx.conf внутрь докер-образа через команду docker cp.
![custom](screenshots/confcp.png)

Провеяем, что по адресу localhost:80/status отдается страничка со статусом сервера nginx.

![browsercheck](screenshots/browsercheck.png)

Экспортируем контейнер в файл container.tar через команду export.
![exporting](screenshots/export.png)

Останавливаем и удаляем докер
![deleting](screenshots/dockerdelete.png)

Импортируем контейнер обратно через import
![import](screenshots/import.png)

Запускаем контейнер 
![running](screenshots/running.png)

Проверяем, что по адресу localhost:80/status отдается страничка со статусом сервера nginx.

![localhost](screenshots/imported.png)

# Part 3. Мини веб-сервер

Пишем мини-сервер на C и FastCgi, который будет возвращать простейшую страничку с надписью Hello, World!. (см ./part3)

Запускаем написанный мини-сервер через spawn-fcgi на порту 8080.

![spawn](screenshots/spawn.png)

Пишем свой nginx.conf, который будет проксировать все запросы с 81 порта на 127.0.0.1:8080

![conf](screenshots/confcgi.png)

Запуск локально nginx с написанной конфигурацией.

![start](screenshots/confstart.png)

Проверяем что в браузере по localhost:81 отдается написанная тобой страничка.

![helloworld](screenshots/helloworld.png)

# Part 4. Свой докер

Пишем Dockerfile для создания своего докер-образа

![mydockerfile](screenshots/dockerfile.png)

Собераем написанный докер-образ через docker build при этом указав имя и тег.

![building](screenshots/building.png)

Запускаем собранный докер-образ с маппингом 81 порта на 80 на локальной машине и маппингом папки ./nginx внутрь контейнера по адресу, где лежат конфигурационные файлы nginx'а

![runnin'](screenshots/runningandmapping.png)

Проверяем что по localhost:80 выводится страница мини сервера

![hello](screenshots/helloworld2.png)

Добавляем ./nginx/nginx.conf проксирование странички /status, по которой надо отдавать статус сервера nginx.

![chaning](screenshots/changedconf.png)

Пересобираем и запускаем образ заново 
![restart](screenshots/runningover.png)

Проверяем что теперь по localhost:80/status отдается страничка со статусом nginx

![status](screenshots/status2.png)

# Part 5. Dockle

 Сканируем образ из предыдущего задания через Dockle на предмет ошибок

 ![dockleres](screenshots/dockleres.png)

 Как видим можно заметить ряд ошибок и предупрждений

 ## FATAL   - DKL-DI-0005: Clear apt-get caches 
 Данная ошибка говорит о том, что не очищается кэш после установки пакетов (apt-get update && apt-get install), что увеличивает размер Docker образа

 ## WARN — CIS-DI-0001: Create a user for the container
 Данное предупреждение подразумевает отсутсвия создания юзера, из-за чего все в данном контейнере будет выполняться от имени root, что является плохой практикой с точки зрения безопасности

 ## INFO - CIS-DI-0006: Add HEALTHCHECK instruction to the container image
 Данная рекомендация означает что нет проверки на работу контейнера внутри, инструкция HEALTHCHECK говорит Docker, как проверять, "здоров" ли контейнер внутри. Это полезно для автоматического мониторинга и перезапуска контейнеров в случае ошибок.

## INFO    - CIS-DI-0008: Confirm safety of setuid/setgid files
Данная рекомендация сообщает о наличие файлов с рут правами для всех юзеров. В нашем контейнере мы запускаем всё не от root, а от обычного пользователя user. Это значит, что даже если есть программы с setuid, которые обычно дают повышенные права, внутри контейнера они не смогут навредить, потому что у этого пользователя нет прав администратора. Поэтому риск использовать эти программы для взлома очень низкий. Однако, если таких файлов с setuid слишком много, большой шанс уязвимости в них с помощью которых злоумышленник может получить root права на весь контейнер

## INFO - CIS-DI-0005: Enable Content trust for Docker
Рекомендация говорит: включите Content Trust, чтобы Docker проверял подписи образов и не запускал потенциально опасные контейнеры.
В нашем случае можно проигнорировать данную рекомендацию так как мы используем собственный образ, а не экспортируем его извне

Исправляем ошибки (см Dockerfile) и проверяем еще раз через Dockle
![check](screenshots/docklefixed.png)

# Part 6. Базовый Docker Compose

Пишем docker compose файл с помощью которого поднимаем контейнер из Part 5, и новый контейнер с nginx  который будет проксировать все запросы с 8080 порта на 81 порт первого контейнера.   

![compose](screenshots/conf2.png)

![2conf](screenshots/compose.png)

Останавливаем все прежде запущенные контейнеры

![stop](screenshots/allstop.png)

Билдим и запускаем проект

![building](screenshots/buildstart.png)

Проверяем что в браузере отдается страница

![hello](screenshots/browshello.png)