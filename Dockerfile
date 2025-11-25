# ARGUMENTOS DE BUILD (Valores padrão que podem ser sobrescritos pelo Pipeline)
# Isso permite que você escolha a versão do PHP e do Moodle na hora do build
ARG BASE_IMAGE=quay.io/hummingbird/php:8.5-builder
FROM ${BASE_IMAGE}

# Redeclare o ARG após o FROM para usá-lo dentro do script
ARG MOODLE_VERSION=MOODLE_501_STABLE
ENV MOODLE_VERSION=${MOODLE_VERSION}

USER root

# Instalação de dependências essenciais e ferramentas de build
RUN dnf install -y \
    git \
    php-gd \
    php-intl \
    php-mbstring \
    php-xml \
    php-soap \
    php-zip \
    php-opcache \
    php-pgsql \
    php-mysqlnd \
    php-sodium \
    unzip \
    tar \
    && dnf clean all

WORKDIR /var/www/html

# Preparação de diretórios
RUN mkdir -p /var/www/moodledata && \
    chmod 777 /var/www/moodledata

# CLONE FLEXÍVEL: Usa a variável $MOODLE_VERSION
RUN echo "Construindo Moodle versão: ${MOODLE_VERSION}" && \
    git clone --branch ${MOODLE_VERSION} --depth 1 https://github.com/moodle/moodle.git . && \
    rm -rf .git

# Ajuste de permissões para rodar no OpenShift (Rootless)
RUN chown -R 1001:0 /var/www/html /var/www/moodledata && \
    chmod -R g+rw /var/www/html /var/www/moodledata

USER 1001

EXPOSE 8080

# Configurações de Runtime otimizadas para o Moodle
CMD ["-d", "max_input_vars=5000", "-d", "memory_limit=512M", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]
