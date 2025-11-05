#!/bin/bash

echo "Iniciando deploy remoto..."

# Obter IP da instância via Terraform
IP=$(terraform output -raw vm_public_ip)

# Copiar arquivos para a EC2
scp -r ./dist ec2-user@$IP:/var/www/html

# Reiniciar serviço remoto (ex: nginx)
ssh ec2-user@$IP "sudo systemctl restart nginx"

echo "✅ Deploy concluído com sucesso!"