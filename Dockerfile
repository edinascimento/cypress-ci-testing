FROM cypress/included:15.5.0

# Criar diretórios e garantir permissões
WORKDIR /app
RUN mkdir -p cypress/videos cypress/screenshots \
    && chmod -R 777 cypress

# Copiar arquivos do projeto
COPY package.json package-lock.json ./
COPY cypress.config.js .
COPY cypress ./cypress
COPY run_cypress.sh .
RUN chmod +x run_cypress.sh

# Instalar dependências
RUN npm ci

# Comando padrão
CMD ["npm", "run", "test:ci"]