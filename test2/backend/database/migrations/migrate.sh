#!/bin/bash

EXEC_PATH=$(dirname $(readlink -f "$0"))
COLOR_RED=$(tput setaf 1)
COLOR_DEFAULT=$(tput sgr0)

YOYO_ACTION='apply'
while [ $# -gt 0 ]; do
  case "$1" in
    -r|--rollback)
      YOYO_ACTION='rollback'
      YOYO_REVISION="$2"
      shift
      shift
      ;;
    *)
      printf "***************************\n"
      printf "* Error: Invalid argument.*\n"
      printf "***************************\n"
      exit 1
  esac
done

cd $EXEC_PATH

# Obtain app credentials
APP_CREDENTIALS=$(aws secretsmanager get-secret-value --secret-id '/test2-infrastructure/AppCredentials' --query 'SecretString' --output json | jq 'fromjson') 
if [ -z "$APP_CREDENTIALS" ]; then
  printf "$COLOR_RED\n"
  printf "**********************************************************************\n"
  printf "* ERROR: Something went wrong trying to get database app credentials *\n"
  printf "**********************************************************************\n"
  printf "$COLOR_DEFAULT\n"
  exit 1
fi

# Obtain master credentials
MASTER_SECRET_ARN=$(aws ssm get-parameter --name '/test2-infrastructure/MasterSecretArn' --query 'Parameter.Value' --output text)
MASTER_CREDENTIALS=$(aws secretsmanager get-secret-value --secret-id $MASTER_SECRET_ARN --query 'SecretString' --output json | jq 'fromjson') 
if [ -z "$MASTER_CREDENTIALS" ]; then
  printf "$COLOR_RED\n"
  printf "*************************************************************************\n"
  printf "* ERROR: Something went wrong trying to get database master credentials *\n"
  printf "*************************************************************************\n"
  printf "$COLOR_DEFAULT\n"
  exit 1
fi

MASTER_CREDENTIALS=$(cat <<- EOF
  {
    "host": "$( echo $APP_CREDENTIALS | jq -r '.host')",
    "dbname": "$( echo $APP_CREDENTIALS | jq -r '.dbname')",
    "username": "$( echo $MASTER_CREDENTIALS | jq -r '.username')",
    "password": "$( echo $MASTER_CREDENTIALS | jq -r '.password' | xargs printf %s | jq -sRr @uri)",
    "port": "$( echo $APP_CREDENTIALS | jq -r '.port')"
  }
EOF
)

export APP_CREDENTIALS=$APP_CREDENTIALS
export MASTER_CREDENTIALS=$MASTER_CREDENTIALS
export YOYO_ACTION=$YOYO_ACTION
export YOYO_REVISION=$YOYO_REVISION

. ./migration.sh