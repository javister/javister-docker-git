# Docker образ с клиентом Git

[ ![Download](https://api.bintray.com/packages/javister/docker/javister%3Ajavister-docker-git/images/download.svg) ](https://bintray.com/javister/docker/javister%3Ajavister-docker-git/_latestVersion)

## Введение

Данный образ предназначен в первую очередь для multistage сборок Docker образов,
когда необходимо сформировать образ из исходников с репозитария Git и не хочется
устанавливать, а потом удалять Git в Dockerfile.

Так же этот образ может быть использован как самодостаточная утилита, если
необходимо склонировать репозитарий Git не нет желания/возможности установить
Git в систему.

## Использование в качестве утилиты

Для того, чтобы просто склонировать репозитарий Git, можно восспользоваться
следующей командой:

```bash
docker run \
    -ti \
    --rm \
    -v "$(pwd)":"$(pwd)" \
    -e PUID=$(id -u) \
    -e PGID=$(id -g) \
    -e http_proxy="${http_proxy}" \
    -e no_proxy="${no_proxy}" \
    --workdir="$(pwd)" \
    javister-docker-docker.bintray.io/javister/javister-docker-git:1.0 \
    clone https://repo.com/path
```
Если клонировать репозитарии необходимо регулярно, то можно задать алиас в
`~/.bashrc`:

```bash
git_func() {
    docker run \
        -ti \
        --rm \
        -v "$(pwd)":"$(pwd)" \
        -e PUID=$(id -u) \
        -e PGID=$(id -g) \
        -e http_proxy="${http_proxy}" \
        -e no_proxy="${no_proxy}" \
        -e LOG_LEVEL="WARNING" \
        --workdir="$(pwd)" \
        javister-docker-docker.bintray.io/javister/javister-docker-git:1.0 \
        $@
}
alias git=git_func
``` 
