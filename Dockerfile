# Use an official Cypress image that includes Node.js and browsers
FROM cypress/browsers:node-20.5.0-chrome-114.0.5735.133-1-ff-114.0.2-edge-114.0.1823.51-1

# Create and set the working directory
WORKDIR /e2e

# Copy package.json and install dependencies
# This is an optimization to leverage Docker's layer caching
COPY package*.json ./
RUN npm install

# Copy all other project files
COPY . .

# Specify the command to run the tests
# The `cypress/browsers` images have `cypress run` as the default entrypoint
# This means you can omit it in the `docker run` command
ENTRYPOINT ["npx", "cypress", "run"]
