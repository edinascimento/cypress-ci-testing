FROM cypress/browsers:node-20.5.0-chrome-114.0.5735.133-1-ff-114.0.2-edge-114.0.1823.51-1

WORKDIR /e2e

COPY package*.json ./
RUN npm install

COPY . .

# Opcional: instalar mochawesome globalmente
RUN npm install -g mochawesome mochawesome-merge mochawesome-report-generator

# Mantém flexível para passar argumentos
CMD ["npx", "cypress", "run"]