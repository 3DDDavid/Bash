#!/bin/bash

#Я вроде смог сделать все задания, включая бонусы


clear
toilet -f pagga "Menu:"
echo "1) Красивый текст"
echo "2) Послушать мудрость"
echo "3) Converter rwx"
echo "4) Посмотреть погоду"
echo "5) Игрулька"
echo "0) Выход"
echo
echo "Выбирай число от 0 до 5."
read option

function beautiful_text () {
    clear
    echo "Выбери из следующего списка шрифт текста:"
    ls /usr/share/figlet
    echo
    read -p "Текст (не все шрифты поддерживают русский язык): " text
    read -p "Шрифт: " option_text
    toilet -f $option_text $text && read -p "Для продолжения нажмите Enter . . ." || beautiful_text
}

function listen () {
    clear
    echo "Выберите, мудрость кого вы хотите послушать:"
    ls /usr/share/cowsay/cows/
    echo
    read -p "Я выбираю: " option_listen
    cowsay -f $option_listen $(fortune) && read -p "Для продолжения нажмите Enter . . ." || listen
}

function convert () {
    clear
    echo "Выберите режим:"
    echo "1) Из цифровой формы в текстовый"
    echo "2) Из текстовой формы в цифровой"
    read text
    case "$text" in
    1) convert_num_to_text;;
    2) convert_text_to_num;;
    *) echo; echo "https://youtu.be/hp2CMP0zCFw"; read; convert;;
    esac
}

function convert_num_to_text () {
    clear
    read -p "Вводи: " nums

    if [[ "$nums" =~ ^[0-7]{3}$ ]]
    then
        answer=""
        for i in {0..3}
        do
            case "${nums:i:1}" in
            0) answer+="---";;
            1) answer+="--x";;
            2) answer+="-w-";;
            3) answer+="-wx";;
            4) answer+="r--";;
            5) answer+="r-x";;
            6) answer+="rw-";;
            7) answer+="rwx";;
            esac
        done
    else
        convert_num_to_text
    fi
    echo
    echo $answer
    echo
    read -p "Для продолжения нажмите Enter . . ."
}

function convert_text_to_num () {
    clear
    read -p "Вводи: " text_rwx

    if [[ "$text_rwx" =~ ^(-|r)(-|w)(-|x)(-|r)(-|w)(-|x)(-|r)(-|w)(-|x)$ ]]
    then
        i=0
        answer=""
        while [ "$i" != 9 ]
        do
            case "${text_rwx:i:3}" in
            ---) answer+=0;;
            --x) answer+=1;;
            -w-) answer+=2;;
            -wx) answer+=3;;
            r--) answer+=4;;
            r-x) answer+=5;;
            rw-) answer+=6;;
            rwx) answer+=7;;
            esac
            i=$(( i + 3 ))
        done
    else
        convert_text_to_num
    fi
    echo
    echo $answer
    echo
    read -p "Для продолжения нажмите Enter . . ."
}

function weather () {
    clear
    
    read -p "Город: " city
    if [$city == ""]
    then
        city="Moscow"
    fi
    wget wttr.in/$city
    #clear
    toilet -f mono9 $city
    head $city -n 7
    rm $city
    echo
    read -p "Для продолжения нажмите Enter . . ."
}

function weather_continue () {
    head $city -n 7
    rm $city
    echo
    read -p "Для продолжения нажмите Enter . . ."
}

function game () {
    num=`shuf --input-range=0-9 -n 4 -z`
    while [ "${num:0:1}" == "0" ]
    do
        num=`shuf --input-range=0-9 -n 4 -z`
    done

    echo "Это ответ кста: "$num
    clear

    while [ "$bull" != 4 ]
    do
    bull=0
    cows=0
    read -p "Твоё число: " num_player
    if [[ "$num_player" =~ ^[1-9][0-9]{3}$ ]] && [ "${num_player:0:1}" != "${num_player:1:1}" ] && [ "${num_player:0:1}" != "${num_player:2:1}" ] && [ "${num_player:0:1}" != "${num_player:3:1}" ] && [ "${num_player:1:1}" != "${num_player:2:1}" ] && [ "${num_player:1:1}" != "${num_player:3:1}" ] && [ "${num_player:2:1}" != "${num_player:3:1}" ]
    then
    for i in {0..3}
    do

        for j in {0..3}
        do
            if [ "${num:i:1}" == "${num_player:j:1}" ]
            then
                if [ "$i" == "$j" ]
                then
                    bull=$(( bull + 1 ))
                else
                    cows=$(( cows + 1 ))
                fi
            fi
        done

    done

    else
        echo "Ты что-то не то написал"
    fi
    
    if [ "$bull" != 4 ] && [[ "$num_player" =~ ^[1-9][0-9]{3}$ ]] && [ "${num_player:0:1}" != "${num_player:1:1}" ] && [ "${num_player:0:1}" != "${num_player:2:1}" ] && [ "${num_player:0:1}" != "${num_player:3:1}" ] && [ "${num_player:1:1}" != "${num_player:2:1}" ] && [ "${num_player:1:1}" != "${num_player:3:1}" ] && [ "${num_player:2:1}" != "${num_player:3:1}" ]
    then
        echo "Коров:" $cows
        echo "Быков:" $bull
        echo
    fi

    done

    toilet -f mono12 "VICTORY"

    read -p "Для продолжения нажмите Enter . . ."
}

case "$option" in
1) beautiful_text;;
2) listen;;
3) convert;;
4) weather;;
5) game;;
0) exit 0;;
*) echo; echo "https://youtu.be/hp2CMP0zCFw"; read;;
esac

./MyFirstShOnBash.sh