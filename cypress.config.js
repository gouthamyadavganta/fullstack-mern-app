const { defineConfig } = require('cypress');

module.exports = defineConfig({
  e2e: {
    baseUrl: 'http://fullstack.mernappproject.com',
    supportFile: false,
  },
});
