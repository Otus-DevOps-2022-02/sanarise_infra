# sanarise_infra
sanarise Infra repository

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
