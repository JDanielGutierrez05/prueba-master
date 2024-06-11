#!/bin/bash

COLOR_RED="\033[31m"
COLOR_GREEN="\033[32m"
COLOR_BLUE="\033[34m"
COLOR_DEFAULT="\033[0m"

DB_HOST=$(echo $MASTER_CREDENTIALS | jq -r '.host')
DB_DATABASE=$(echo $MASTER_CREDENTIALS | jq -r '.dbname')
DB_USERNAME=$(echo $MASTER_CREDENTIALS | jq -r '.username')
DB_PASSWORD=$(echo $MASTER_CREDENTIALS | jq -r '.password')
DB_PORT=$(echo $MASTER_CREDENTIALS | jq -r '.port')

echo ''
printf "${COLOR_GREEN}################ MIGRATION PROCESS STARTED ################${COLOR_DEFAULT}\n"
if [ $YOYO_ACTION == "apply" ]; then
  echo ''
  printf "${COLOR_BLUE}Applying 'tables' migrations ...${COLOR_DEFAULT}\n"
  yoyo $YOYO_ACTION --database mysql://"$DB_USERNAME":"$DB_PASSWORD"@"$DB_HOST:$DB_PORT/$DB_DATABASE" _tables || { printf "${COLOR_RED}Migrations for tables couldn't be applied.${COLOR_DEFAULT}\n" ; exit 1; }
  printf "${COLOR_BLUE}Finished applying 'tables' migrations${COLOR_DEFAULT}\n"
  echo ''
else
  if [ $YOYO_REVISION == "all" ]; then
      YOYO_REVISION="--all"
  elif [ ! -z $YOYO_REVISION ]; then
      YOYO_REVISION="--revision $YOYO_REVISION"
  fi
  echo ''
  printf "${COLOR_BLUE}Rolling back 'tables' migrations ...${COLOR_DEFAULT}\n"
  yoyo $YOYO_ACTION $YOYO_REVISION --database mysql://"$DB_USERNAME":"$DB_PASSWORD"@"$DB_HOST:$DB_PORT/$DB_DATABASE" _tables || { printf "${COLOR_RED}Migrations for tables couldn't be rolled back.${COLOR_DEFAULT}\n" ; exit 1; }
  printf "${COLOR_BLUE}Finished rolling back 'tables' migrations${COLOR_DEFAULT}\n"
  echo ''
fi
printf "${COLOR_GREEN}################ MIGRATION PROCESS ENDED ################${COLOR_DEFAULT}\n"
echo ''

unset \
  COLOR_RED \
  COLOR_GREEN \
  COLOR_BLUE \
  COLOR_DEFAULT \
  YOYO_ACTION \
  YOYO_REVISION \
  DB_HOST \
  DB_DATABASE \
  DB_USERNAME \
  DB_PASSWORD \
  DB_PORT
