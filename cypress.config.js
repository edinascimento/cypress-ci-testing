const { defineConfig } = require("cypress");

module.exports = defineConfig({
  e2e: {
    setupNodeEvents(on, config) {

    },
    viewportWidth: 1280,
    viewportHeight: 720,
    chromeWebSecurity: false,
    video: true,
    screenshotOnRunFailure: true,
    specPattern: 'cypress/e2e/**/*.cy.{js,ts}',
  },
});
