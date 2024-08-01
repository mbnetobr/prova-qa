/// <reference types="cypress"/>

const faker = require('faker');
describe('Delete', () => {

    it('Deve realizar delete de um livro com sucesso!', () => {
        const randomId = faker.datatype.number();
        const randomTitle = faker.lorem.sentence();
        const randomDescription = faker.lorem.paragraph();
        const randomexcerpt = faker.lorem.paragraph();
        cy.request({
            method: 'POST',
            url: '/Books',
            body: {
                "id": randomId,
                "title": randomTitle,
                "description": randomDescription,
                "pageCount": 0,
                "excerpt": randomexcerpt,
                "publishDate": faker.date.past().toISOString()
            }
        }).then((response) => {
            const bookId = response.body.id
            cy.request({
                method: 'DELETE',
                url: '/Authors/' + bookId,
                failOnStatusCode: false
            }).then((response) => {
                expect(response.status).to.equal(200)
            })
        })
    })

    it('Não deve realizar delete de um livro com ID inválido ', () => {
        const randomId = faker.datatype.number();
        const randomTitle = faker.lorem.sentence();
        const randomDescription = faker.lorem.paragraph();
        cy.request({
            failOnStatusCode: false,
            method: 'POST',
            url: '/Books',
            body: {
                "id": randomId + 100000000000,
                "title": randomTitle,
                "description": randomDescription,
                "pageCount": 0,
                "excerpt": "Não sei",
                "publishDate": faker.date.past().toISOString()
            }
        }).then((createResponse) => {
            const invalidBookId = createResponse.body.id;
            cy.request({
                failOnStatusCode: false,
                method: 'DELETE',
                url: '/Authors/' + invalidBookId,
            }).then((response) => {
                expect(response.status).to.equal(400)
                console.log(response)
            })
        })
    })

});

