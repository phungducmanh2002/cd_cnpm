FROM wordpress:latest
COPY ./wordpress/ /var/www/html/
RUN chmod -R 777 /var/www/html/wp-content/uploads

EXPOSE 80
CMD ["apache2-foreground"]

