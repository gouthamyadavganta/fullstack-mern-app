describe('Fullstack App Smoke Test', () => {
  it('Loads homepage', () => {
    cy.visit('http://fullstack.mernappproject.com');
    cy.contains('Login'); // or 'Sign In', 'Posts', etc. – based on your actual UI
  });

  it('API returns posts', () => {
    cy.request('http://fullstack.mernappproject.com/api/posts')
      .its('status')
      .should('eq', 200);
  });
});
