# Ansible & Service Discovery — краткий мануал

## Part 1. Удалённое конфигурирование узла через Ansible

1. Создать 3 VM через Vagrant: `manager`, `node01`, `node02`.
   - Не устанавливать Docker через скрипты при создании VM.
   - Пробросить порты `node01` на локальную машину.
2. Подготовить `manager` как рабочую станцию для удалённого конфигурирования.
3. Проверить ssh-подключение `manager → node01`.
4. Сгенерировать ssh-ключ на `manager` для подключения к `node01`.
5. Скопировать на `manager` исходный код микросервисов и docker-compose файл.
6. Установить Ansible на `manager`.
   - Создать папку `ansible` и inventory-файл.
   - Проверить подключение к узлам через модуль ping.
7. Написать первый плейбук Ansible:
   - `apt update`, установка Docker и docker-compose.
   - Копирование compose-файла и разворачивание микросервисов.
8. Прогнать Postman-тесты для проверки работы приложения.
9. Создать три роли:
   - `application` — развертывание микросервисов через docker-compose.
   - `apache` — установка и запуск Apache сервера.
   - `postgres` — установка Postgres, создание базы, таблицы и 3 записей.
10. Назначить роли:
    - `node01` → `application`.
    - `node02` → `apache` + `postgres`.
11. Проверить Postman-тестами и браузером доступность микросервисов, Apache и Postgres.
12. Сохранить все файлы в `src/ansible01` в личном репозитории.

---

## Part 2. Service Discovery с Consul

1. Написать два конфигурационных файла Consul:
   - `consul_server.hcl` → агент сервер, advertise_addr во внутреннюю сеть Vagrant.
   - `consul_client.hcl` → агент клиент, advertise_addr во внутреннюю сеть Vagrant.
2. Создать 4 VM через Vagrant: `consul_server`, `api`, `manager`, `db`.
   - Пробросить порт 8082 для API и 8500 для UI Consul.
3. Написать плейбук Ansible и четыре роли:
   - `install_consul_server` → установка Consul на `consul_server`, запуск сервиса.
   - `install_consul_client` → установка Consul + Envoy на `api` и `db`, запуск сервисов.
   - `install_db` → установка Postgres на `db`, создание базы `hotels_db`.
   - `install_hotels_service` → установка JDK, копирование кода на `api`, настройка переменных окружения, запуск сервиса (`java -jar`).
4. Проверить работу CRUD-операций над сервисом отелей.
5. Сохранить файлы в `src/ansible02` и `src/consul01` в личном репозитории.
