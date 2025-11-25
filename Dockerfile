FROM quay.io/hummingbird/php:8.5

WORKDIR /var/www/html

COPY . .

# Expõe a porta 8080
EXPOSE 8080

# IMPORTANTE: Reseta o ENTRYPOINT da imagem base para evitar conflitos
ENTRYPOINT []

# Agora definimos o comando completo para subir o servidor embutido do PHP
CMD ["php", "-S", "0.0.0.0:8080"]
