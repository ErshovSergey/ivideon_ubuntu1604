
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/github.com/ErshovSergey/master/LICENSE) ![Language](https://img.shields.io/badge/language-bash-yellowgreen.svg)
# ivideon_ubuntu1604
Видеорегистратор на Ubuntu 16.04

## Описание
Сервер   [Ivideon](https://www.ivideon.com/) запускается в контейнер Docker. Архив и настройки хранятся вне контейнера.
# Эксплуатация данного проекта.
## Клонируем проект
```shell
git clone https://github.com/ErshovSergey/ivideon_ubuntu1604.git
```
## Собираем
```shell
cd ivideon_ubuntu1604/
docker build  --rm=true --force-rm  -t ershov/ivideon_ubuntu1604 .
```
Создаем папку для хранения настроек, логов и отчетов вне контейнера
```shell
export SHARE_DIR="/mnt/sdb/DOCKER_DATA/ivideon" && mkdir -p $SHARE_DIR
```
Правим файлы настроек:
 - *$SHARE_DIR/credetinals/config.xml* - доступ до ivideon.ru
 - *$SHARE_DIR/credetinals/schedule.json* - расписание работы
 - *$SHARE_DIR/credetinals/videoserverd.config* - камеры, логи

## Запускаем
Определяем адрес на котором будет доступен для клиента сервер и запускаем
```shell
export ip_addr=<ip адрес>
docker run --name ivideon_ubuntu1604 -d --restart=always \
-h ivideon \
-v $SHARE_DIR:/SHARE \
-p $ip_addr:8080:8080 \
ershov/ivideon_ubuntu1604
```
## Удалить контейнер
```shell
docker stop ivideon_ubuntu1604; docker rm -v ivideon_ubuntu1604
```
Если файлов настройки не существуют - используются файлы "по-умолчанию".

### Иструкция по настройке от ivideon

В данном случае потребуется установка сервера через установочный скрипт. Для того, чтобы загрузить скрипт используйте данную команду:
```shell
wget http://downloads-cdn77.iv-cdn.com/bundles/server/install-ivideon-server.sh
```

2.Заходим в каталог *home/<имя пользователя>/Загрузки* и вводим команду для установки программы Ivideon Server
```shell
chmod +x ./install-ivideon-server.sh && sudo ./install-ivideon-server.sh -n
```
3. Далее создаем папку *.IvideonServer* в */home/<имя пользователя>/* - команда 
```shell
mkdir .IvideonServer
```
а затем в папке .IvideonServer создаем файл *videoserverd.config* - команда 
```shell
touch videoserverd.config
```
4.Прописываем необходимые данные в конфигурационном файле (команда nano *videoserverd.config*; для сохранения нажимаем Ctrl+O, для выхода из редактора Ctrl+X), к примеру
 ```
{
"#localView" : {
"passwordHash" : "",
"proxyPort" : 3101,
"streamerPort" : 8080
},
"account" : {
"email" : "",
"password" : "",
"serverName" : "",
"uin" :
},
"archive" : {
"maxEventLogSize" : 0,
"path" : "/home/<имя пользователя>/.IvideonServer/archive",
"sizeLimit" : 14336,
"sizeToCleanup" : 1024,
"useArchive" : false
},
"cameras" : [
{
"id" : 0,
"mdSensitivity" :,
"name" : "",
"recordType" : "",
"rtspTransport" : "",
"urlHigh" : ""
}
],

"logging" : {
"isTruncate" : false,
"path" : "/home/<имя пользователя>/.IvideonServer/service.log"
},
"network" : {
"ivideonProxyHost" : "proxy.ivideon.com"
},
"system" : {
"cwd" : "/home/<имя пользователя>/.IvideonServer"
}
}
```

5.Производим привязку сервера к аккаунту
```
/opt/ivideon/ivideon-server/videoserver --config-filename=/<путь к файлу конфигурации>/videoserverd.config --attach --email="аккаунт" --server-name="имя сервера"
```
далее прописываем
```
sudo /opt/ivideon/ivideon-server/install_services.sh install videoserver user /home/user/.IvideonServer/videoserverd.config
```
Для автоматического запуска сервера при старте системы необходимо выполнить следующее:
```
sudo /opt/ivideon/ivideon-server/init_ctl install <имя пользователя> <путь к файлу конфигурации>
```
Для удаления его из автозапуска:
```
sudo /opt/ivideon/ivideon-server/init_ctl uninstall
```
Для управления видеосервером необходимо использовать скрипт init.d:
```
/etc/init.d/videoserver <start|stop|restart|status>
```
Для добавления и продвинутой настройки камер настоятельно рекомендуется использовать сервер с графическим интерфейсом на отдельной машине, затем скопировать файл конфигурации сервера videoserverd.config в директорию */home/<имя пользователя>/.IvideonServer/videoserverd.config*

Однако при необходимости камеры можно добавить и вручную, для этого в секцию "cameras" конфига нужно добавить словари камер в следующем формате:
 
```
"cameras" : [

     {

        "id" : 0,

        "mdSensitivity" : 50,

        "name" : "Camera number 1",

        "recordType" : "motion",

        "rtspTransport" : "auto",

        "urlHigh" : "rtsp://root:root@192.168.1.1/Streaming/1"

     },

     {

        "id" : 1,

        "mdSensitivity" : 50,

        "name" : "Camera number 2",

        "recordType" : "continuos",

        "rtspTransport" : "tcp",

        "urlHigh" : "rtsp://root:root@192.168.1.2/"
},
```







### <i class="icon-upload"></i>Ссылки
 - [ivideon](https://www.ivideon.com/)
 - [docker](https://www.docker.com/)
 - [Запись в блоге](https://)
 - [Редактор readme.md](https://stackedit.io/)

> Copyright (c) 2016 &lt;[ErshovSergey](http://github.com/ErshovSergey/)&gt;
> ### <i class="icon-refresh"></i>Лицензия MIT
> Данная лицензия разрешает лицам, получившим копию данного программного обеспечения и сопутствующей документации (в дальнейшем именуемыми «Программное Обеспечение»), безвозмездно использовать Программное Обеспечение без ограничений, включая неограниченное право на использование, копирование, изменение, добавление, публикацию, распространение, сублицензирование и/или продажу копий Программного Обеспечения, также как и лицам, которым предоставляется данное Программное Обеспечение, при соблюдении следующих условий:

> Указанное выше уведомление об авторском праве и данные условия должны быть включены во все копии или значимые части данного Программного Обеспечения.

> ДАННОЕ ПРОГРАММНОЕ ОБЕСПЕЧЕНИЕ ПРЕДОСТАВЛЯЕТСЯ «КАК ЕСТЬ», БЕЗ КАКИХ-ЛИБО ГАРАНТИЙ, ЯВНО ВЫРАЖЕННЫХ ИЛИ ПОДРАЗУМЕВАЕМЫХ, ВКЛЮЧАЯ, НО НЕ ОГРАНИЧИВАЯСЬ ГАРАНТИЯМИ ТОВАРНОЙ ПРИГОДНОСТИ, СООТВЕТСТВИЯ ПО ЕГО КОНКРЕТНОМУ НАЗНАЧЕНИЮ И ОТСУТСТВИЯ НАРУШЕНИЙ ПРАВ. НИ В КАКОМ СЛУЧАЕ АВТОРЫ ИЛИ ПРАВООБЛАДАТЕЛИ НЕ НЕСУТ ОТВЕТСТВЕННОСТИ ПО ИСКАМ О ВОЗМЕЩЕНИИ УЩЕРБА, УБЫТКОВ ИЛИ ДРУГИХ ТРЕБОВАНИЙ ПО ДЕЙСТВУЮЩИМ КОНТРАКТАМ, ДЕЛИКТАМ ИЛИ ИНОМУ, ВОЗНИКШИМ ИЗ, ИМЕЮЩИМ ПРИЧИНОЙ ИЛИ СВЯЗАННЫМ С ПРОГРАММНЫМ ОБЕСПЕЧЕНИЕМ ИЛИ ИСПОЛЬЗОВАНИЕМ ПРОГРАММНОГО ОБЕСПЕЧЕНИЯ ИЛИ ИНЫМИ ДЕЙСТВИЯМИ С ПРОГРАММНЫМ ОБЕСПЕЧЕНИЕМ.
