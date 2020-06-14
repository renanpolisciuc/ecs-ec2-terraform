# O que isso faz?

Cria, através do terraform, um cluster do AWS ECS usando EC2.

**Imagem: nginx (https://hub.docker.com/_/nginx)**

Recursos criados:

- 1 VPC
- 1 Route Table
- 1 Subnet
- 1 Internet Gateway
- 1 Security group
- 1 Cluster ECS
- 1 Serviço 
- 1 Task definition
- 1 regra de autobalancing
- 1 launch configuration
- 1 instância EC2
- Permissões necessárias

# Como testar?
- É necessário criar um usuário no AWS IAM (se já não existir) com permissões
necessárias para criação do cluster.
- Obter a **AWS_ACCESS_KEY_ID** e **AWS_SECRET_ACCESS_KEY** e configurar nos arquivos
deploy.sh e destroy.sh
- Por padrão, esse script executa na região **us-east-1**, mas isso pode ser
alterado nos scripts deploy.sh e destroy.sh
- Executar deploy.sh para criação da infraestrutura
- Executar destroy.sh para destruir a infraestrutura