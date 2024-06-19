FROM wordpress:latest
COPY ./wordpress/ /var/www/html/

EXPOSE 80
CMD ["apache2-foreground"]

