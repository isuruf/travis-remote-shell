#!/bin/bash
if [ "$(uname)" == "Darwin" ]; then
    wget -O ngrok.zip https://dl.ngrok.com/ngrok_2.0.19_darwin_amd64.zip
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    wget -O ngrok.zip https://dl.ngrok.com/ngrok_2.0.19_linux_amd64.zip
fi

unzip ngrok.zip
{
    nc -l -v -c /bin/bash 8888
    killall -SIGINT ngrok && echo "ngrok terminated"
} &
{
    ./ngrok tcp 8888 --authtoken=$NGROK_TOKEN --log=stdout --log-level=debug | grep "tcp.ngrok.io" || true
} &
