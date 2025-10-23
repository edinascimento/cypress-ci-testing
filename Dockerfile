FROM cypress/included:14.0.0

WORKDIR /e2e

COPY . .

RUN npm install

RUN npm install -g mochawesome mochawesome-merge mochawesome-report-generator

RUN mkdir -p cypress/reports

CMD ["npx", "cypress", "run", "--reporter", "mochawesome", "--reporter-options", "reportDir=cypress/reports,overwrite=false,html=true,json=true"]