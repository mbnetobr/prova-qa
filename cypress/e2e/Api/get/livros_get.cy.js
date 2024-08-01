/// <reference types="cypress"/>

describe('Consultar livros', () => {
    it('Deve realizar uma consulta através de um ID', () => {
        cy.request({
            method: 'GET',
            url: '/Authors/497',
        }).then((response) => {
            expect(response.status).to.equal(200)
            expect(response.body.id).not.be.null;
            expect(response.body.idBook).not.be.null;
            expect(response.body.firstName).not.be.null;
            expect(response.body.lastName).not.be.null;
        });
    });
})
