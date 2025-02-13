#!/bin/bash

# Variáveis
LOG_FILE="/var/log/script.log"
NOME="Patrick-Jabba"
REPO_URL="https://github.com/Patrick-Jabba/AWS-Scripts"

# Função para logar mensagens
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOG_FILE
}

# Atualizando pacotes
log "Atualizando pacotes do sistema..."
yum update -y

# Instalando Apache
log "Instalando Apache..."
yum install -y httpd
systemctl start httpd
systemctl enable httpd
log "Apache instalado e iniciado com sucesso."

# Clonando repositório com o site
log "Clonando repositório do GitHub..."
yum install -y git
cd /var/www/html
rm -rf *
git clone $REPO_URL .
log "Repositório clonado com sucesso."

# Ajustando permissões
log "Ajustando permissões do diretório do site..."
chown -R apache:apache /var/www/html

# Enviando requisição POST
log "Enviando requisição POST com o nome..."
curl -X POST -d "nome=$NOME" https://difusaotech.com.br/lab/aws/index.php
log "Requisição POST enviada com sucesso."

# Finalização do script
log "Script finalizado."
