# Part 1. Получение метрик и логов

1. Используем Docker Swarm из первого проекта.

2. Пишем при помощи библиотеки Micrometer сборщики следующих метрик приложения

Для этого добавляем в pom.xml каждого сервиса следующие зависимости 

![pom.xml](screenshots/pom.png)


Также в application.properties добавляем эндпоинты для сбора метрик

![application](screenshots/application.png)

Cобираем следующие метрики приложения

Количество отправленных сообщений в rabbitmq

![rabbitmq](screenshots/rabbitdeliever.png)

Kоличество обработанных сообщений в rabbitmq

![rabbitmq](screenshots/rabbitacknowledged.png)

Kоличество бронирований
![booking](screenshots/booking.png)

Kоличество полученных запросов на gateway

![gateway](screenshots/gateway.png)

Kоличество полученных запросов на авторизацию пользователей

![authorization](screenshots/authorization.png)

3. Добавляем логи приложения с помощью Loki.

Для этого создаем образ Loki

![loki](screenshots/lokistack.png)

Создаем образ Promtail и пишем конфиг который будет собирать логи для контейнера и отправлять их Loki

![promtail](screenshots/promtailstack.png)

/var/lib/docker/containers:/var/lib/docker/containers:ro
Пробрасывает папки с логами Docker контейнеров. Promtail читает .log файлы контейнеров

/var/run/docker.sock:/var/run/docker.sock
 Позволяет Promtail опрашивать Docker API, чтобы автоматически узнавать новые контейнеры и их метки ( имя, ID контейнера)

 ![promtail](screenshots/promtailforloki.png)

 Promtail читает логи Docker-контейнер и добавляет к ним метки (service, container, job) и отправляет в Loki.

 Также добавляем в стек Prometheus Server,  node_exporter, blackbox_exporter, cAdvisor. 

 ![prometheus](screenshots/prometheus.png)

 ![node_exporter](screenshots/node-exporter.png)

 ![blackbox](screenshots/blackbox.png)

 ![Cadvisor](screenshots/cadvisor.png)

 В файле конфигируация Prometheus пишем Job'ы для сбора метрик с каждого источника

 ![jobs](screenshots/jobs1.png)

 ![jobs](screenshots/jobs1.png)

 Проверяем доступность метрик по порту 9090

 ![checking](screenshots/checking9090.png)


# Part 2. Визуализация

Разворачиваем Grafana как новый сервис в стеке

![grafana](screenshots/grafana.png)

Создаем следующие дашборды:
- количество нод;
- количество контейнеров;
- количество стеков;
- использование CPU по сервисам;
- использование CPU по ядрам и узлам;
- затраченная RAM;
- доступная и занятая память;
- количество CPU;
- доступность google.com;
- количество отправленных сообщений в rabbitmq;
- количество обработанных сообщений в rabbitmq;
- количество бронирований;
- количество полученных запросов на gateway;
- количество полученных запросов на авторизацию пользователей;
- логи приложения.

![dashboard](screenshots/dashboard1.png)

![dashboard](screenshots/dashboard2.png)

![dashboard](screenshots/dashboard3.png)

![dashboard](screenshots/dashboard4.png)



# Part 3. Отслеживание критических событий

1. Развертываем Alert Manager как новый сервис в стеке

![alertmanager](screenshots/alertstack.png)

Пишем правила для отслеживания следующих критических событий 
- доступная память меньше 100 Мб;
- затраченная RAM больше 1 Гб;
- использование CPU по сервису превышает 10%

![alertrules](screenshots/alertrules.png)

Добавляем их в конфиг Prometheus, чтобы он отправлял уведомления на alert manager
![alert](screenshots/prometheusalert.png)

Создаем бота в телеграм через Bot Father и получаем токен бота

![bot](screenshots/bot.png)

Через api телеграма получаем Chat ID

![chatid](screenshots/chatid.png)


Пишем конфиг для Alert Manager 
![alertconf](screenshots/alert-manager.png)

Провеярем что сообщения доходят

![tgmsg](screenshots/tg.png)