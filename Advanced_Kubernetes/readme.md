# K3s Cluster Deployment — краткий мануал

## Part 1. Развёртывание кластера

### 1. Подготовка виртуальных машин
- Получить 3 виртуальные машины для кластера.

### 2. Установка k3s
- Установить k3s на всех трёх машинах.  
- Не использовать стандартный Ingress Controller: `--disable=traefik`.  
- Подключить рабочие узлы к мастеру:
  - На мастере: `k3s server ...`  
  - На worker: `k3s agent --server <адрес_мастера> --token <NODE_TOKEN>`  

### 3. Настройка Ingress и сертификатов
- Установить Nginx Ingress Controller через официальный манифест с GitHub.  
- Получить доменное имя.  
- Установить cert-manager для генерации wildcard-сертификата.  
- Создать ресурс Ingress для личного домена, используя Nginx Ingress Controller и сертификат.  

### 4. Настройка хранения и запуск приложения
- Создать Persistent Volume (PV) для PostgreSQL.  
- Развернуть приложение через соответствующий манифест.  
- Прогнать функциональные тесты Postman и проверить работоспособность.  

### 5. Мониторинг
- Установить и запустить Prometheus Operator.  
- Проверить состояние Pods в namespace `monitoring`:
  ```bash
  kubectl get pods -n monitoring
