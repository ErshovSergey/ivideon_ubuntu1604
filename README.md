[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/github.com/ErshovSergey/master/LICENSE) ![Language](https://img.shields.io/badge/language-bash-yellowgreen.svg)
# ivideon_ubuntu1604
Видеорегистратор на Ubuntu 16.04

##Описание
Сервер   [Ivideon](https://www.ivideon.com/) запускается в контейнер Docker. Архив и настройки хранятся вне контейнера.
#Эксплуатация данного проекта.
##Клонируем проект
```shell
git clone https://github.com/ErshovSergey/ivideon_ubuntu1604.git
```
##Собираем
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

##Запускаем
Определяем адрес на котором будет доступен для клиента сервер и запускаем
```shell
export ip_addr=<ip адрес>
docker run --name ivideon_ubuntu1604 -d --restart=always \
-h ivideon \
-v $SHARE_DIR:/SHARE \
-p $ip_addr:8080:8080 \
ershov/ivideon_ubuntu1604
```
##Удалить контейнер
```shell
docker stop ivideon_ubuntu1604; docker rm -v ivideon_ubuntu1604
```
Если файлов настройки не существуют - используются файлы "по-умолчанию".
### <i class="icon-upload"></i>Ссылки
 - [ivideon](https://www.ivideon.com/)
 - [docker](https://www.docker.com/)
 - [Запись в блоге](https://)
 - [Редактор readme.md](https://stackedit.io/)

### <i class="icon-refresh"></i>Лицензия MIT

> Copyright (c) 2016 &lt;[ErshovSergey](http://github.com/ErshovSergey/)&gt;

> Данная лицензия разрешает лицам, получившим копию данного программного обеспечения и сопутствующей документации (в дальнейшем именуемыми «Программное Обеспечение»), безвозмездно использовать Программное Обеспечение без ограничений, включая неограниченное право на использование, копирование, изменение, добавление, публикацию, распространение, сублицензирование и/или продажу копий Программного Обеспечения, также как и лицам, которым предоставляется данное Программное Обеспечение, при соблюдении следующих условий:

> Указанное выше уведомление об авторском праве и данные условия должны быть включены во все копии или значимые части данного Программного Обеспечения.

> ДАННОЕ ПРОГРАММНОЕ ОБЕСПЕЧЕНИЕ ПРЕДОСТАВЛЯЕТСЯ «КАК ЕСТЬ», БЕЗ КАКИХ-ЛИБО ГАРАНТИЙ, ЯВНО ВЫРАЖЕННЫХ ИЛИ ПОДРАЗУМЕВАЕМЫХ, ВКЛЮЧАЯ, НО НЕ ОГРАНИЧИВАЯСЬ ГАРАНТИЯМИ ТОВАРНОЙ ПРИГОДНОСТИ, СООТВЕТСТВИЯ ПО ЕГО КОНКРЕТНОМУ НАЗНАЧЕНИЮ И ОТСУТСТВИЯ НАРУШЕНИЙ ПРАВ. НИ В КАКОМ СЛУЧАЕ АВТОРЫ ИЛИ ПРАВООБЛАДАТЕЛИ НЕ НЕСУТ ОТВЕТСТВЕННОСТИ ПО ИСКАМ О ВОЗМЕЩЕНИИ УЩЕРБА, УБЫТКОВ ИЛИ ДРУГИХ ТРЕБОВАНИЙ ПО ДЕЙСТВУЮЩИМ КОНТРАКТАМ, ДЕЛИКТАМ ИЛИ ИНОМУ, ВОЗНИКШИМ ИЗ, ИМЕЮЩИМ ПРИЧИНОЙ ИЛИ СВЯЗАННЫМ С ПРОГРАММНЫМ ОБЕСПЕЧЕНИЕМ ИЛИ ИСПОЛЬЗОВАНИЕМ ПРОГРАММНОГО ОБЕСПЕЧЕНИЯ ИЛИ ИНЫМИ ДЕЙСТВИЯМИ С ПРОГРАММНЫМ ОБЕСПЕЧЕНИЕМ.
