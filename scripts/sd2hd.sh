#!/bin/bash

source=""
target=""

function execute()
{
  if $1 > /dev/null
  then 
  echo -e "\033[32m OK \033[0m"
  else
  echo -e "\033[31m KO \033[0m"
  exit 1
  fi
}

function cleanup()
{
  if [[ ! -z $source ]]
  then 
  umount /mnt/$source > /dev/null
  rm -rf /mnt/$source > /dev/null
  fi

  if [[ ! -z $target ]]
  then 
  umount /mnt/$source > /dev/null
  rm -rf /mnt/$source > /dev/null
  fi
}

control_c()
{
  echo -en "\nExiting...\n"
  cleanup
  exit $?
}

echo "
#--------------------------------------------------------------#
# Script pour copier le contenu d'une carte vers un disque dur #
#--------------------------------------------------------------#"
echo

#catch control-c
trap control_c SIGINT

read -p "Les actuels points de montage vont être démontés puis supprimés, appuyer sur entrée pour confirmer..."
if [ "$REPLY" != "" ]
then
exit 1
else
for n in /dev/sd* ; do umount $n ; done
rm -rf /mnt/*
fi

#liste des devices
lsblk -o NAME,SIZE,MODEL,LABEL

echo
read -p "Choisir le media source : "
source=$REPLY

while [ ! -b "/dev/$source" ]
do
read -p "Media inexistant, réessayer : "
source=$REPLY
done

read -p "Choisir le media cible : "
target=$REPLY

while [ ! -b "/dev/$target" -o "$source" == "$target" ]
do
read -p "Media inexistant ou déjà utilisé, réessayer : "
source=$REPLY
done

read -p "Appuyer sur entrée pour continuer... "
if [ "$REPLY" != "" ]
then
exit 1
fi

echo -e "Création du répertoire de montage source /mnt/$source\c"
execute "mkdir /mnt/$source"

echo -e "Montage du répertoire source\c"
execute "mount /dev/$source /mnt/$source"

echo -e "Création du répertoire de montage cible /mnt/$target\c"
execute "mkdir /mnt/$target"

echo -e "Montage du répertoire cible\c"
execute "mount /dev/$target /mnt/$target"

echo -e "Copie des fichiers..."
#todo...
