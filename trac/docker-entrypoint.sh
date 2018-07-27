#!/bin/bash
set -eu

setup_trac() {

    trac-admin $TRAC_ENV initenv $TRAC_PROJECT_NAME $DB_URI
    trac-admin $TRAC_ENV config set logging log_type stderr

}

setup_email() {

    trac-admin $TRAC_ENV config set notification smtp_server $SMTP_SERVER
    trac-admin $TRAC_ENV config set notification smtp_port $SMTP_PORT
    trac-admin $TRAC_ENV config set notification smtp_user $SMTP_USER
    trac-admin $TRAC_ENV config set notification smtp_password $SMTP_PASSWORD

}

setup_admin() {

  if [ ! -d "/var/trac/users" ]; then
    ADMIN_PASS_HASH ="$(openssl passwd -apr1 TRAC_ADMIN_PASS)"
    trac-admin $TRAC_ENV permission add $TRAC_ADMIN_USER TRAC_ADMIN
    echo "$TRAC_ADMIN_USER:$ADMIN_PASS_HASH" >> /var/trac/users
  fi

}

setup_components() {

    # TODO
    #   - Subproject

}

reload_project_info() {

    trac-admin $TRAC_ENV config set project name $TRAC_PROJECT_NAME
    trac-admin $TRAC_ENV config set project descr $TRAC_PROJECT_DESC

    # TODO
    #   - Download new logo from URL
    #   - Move to folder
    #   - Set new logo
 
}

if [ ! -d "/var/trac/conf/trac.ini" ]; then

  setup_trac()
  setup_email()
  setup_admin()
  setup_components()

fi

reload_project_info()

# checar de precisa do chdir ou se o comando já coloca como
# se existir certificado usa com ssl

if [ -f "server.crt" && -f "server.key" ]; then

  gunicorn --certfile=server.crt --keyfile=server.key -w 2 -b 0.0.0.0:9000 wsgi:appplication

else

  gunicorn -w 2 -b 0.0.0.0:9000 wsgi:appplication

fi