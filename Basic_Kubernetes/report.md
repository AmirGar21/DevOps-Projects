# Part 1. Использование готового манифеста

## 1. Запускаем окружение Kubernetes с памятью 4 GB.

`minikube start --memory=4096 --cpus=2 --driver-docker`

![kuberstart](screenshots/kuberstart.png)

## 2. Применяем манифест из директории /src/example к созданному окружению Kubernetes.

![examplemanifest](screenshots/example.png)

## 3. Запускаем стандартную панель управления Kubernetes с помощью команды `minikube dashboard`.

![dashboard](screenshots/dashboardcommand.png)

![dashboard](screenshots/dashboard.png)

## 4. Прокидываем туннели для доступа к развернутым сервисам с помощью команды `minikube service -all`

![service](screenshots/service.png)

## 5. Открываем в браузере сервис apache

![apache](screenshots/apache.png)


# Part 2. Написание собственного манифеста

## 1. Пишем yml-файлы манифестов для приложений из src/service

- карту конфигурации со значениями хостов БД и сервисов
![config](screenshots/configmap.png)

- секреты с паролем и логином к БД и ключами межсервисной авторизации

![secrets](screenshots/secret.png)

- поды и сервисы для всех модулей приложения (см. src/manifests/deploy-service.yml)

![services](screenshots/services.png)

## 2. Запускаем приложение через `kubectl apply -f .`

![deploy](screenshots/deploy.png)

## 3. Проверяем статус созданных объектов (секреты, конфигурационная карта, поды и сервисы) в кластере с помощью команд `kubectl get <тип_объекта> <имя_объекта>`

Статус секретов 

![secret](screenshots/describesecret.png)

Статус конфигурационной карты

![secret](screenshots/describeconfig.png)

Статус пода на примере booking service

![pod](screenshots/describepod.png)

Статус сервиса на примере booking service

![service](screenshots/describeservice.png)

## 4. Проверяем наличие правильного значения секрета через декодирование командой `kubectl get secret app-secrets -o jsonpath='{.data.POSTGRES_PASSWORD}' | base64 --decode`

![decode](screenshots/decode.png)

## 5. Проверяем логи приложения через `kubectl logs` на примере booking-service

![logs](screenshots/logs.png)

## 6.  Прокидываем туннели для доступа к gateway service и session service. через `kubectl port-forward`

![session](screenshots/sessionport.png)

![gateway](screenshots/gatewayport.png)

## 7. Проводим тесты postman

![test](screenshots/postman.png)

## 8. Запускаем стандартную панель управления Kubernetes с помощью команды `minikube dashboard`.

![dashboard](screenshots/command.png)

- состояние узлов кластера, загрузка ЦП и память

![nodes](screenshots/nodes.png)

- список запущененых PODS

![pods](screenshots/pods.png)

- логи POD на примере loyalty-service

![logs](screenshots/podlogs.png)

- данные configmap 

![configmap](screenshots/dashboardconf.png)

- данные секретов

![secrets](screenshots/dashboardsecret.png)

## 9. Обновляем приложение (добавляя новую зависимость в pom-файл) и пересобираем его со следующими стратегиями развертывания 
    1. пересоздание (recreate) - сначала удаляются все старые поды, потом создаются новые с обновлённой версией.
    2. последовательное обновление (rolling) - старые поды заменяются новыми постепенно, по одному или партиями.

Добавляем зависимость в pom.xml 

![pom](screenshots/pom.png)

Пушим наши образы на docker hub уже с новой версией 1.1

![hub](screenshots/version.png)

Меняем версию сервисов в yml файле на 1.1

![version](screenshots/newversion.png)

Совершаем переразвертвание через Rolling update

![rolling](screenshots/rollingstarrt.png) засекаем время перед началом развертывания

![rolling](screenshots/rollingend.png) после развертывания

`1757179160 - 1757179012 = 148 секунд`

Добавляем recreate cтратегию развертывания в yml файл ( Rolling Update является стратегию по умолчанию )

![strategy](screenshots/recreate.png)


![recreate](screenshots/recreatestart.png) засекаем время перед началом развертывания

![recreate](screenshots/recreateend.png)  после развертывания

`1757183462  - 1757183433  = 29 секунд`