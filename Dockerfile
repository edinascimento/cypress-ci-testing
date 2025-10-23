FROM cypress/included:15.0.0

# Criar diretórios e garantir permissões
WORKDIR /app
RUN mkdir -p cypress/videos cypress/screenshots \
    && chmod -R 777 cypress

# Copiar arquivos do projeto
COPY package.json package.json
COPY cypress.config.js cypress.config.js
COPY cypress cypress

# Instalar dependências
RUN npm install

# Comando padrão
CMD ["npm", "run", "test:ci"]