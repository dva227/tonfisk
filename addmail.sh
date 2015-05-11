#!/usr/bin/env bash

if [[ $# -eq 1 ]];then
    user=$1;
    
    echo "$user@rodingen.com rodingen.com/$user" >> /etc/postfix/vmail_mailbox || { echo "Could not add mailbox." && exit 1; };
    echo "$user@rodingen.com $user@rodingen.com" >> /etc/postfix/vmail_aliases || { echo "Could not add mail alias." && exit 1; };
   
    postmap /etc/postfix/vmail_mailbox || { echo "Could not update mailbox database." && exit 1; };
    postmap /etc/postfix/vmail_aliases || { echo "Could not update alias database." && exit 1; };

    pass=$(doveadm pw -s SHA1) && echo "$user@rodingen.com:$pass" >> /etc/dovecot/users.conf

else
    echo "Usage ./$0 mailuser";
fi
