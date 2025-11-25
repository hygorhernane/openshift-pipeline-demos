# Dockerfile
FROM quay.io/hummingbird/php:8.5

# Configura o diretório de trabalho (ajuste conforme a documentação da imagem Hummingbird)
WORKDIR /var/www/html

# Copia seu código fonte para dentro da imagem
COPY . .

# Expõe a porta (geralmente 8080 para containers não-root no OpenShift)
EXPOSE 8080

# Comando de inicialização (ajuste conforme necessário para esta imagem específica)
CMD ["php", "-S", "0.0.0.0:8080"]
