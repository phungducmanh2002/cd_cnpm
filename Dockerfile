FROM wordpress:latest
# copy code wordpress vào "thư mục chạy" của container
COPY ./wordpress/ /var/www/html/
# cấp quyền upload file cho người dùng 
# (ở đây đang dùng full quyền có thể chỉnh lại cho phù hợp hơn để bảo mật)
RUN chmod -R 777 /var/www/html/wp-content/uploads

EXPOSE 80
CMD ["apache2-foreground"]

