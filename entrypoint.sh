#!/bin/bash -eu

echo ''
echo ''
echo "                                  _"
echo "                                 | |   "
echo " _   _ _ __  _ __ ___   __ _ _ __| | __"
echo "| | | | '_ \| '_ \` _ \\ / _\` | '__| |/ /"
echo "| |_| | | | | | | | | | (_| | |  |   < "
echo " \\__,_|_| |_|_| |_| |_|\\__,_|_|  |_|\\_\\"
echo ''
echo ''
echo '    #> Configuring unmark...'
ansible-playbook -i 'localhost ansible_connection=local,' /entrypoint.yml -vvvv
echo ''
echo ''
echo '    #> Verifying php-fom configuration...'
/usr/sbin/php-fpm7.0 -y /etc/php/7.0/fpm/pool.d/www.conf -tt
echo ''
echo ''
echo '    #> Starting supervisord...'
supervisord -n -c /etc/supervisor/supervisord.conf

