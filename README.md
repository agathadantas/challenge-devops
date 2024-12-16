# **Terraform AWS Infrastructure**

## **Descrição**
Este repositório contém o código Terraform para provisionar uma infraestrutura completa na AWS. Ele foi desenvolvido com base em boas práticas para gerenciar e configurar recursos em um ambiente SaaS. 

A infraestrutura inclui:
- Uma **VPC** com sub-redes públicas e privadas.
- Instância **EC2** configurada com acesso restrito e permissões específicas no **S3**.
- Um bucket **S3** com versionamento e políticas de segurança.
- Banco de dados **RDS MySQL** em sub-rede privada, acessível apenas pela instância EC2.

---

## **Recursos Criados**

### **1. VPC (Virtual Private Cloud)**
- Uma VPC com:
  - **2 sub-redes públicas** para instâncias acessíveis pela internet.
  - **2 sub-redes privadas** para bancos de dados e outros recursos restritos.
  - **Tabelas de rotas** configuradas para direcionar tráfego entre sub-redes e internet.

### **2. EC2 Instance**
- Instância EC2:
  - Provisionada em uma **sub-rede pública**.
  - Acesso via **SSH** restrito ao IP do usuário configurado.
  - Permissões para acessar um bucket S3 com ações limitadas a leitura e escrita.

### **3. S3 Bucket**
- Bucket S3 configurado com:
  - Bloqueio de acesso público.
  - Versionamento habilitado.
  - Regras de ciclo de vida para excluir versões antigas após 30 dias.
  - Política de segurança que exige conexões criptografadas (TLS).

### **4. RDS MySQL**
- Banco de dados RDS MySQL:
  - Provisionado em sub-rede privada.
  - Acesso permitido apenas pela instância EC2.
  - Criptografia e backups habilitados.

---

## **Pré-requisitos**

Antes de executar o código Terraform, você precisa ter:
1. **Terraform** instalado em sua máquina. [Guia de instalação](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
2. **Credenciais da AWS** configuradas no arquivo `~/.aws/credentials` ou exportadas como variáveis de ambiente:
   ```bash
   export AWS_ACCESS_KEY_ID="sua_chave_de_acesso"
   export AWS_SECRET_ACCESS_KEY="sua_chave_secreta"
   export AWS_DEFAULT_REGION="us-east-1"
3.IP público do seu computador para configurar o acesso SSH no Security Group.

## **Configuração**

1. Clone o repositório:
```bash
git clone https://github.com/agathadantas/challenge-devops.git
cd challenge-devops
```
2. Configure variáveis sensíveis:
  - Crie um arquivo terraform.tfvars na raiz do repositório com as seguintes variáveis:
```bash
rds_username = "admin"
rds_password = "senhaSegura123"
candidate_ip = "SEU_IP/32" # Substitua pelo seu IP público
```
3. Inicialize o Terraform, faça o planejamento e aplique as mudanças:
```bash
terraform init
terraform plan
terraform apply
```

## **Estrutura do Repositório**
```bash
terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars        #Variáveis sensíveis
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── ec2/    
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── s3/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── rds/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
```

