describe('Fullstack App Smoke Test', () => {
  it('Loads homepage', () => {
    cy.visit('/')
    cy.get('#root', { timeout: 10000 }).should('exist') // Ensure React is mounted
    cy.url().should('include', '/')                     // Confirm it's the base URL
  })

  it('API returns posts', () => {
    cy.request('/api/posts')
      .its('status')
      .should('eq', 200)
  })
})

