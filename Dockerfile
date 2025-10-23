FROM cypress/included:latest

WORKDIR /e2e

COPY . .

RUN npm install

RUN mkdir -p cypress/reports

CMD ["npx", "cypress", "run", "--reporter", "mochawesome", "--reporter-options", "reportDir=cypress/reports,overwrite=false,html=true,json=true"]
