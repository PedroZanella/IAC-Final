# 💎 Jewelry App – Infrastructure as Code for a Jewelry Client

## 🧭 Project Context

You work at a **software development consultancy** and were assigned to a **fast-track project** for a **NEW client** who needs their jewelry website online as quickly as possible. The goal is to ensure the infrastructure is ready, secure, and automated, meeting all technical requirements.

Your **insightful** manager recalled that your company had previously developed a similar project for an **OLD CLIENT** — a fashion jewelry store — and that this earlier solution could serve as a foundation to accelerate delivery for the new client.

---

## 🎯 New Client Requirements

- Infrastructure hosted on **AWS**
- Datacenter located in **us-east-1**
- All automation must be handled via **Makefile**
- Simple web application (HTML + Node.js)
- Fast and secure provisioning

---

## 🧱 Technologies Used

- **Terraform** – Infrastructure provisioning on AWS  
- **Docker** – Application packaging  
- **Makefile** – Task automation  
- **Checkov** – Infrastructure security validation  
- **Git Bash / VSCode** – Development environment  
- **EC2 + Security Groups** – Core infrastructure  

---

## 📦 Project Structure

├── deploy.sh               # Remote deployment script via SSH 
├── Dockerfile              # Application packaging 
├── index.html              # Application frontend 
├── main.tf                 # Terraform infrastructure 
├── Makefile                # Task automation 
├── package.json            # Node.js dependencies 
├── terraform.tfstate       # Infrastructure state 
├── vite.config.js          # Vite configuratio

---

## 🛠️ Steps Completed

### 1. Provisioning with Terraform
- EC2 instance creation (`aws_instance.jewelry_vm`)
- Security Group creation (`aws_security_group.jewelry_sg`)
- VPC, Subnet, and public IP configuration
- Automatic output of the instance’s public IP

### 2. Security Validation with Checkov
- Detection of issues such as:
  - Port 22 open to the world
  - Missing resource tags
  - Lack of EBS encryption
  - Missing `instance_metadata_options`
- Fixes applied directly in `main.tf`
- Checkov configured to **not interrupt the process** (`|| echo`)

### 3. Automation with Makefile
- Targets created: `init`, `plan`, `apply`, `destroy`, `build`, `deploy`, `check-security`
- Use of `ENV` variable to control behavior (`ENV=local` or `ENV=prod`)
- Skipping `npm install` in local environments
- Execution of `deploy.sh` as part of the flow
- Dedicated commands:
  - `make aws-deploy` – Provisions infrastructure and displays the public IP of the application
  - `make aws-destroy` – Destroys all provisioned infrastructure

### 4. Deployment Script (`deploy.sh`)
- Retrieves instance IP via `terraform output`
- Transfers files via `scp`
- Restarts services via `ssh`
- Validates `.pem` key and IP before deployment

### 5. VSCode Terminal Configuration
- Git Bash set as default terminal
- Fix for `"\" was unexpected at this time"` error caused by PowerShell
- Proper execution of `.sh` scripts in Bash environment

---

## 🚀 How to Run

```bash
# Initialize Terraform
make init

# Plan and apply infrastructure
make plan
make apply

# Build the application (skipped in local environment)
make build ENV=prod

# Full deploy with security and application
make deploy ENV=prod

# Provision and access the application via public IP
make aws-deploy

# Destroy all infrastructure
make aws-destroy

✅ Execution Requirements
• 	Git Bash or WSL installed locally
• 	Valid  key for EC2 access
• 	Node.js installed on EC2 via  or manually
• 	AWS CLI configured (optional)

*********************Version in Portugues*****************

# 💎 Jewelry App – Infraestrutura como Código para Cliente de Joias

## 🧭 Contexto do Projeto

Você trabalha em uma empresa de **consultoria de desenvolvimento** e foi destacado para um **projeto rápido** com um **NOVO cliente** que deseja colocar seu site de joias no ar o mais rápido possível. O objetivo é garantir que a infraestrutura esteja pronta, segura e automatizada, cumprindo todos os requisitos técnicos.

Seu chefe, muito **perspicaz**, lembrou que a empresa já havia desenvolvido um projeto semelhante para um **CLIENTE ANTIGO** — uma loja de bijuterias — e que esse projeto poderia servir como base para acelerar a entrega ao novo cliente.

---

## 🎯 Requisitos do NOVO Cliente

- Infraestrutura hospedada na **AWS**
- Datacenter localizado em **us-east-1**
- Toda a automação deve ser feita via **Makefile**
- Aplicação web simples (HTML + Node.js)
- Provisionamento rápido e seguro

---

## 🧱 Tecnologias Utilizadas

- **Terraform** – Provisionamento da infraestrutura na AWS  
- **Docker** – Empacotamento da aplicação web  
- **Makefile** – Automação de tarefas  
- **Checkov** – Validação de segurança da infraestrutura como código  
- **Git Bash / VSCode** – Ambiente de desenvolvimento  
- **EC2 + Security Groups** – Infraestrutura principal  

---

## 📦 Estrutura do Projeto
├── deploy.sh               # Script de deploy remoto via SSH
├── Dockerfile              # Empacotamento da aplicação 
├── index.html              # Frontend da aplicação 
├── main.tf                 # Infraestrutura Terraform 
├── Makefile                # Automação de tarefas 
├── package.json            # Dependências Node.js 
├── terraform.tfstate       # Estado da infraestrutura 
├── vite.config.js          # Configuração do Vite


---

## 🛠️ Etapas Realizadas

### 1. Provisionamento com Terraform
- Criação de instância EC2 (`aws_instance.jewelry_vm`)
- Criação de Security Group (`aws_security_group.jewelry_sg`)
- Configuração de VPC, Subnet e IP público
- Output automático do IP da instância

### 2. Validação de Segurança com Checkov
- Identificação de falhas como:
  - Porta 22 aberta para o mundo
  - Falta de tags
  - Falta de criptografia no EBS
  - Falta de `instance_metadata_options`
- Correções aplicadas diretamente no `main.tf`
- Checkov configurado para **não interromper o processo** (`|| echo`)

### 3. Automação com Makefile
- Criação de alvos como `init`, `plan`, `apply`, `destroy`, `build`, `deploy`, `check-security`
- Uso de variável `ENV` para controlar o comportamento (`ENV=local` ou `ENV=prod`)
- Ignoração do `npm install` em ambiente local
- Execução do `deploy.sh` como parte do fluxo
- Comandos dedicados:
  - `make aws-deploy` – Provisiona a infraestrutura e exibe o IP público da aplicação
  - `make aws-destroy` – Remove toda a infraestrutura provisionada

### 4. Script de Deploy (`deploy.sh`)
- Obtenção do IP da instância via `terraform output`
- Envio de arquivos via `scp`
- Reinício de serviços via `ssh`
- Validação de chave `.pem` e IP antes do deploy

### 5. Configuração do Terminal no VSCode
- Ativação do Git Bash como terminal padrão
- Correção de erro `"\" foi inesperado neste momento"` causado por PowerShell
- Execução correta de scripts `.sh` no ambiente Bash

---

## 🚀 Como Executar

```bash
# Inicializar Terraform
make init

# Planejar e aplicar infraestrutura
make plan
make apply

# Build da aplicação (ignorado em ambiente local)
make build ENV=prod

# Deploy completo com segurança e aplicação
make deploy ENV=prod

# Provisionar e acessar aplicação via IP público
make aws-deploy

# Destruir toda a infraestrutura
make aws-destroy


✅ Requisitos para Execução
• 	Git Bash ou WSL instalado no ambiente local
• 	Chave  válida para acesso à EC2
• 	Node.js instalado na EC2 via  ou manualmente
• 	AWS CLI configurado (opcional)


Analises utilizadas para o desenvolvimento do projeto

# Jewelry App

Aplicação Vue.js para exibição de joias com deploy automatizado no Azure usando Terraform.

## Pré-requisitos

- Node.js 18+
- Docker
- Terraform
- Azure CLI (para deploy)

## Execução Local

### Desenvolvimento
```bash
# Instalar dependências
npm install

# Executar em modo desenvolvimento
npm run dev
```
Acesse: http://localhost:5173

### Docker Local
```bash
# Usando Makefile
make docker-run

# Ou manualmente
docker build -t jewelry-app .
docker run -p 8080:80 jewelry-app
```
Acesse: http://localhost:8080

## Deploy no Azure

### Configuração Inicial
```bash
# Login no Azure
az login

# Configurar credenciais (se necessário)
az account set --subscription "sua-subscription-id"
```

### Deploy Automatizado
```bash
# Deploy completo (build + infraestrutura + aplicação)
make azure-deploy
```

### Deploy Manual
```bash
# 1. Inicializar Terraform
make init

# 2. Planejar mudanças
make plan

# 3. Aplicar infraestrutura
make apply

# 4. Build e deploy da aplicação
make deploy
```

## Comandos Úteis

```bash
# Build da aplicação
make build

# Limpar arquivos temporários
make clean

# Destruir infraestrutura Azure
make azure-destroy
```

## Estrutura do Projeto

```
├── src/           # Código fonte Vue.js
├── main.tf        # Configuração Terraform
├── Dockerfile     # Container da aplicação
├── Makefile       # Comandos automatizados
└── deploy.sh      # Script de deploy
```

## Infraestrutura Azure

O Terraform provisiona:
- Resource Group
- Virtual Network e Subnet
- Network Security Group
- VM Linux com Docker
- IP Público

A aplicação roda na porta 8080 da VM.
