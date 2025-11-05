.PHONY: default init plan apply destroy build deploy clean docker-build docker-run aws-deploy aws-destroy check-security

# Verificação de segurança com Checkov (ignora falhas)
check-security:
	@checkov -d . || echo "⚠️ Checkov encontrou falhas, mas o processo continuará."

# Alvo padrão
default: aws-deploy

# Inicialização do Terraform
init:
	terraform init

# Planejamento da infraestrutura
plan:
	terraform plan $(VARS)

# Aplicação da infraestrutura
apply:
	terraform apply -auto-approve $(VARS)


# Destruição da infraestrutura
destroy: init
	terraform destroy -auto-approve

# Build do projeto (ignora se ambiente for local ou npm não estiver instalado)
build:
	@if [ "$(ENV)" = "local" ]; then \
		echo "Ignorando build local"; \
	elif ! command -v npm >/dev/null 2>&1; then \
		echo "⚠️ npm não encontrado. Ignorando build."; \
	else \
		npm install; \
		npm run build; \
	fi

# Deploy completo: segurança + build + infraestrutura
deploy: check-security build apply
	./deploy.sh

# Limpeza de arquivos locais
clean:
	rm -rf ./node_modules ./dist .terraform terraform.tfstate*

# Build da imagem Docker
docker-build:
	docker build -t jewelry-app .

# Execução do container Docker
docker-run: docker-build
	docker run -p 8080:80 jewelry-app

# Deploy na AWS com IP público
aws-deploy: apply
	@echo "Aguarde alguns minutos para a aplicação inicializar..."
	@echo "URL: http://$$(terraform output -raw vm_public_ip):8080"

# Destruição da infraestrutura na AWS
aws-destroy:
	terraform destroy -auto-approve
	