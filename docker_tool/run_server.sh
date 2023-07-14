#!bin/bash
export CONTAINER_NAME=11_rf
export IMAGE_NAME=glacefulladle/${CONTAINER_NAME}

# dockerコンテナのビルド．初期インストール
if [ $(docker images | grep ${IMAGE_NAME} | wc -l) -ge 1 ]; then
    echo "docker image is already exist"
else
    echo "docker imageが存在しないためbuildします"
    docker build -t ${IMAGE_NAME} ./INIT/
    echo "docker imageをbuildしました．"
fi

xhost +local:docker

# dockerコンテナ起動 -v 外側:内側
docker run --gpus '"device=0"' \
-it --ipc=host \
-e DISPLAY=${DISPLAY} \
-v "${PWD}":"/work" \
-v /tmp/.X11-unix/:/tmp/.X11-unix \
-w "/work" \
-p 9998:9998 \
-p 6080:80 \
--shm-size=16g \
--name ${CONTAINER_NAME} \
${IMAGE_NAME} bash

xhost -local:docker

# containerの保存選択
echo "終了します"
echo -n "docker containerを保存しますか？ [Y/n]: "
read ANS

case $ANS in
  "" | [Yy]* )
    # ここに「Yes」の時の処理を書く
    echo "保存して終了します"
    docker commit $(docker ps -a |  grep ${CONTAINER_NAME} | awk '{print $1}') ${IMAGE_NAME}:latest
    docker rm ${CONTAINER_NAME}
    ;;
  * )
    # ここに「No」の時の処理を書く
    echo "保存せずに終了します"
    docker rm ${CONTAINER_NAME}
    ;;
esac
