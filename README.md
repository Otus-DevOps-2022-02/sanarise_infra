# sanarise_infra
sanarise Infra repository

# Занятие 8. Знакомство с Terraform

 1. Основное задание
    - Установлен tfswitch для управления разными версиями Terraform.
       - По директиве `~> 0.12.0` установилась версия 0.12.31
    - Установлен provider.yandex v0.73.0 (по директиве `~> 0.35`).
    - Создан отдельный сервисный аккаунт для терраформа и файл ключей для него.
    - Создан ресурс `yandex_compute_instance.reddit-app` из образа `reddit-base-1649162103`.
    - Сгенерированы и добавлены ключи для доступа по SSH.
    - `nat_ip_address` reddit-app-хоста вынесен во output-переменные.
    - Добавлены провиженеры для развертывания приложения.
    - Все строковые значения, id, пути файлов вынесены в variables.
      - объявления в файле `variables.tf`
      - значения в файле `terraform.tfvars`
 2. Дополнительное задание
    - С помощью ресурсов `yandex_alb_load_balancer`, `yandex_alb_http_router`, `yandex_alb_backend_group`, `yandex_alb_target_group`, `yandex_alb_virtual_host` описан HTTP-балансировщик в файле `lb.tf`.
    - Дублировать описание reddit-app для создания второго хоста не стал даже пробовать – не очень интересно ). Мне, как разработчику, отрицательные стороны количественного масштабирования методом копипастинга давно понятны: не гибко, громоздко, высокая вероятность возникновения глупых, но трудновыявляемых при этом ошибок.
    - С помощью параметра ресурса `count`, а также подгляденных в соседних репозиториях конструкций `*` и `dynamic` все-таки осилил задание кол-ва инстансов reddit-app с помощью входной переменной.
      - поочередное отключение `puma.service` показывает, что балансер вроде как рабоает правильно, т.е. healthcheck работает и не шлет запросы на отвалившийся инстанс.

## Вывод последнего terraform.apply
```
Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

Outputs:

external_ip_address_alb = [
  {
    "address" = "51.250.64.127"
  },
]
external_ip_address_app = [
  "51.250.78.38",
  "51.250.67.250",
]
```

# Занятие 7. Модели управления инфраструктурой. Подготовка образов с помощью Packer

 1. Создан шаблон `ubuntu16.json` для настройки хоста с предустановленными Ruby и MongoDB.
 2. Поведена параметризация шаблона `ubuntu16.json` переменными `yc_folder_id`, `yc_sa_key_file`, `yc_subnet_id`.
 3. **Доп. задание** Создан шаблон `immutable.json` для настройки хоста с запущенным приложением.
 4. **Доп. задание** Создан скрипт `create-reddit-vm.sh` создающий экземпляр виртуальной машины из образа, полученного в задании 3.

## URL reddit-full хоста

```
http://51.250.80.31:9292/
```

# Занятие 6. Основные сервисы Yandex Cloud

 1. Скрипт создания виртуальной машины с помощью [yc compute instance create](https://cloud.yandex.ru/docs/cli/cli-ref/managed-services/compute/instance/create) помещен в `yc_compute_instance_create.sh`
    - добавлена обязательная опция `--zone`
    - добавлена опция `--core-fraction=20`, чтобы снизить стоимость эксплуатации
 2. Созданы скрипты `install_ruby.sh`, `install_mongodb.sh`, `deploy.sh`, содержащие команды для пуска/наладки reddit-app-хоста.
 3. **Доп. задание** Скрипт `yc_metadata_from_file.sh` содержит вызов `yc` с передачей ему опции `--metadata-from-file` со значением `user-data=./metadata.yaml`. В файле метаданных производится настройка пользователя, и выполняются команды, скачивающие с GitHub ранее написанные скрипты и запускающие их. Таким образом вызова этой команды достаточно чтобы развернуть reddit-app-хост вместе с приложением.
[Метаданные виртуальной машины](https://cloud.yandex.ru/docs/cli/cli-ref/managed-services/compute/instance/create)
[Cloud config examples](https://cloudinit.readthedocs.io/en/latest/topics/examples.html)

``` shell
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --cores=2 \
  --core-fraction=20 \
  --zone=ru-central1-a \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4,nat-address=51.250.71.229 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=./metadata.yaml
```

## IP-адреса хостов

```
testapp_IP = 51.250.71.229
testapp_port = 9292
```

# Занятие 5. Знакомство с облачной инфраструктурой и облачными сервисами

## Самостоятельные задания.
 - > Исследовать способ подключения к `someinternalhost` в одну команду из вашего рабочего устройства.

   Можно использовать вызов с опцией `-J`. Формат `ssh -J <jump-basionhost> <target-someinternalhost>`. [Демо](https://asciinema.org/a/4C1kSacuLlQdXhJB2eMsWXRM1)  [Источкик](https://habr.com/ru/company/cloud4y/blog/530516/)
 - > Предложить вариант решения для подключения из консоли при помощи команды вида `ssh someinternalhost` из локальной консоли рабочего устройства.

   Можно прописать в файле `~/.ssh/config` хост с именем `someinternalhost` в формате ниже. [Демо](https://asciinema.org/a/kaVv5ecZe26c29jrv1SmRp9Ya) [Источкик](https://man.openbsd.org/ssh_config)
   ```
   Host someinternalhost
	ProxyJump appuser@<jump-basionhost>
	HostName <target-someinternalhost>
	User appuser
	IdentityFile ~/.ssh/appuser
   ```
 - > С помощью сервисов sslip.io/xip.io и Let’s Encrypt реализуйте использование валидного сертификата для панели управления VPN- сервера.

   Публичный IP адрес bastion-хоста `51.250.67.19`. Соотвественно прописываем в настройках pritunl параметр `Lets Encrypt Domain` в `51-250-67-19.sslip.io`.
   После этого pritunl сам подтягивает TLS сертификат с Let's Encrypt. [Источник](https://docs.pritunl.com/docs/letsencrypt-ssl-certificate)

## IP-адреса хостов

```
bastion_IP = 51.250.67.19
someinternalhost_IP = 10.128.0.20
```
