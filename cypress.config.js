const { defineConfig } = require("cypress");

module.exports = defineConfig({
  e2e: {
    setupNodeEvents(on, config) {

    },
    viewportHeight: 1280,
    viewPortHeight: 720,
    chromeWebSecurity: false,
    video: true,
    screenshotOnRunFailure: true,
    specPattern: 'cypress/e2e/**/*.cy.js',
    webSecurity: true,
    insecureSkipDomain: true,
  },
});
