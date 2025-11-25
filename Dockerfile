FROM quay.io/hummingbird/php:8.5

WORKDIR /var/www/html

COPY . .

EXPOSE 8080

# O Entrypoint da imagem já é "php".
# Aqui passamos APENAS os argumentos para ele.
# Resultado final será: "php -S 0.0.0.0:8080"
CMD ["-S", "0.0.0.0:8080"]
