describe('Example to Teste - Google', () => {
    it(`Deve acessar o Google e validar titulo`, () => {
        cy.visit('https://www.google.com/', {
            failOnStatusCode: false,
            ssl: false,
        });

        cy.title().should('include', 'Google');
    })

    // it(`Deve buscar no Google`, () => {
    //     cy.visit('https://www.google.com/', {
    //         failOnStatusCode: false,
    //         ssl: false,
    //     });
    //
    //     cy.get('textarea[name="q"]').type('Cypress Testing')
    //     cy.contains('Pesquisa Google').click({ force: true });
    //     cy.url().should('include', 'search');
    // })
})