#!/bin/bash
# RU: Скрипт запуска vod\стримов с Twitch c выбором доступного качества
# ENG: Streamlink VOD\Stream launcher script with a choice of quality.

players=(vlc mpv)

echo -e "\nВведите Twitch VOD\Stream URL: \c"
read url

echo -e $url
command1="streamlink $url -j "
command2="| jq '.streams' | jq 'to_entries' | jq '.[].key' --raw-output"

arr=( $($command1 | jq '.streams' | jq 'to_entries' | jq '.[].key' --raw-output) )

echo -e "\nВарианты качества:\n"
for ((a=0; a < ${#arr[*]}; a++))
do
    echo -e "\t$a: ${arr[$a]}"
done

echo -e "\nВыберите качество: \c"
read choise
echo -e "\nВыбрано" ${arr[$choise]}

echo -e "\nВарианты плееров:\n"
for ((a=0; a < ${#players[*]}; a++))
do
    echo -e "\t$a: ${players[$a]}"
done

echo -e "\nВыберите плеер: \c"
read choisePlayer
playerPath=$(which ${players[$choisePlayer]})
echo -e "\nВыбран плеер" ${players[$choisePlayer]}". Расположение" $playerPath

echo -e "\nЗапускаю" ${arr[$choise]} "в плеере" ${players[$choisePlayer]} "\n"

/usr/bin/streamlink --player-passthrough hls --player $playerPath $url ${arr[$choise]}

