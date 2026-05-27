# script to create wp-config-sample.php (rename, inject variables (database name, user...), generate security keys)
# we make a script because apparently, the file is created at every start of the container

sleep 5
# make sure database is ready

if [ ! -f /var/www/wordpress/wp-config.php ]; then
    wp config create --allow-root --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=mariadb --path=/var/www/wordpress
    wp core install --allow-root --url="apeuget.42.fr" --title="42 Inception" --admin_user=$DB_USER --admin_password=$DB_PASSWORD --admin_email="admin@apeuget.42.fr" --path=/var/www/wordpress
    # installs wp: creates the wordpress tables in the database (it's not the same thing as creating the database as it puts data in an already existing db i think)
    wp user create --allow-root $DB_SECOND_USER 2nduser@mail.fr --role=contributor --user_pass=$DB_SECOND_PASSWORD --path=/var/www/wordpress
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