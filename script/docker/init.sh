#!/bin/bash

# 脚本根目录
SCRIPT_FOLDER=lottery
# dyid存放目录
DYID_FOLDER=lib
# 设置环境变量文件
ENV_FILE=env.js
# 自定义设置文件
CONFIG_FILE=my_config.json

echo "  _           _   _                   _____           _       _   ";
echo " | |         | | | |                 / ____|         (_)     | |  ";
echo " | |     ___ | |_| |_ ___ _ __ _   _| (___   ___ _ __ _ _ __ | |_ ";
echo " | |    / _ \| __| __/ _ \ '__| | | |\___ \ / __| '__| | '_ \| __|";
echo " | |___| (_) | |_| ||  __/ |  | |_| |____) | (__| |  | | |_) | |_ ";
echo " |______\___/ \__|\__\___|_|   \__, |_____/ \___|_|  |_| .__/ \__|";
echo "                                __/ |                  | |        ";
echo "                               |___/                   |_|        ";

if [ ! -d "$SCRIPT_FOLDER" ]; then
    echo "create $SCRIPT_FOLDER"
    mkdir $SCRIPT_FOLDER
fi

cd $SCRIPT_FOLDER/

if [ ! -d "$DYID_FOLDER" ]; then
    echo "create $DYID_FOLDER/"
    mkdir $DYID_FOLDER
else
    echo "$DYID_FOLDER/ exists"
fi

if [ ! -f "$ENV_FILE" ]; then
    echo "create $ENV_FILE"
    curl -fsSL https://cdn.jsdelivr.net/gh/shanmite/LotteryAutoScript@main/env.example.js -o $ENV_FILE
else
    echo "$ENV_FILE exists"
fi

if [ ! -f "$CONFIG_FILE" ]; then
    echo "create $CONFIG_FILE"
    echo "{}" > $CONFIG_FILE
else
    echo "$CONFIG_FILE exists"
fi

echo "docker pull shanmite/lottery_auto_docker"
docker -v && docker pull shanmite/lottery_auto_docker

echo "create start.sh"
echo -e "#!/bin/bash\n\
docker run \
-v $PWD/env.js:/lottery/env.js \
-v $PWD/my_config.json:/lottery/my_config.json \
-v $PWD/lib/:/lottery/lib/ \
shanmite/lottery_auto_docker \
start" \
> start.sh

echo "create check.sh"
echo -e "#!/bin/bash\n\
docker run \
-v $PWD/env.js:/lottery/env.js \
-v $PWD/my_config.json:/lottery/my_config.json \
-v $PWD/lib/:/lottery/lib/ \
shanmite/lottery_auto_docker \
check" \
> check.sh

echo "create clear.sh"
echo -e "#!/bin/bash\n\
docker run \
-v $PWD/env.js:/lottery/env.js \
-v $PWD/my_config.json:/lottery/my_config.json \
-v $PWD/lib/:/lottery/lib/ \
shanmite/lottery_auto_docker \
clear" \
> clear.sh