# Part 1. Удаленное конфигурирование узла через Ansible

1.Создаем три ВМ manager01 и node01б node02 с помощью vagrant

![vagrant](screenshots/vagrantfile.png)

2. Поднимаем машины с помощью vagrant up

![up](screenshots/up.png)

- Пытаемся подключиться к node01 с manager
![trying](screenshots/sshtry.png)

- Генерируем ssh ключ через ssh-keygen и добавляем его вручную на node01

![trying](screenshots/sshkey.png)

- Успешно подключаемся с manager на node01 через ssh

![ssh](screenshots/sshjoin.png)

- Копируем docker-compose.yml и код сервисов на manager

![copy](screenshots/copy.png)

- скачиваем ansible на manager01 

![download](screenshots/ansible.png)

- Пишем inventory файл с адресом node02 и пингуем через ansible

![ping](screenshots/ping.png)

3. Пишем первый плейбук для Ansible, который выполняет: apt update, устанавливает docker, docker-compose, копирует compose-файл из manager'а и разворачивает микросервисное приложение

![playbook](screenshots/playbook.png)

4. Прогоняем тесты через Postman

![testing](screenshots/testing.png)

5. Формируем три роли

- роль application выполняет развертывание микросервисного приложения при помощи docker-compose;

![application](screenshots/application.png)

- apache устанавливает и запускает стандартный apache сервер;

![apache](screenshots/apache.png)

- postgres устанавливает и запускает postgres, создает базу данных с произвольной таблицей и добавляет в нее три произвольные записи.

![postgres](screenshots/postgres.png)

- Назначитаем первую роль node01 и вторые две роли node02

![roles](screenshots/roles.png)

- Проверяем postman-тестами работоспособность микросервисного приложения

![postman](screenshots/postmanchecking.png)


- Проверяем доступность web страницы apache

![apache](screenshots/apachecheck.png)

- Подключаемся к postgres и отображаем содержимое ранее созданной таблицы

![postgres](screenshots/postgrescheck.png)


# Part 2. Service discovery

1. Пишем два конфигурационных файла для consul сервера и consul клиента 

![consul](screenshots/consulserver.png)

![consul](screenshots/consulclient.png)

2. C помощью Vagrant создаем четыре машины  consul_server, api, manager и db.

![vagrant](screenshots/vagrant.png)

3.  Пишем playbook и четыре роли

- описываем роль для install consul server

![consul_server](screenshots/ansibleserver.png)

- описываем роль для install consul client

![consul_client](screenshots/ansibleclient.png)

- описываем роль для install database

![database](screenshots/ansibledb.png)

- описываем роль для install hotels service

![hotel_service](screenshots/ansiblehotel.png)

Добавляем hotels service в systemd и передаем переменные окружение

![hotelssystemd](screenshots/hotelssystemd.png)

Проверяем функционал через CRUD операции

получаем список отелей GET
![get](screenshots/get.png)

Добавляем отель через POST

![post](screenshots/post.png)

Проверяем что отель добавился

![checking](screenshots/postcheck.png)