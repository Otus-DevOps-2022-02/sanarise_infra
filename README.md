# sanarise_infra
sanarise Infra repository

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
