# script to create wp-config-sample.php (rename, inject variables (database name, user...), generate security keys)
# we make a script since the wp-config file is erased at every stop of the container

DB_USER=$(cat /run/secrets/db_user)
DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
DB_2ND_USER=$(cat /run/secrets/db_2nd_user)
DB_2ND_PASSWORD=$(cat /run/secrets/db_2nd_user_password)
DB_ADMIN_USER=$(cat /run/secrets/db_admin)
DB_ADMIN_PASSWORD=$(cat /run/secrets/db_admin_password)

sleep 5
# make sure database is ready

if [ ! -f /var/www/wordpress/wp-config.php ]; then
    wp config create --allow-root --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=mariadb --path=/var/www/wordpress
    wp core install --allow-root --url=$DOMAIN_NAME --title="42 Inception" --admin_user=$DB_ADMIN_USER --admin_password=$DB_ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --path=/var/www/wordpress
    # installs wp: creates the wordpress tables in the database (it's not the same thing as creating the database as it puts data in an already existing db i think)
    wp user create --allow-root $DB_USER user@mail.fr --role=contributor --user_pass=$DB_PASSWORD --path=/var/www/wordpress
    wp user create --allow-root $DB_2ND_USER 2nduser@mail.fr --role=contributor --user_pass=$DB_2ND_PASSWORD --path=/var/www/wordpress
    # creates second user
    wp theme install --allow-root /var/www/wordpress/wp-content/themes/terminal-blog.zip --path=/var/www/wordpress
    wp theme install --allow-root terminal-blog --activate --path=/var/www/wordpress
fi

exec /usr/sbin/php-fpm8.2 -F
# starts php


# we can modify the example script given by wordpress:
# https://kaiten.design/how-to-automate-wordpress-and-wp-config-php-creation/
# or use wp-cli to create one, here we used wp-cli:
# https://make.wordpress.org/cli/handbook/guides/quick-start/


# really complex and thorough version to use one day maybe who knows
# https://blog.noah.hearle.com/wordpress-installer/