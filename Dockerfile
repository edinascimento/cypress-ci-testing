FROM cypress/browsers:node-22.21.0-chrome-141.0.7390.107-1-ff-144.0-edge-141.0.3537.92-1

WORKDIR /e2e

COPY . .

RUN npm install

RUN npm install -g mochawesome mochawesome-merge mochawesome-report-generator

# Criar diretório de reports
RUN mkdir -p cypress/reports

CMD ["npx", "cypress", "run", "--reporter", "mochawesome", "--reporter-options", "reportDir=cypress/reports,overwrite=false,html=true,json=true"]