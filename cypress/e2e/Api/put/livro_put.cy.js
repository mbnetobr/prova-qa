/// <reference types="cypress"/>

const faker = require('faker');

describe('Editar livro', () => {
    const randomId = faker.datatype.number();
    const randomTitle = faker.lorem.sentence();
    const randomPageCount = faker.datatype.number();
    const randomDescription = faker.lorem.paragraph();
    const randomexcerpt = faker.lorem.paragraph();
   
    it.only('Editando um livro!', () => {
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
                method: 'PUT',
                url: '/Books/' + bookId+1,
                body: {
                    "id": randomId,
                    "title": "Caio A.",
                    "description": "Teste em QA",
                    "pageCount": 144,
                    "excerpt": "Aprimorando",
                    "publishDate": faker.date.past().toISOString()
                }
            }).then((response) => {
                expect(response.status).to.equal(200)
                expect(response.body).to.have.property('id')
                expect(response.body).to.have.property('publishDate')
                expect(response.body.publishDate).not.be.null;
                expect(response.body).to.have.property('title', 'Caio A.');
                expect(response.body).to.have.property('description', 'Teste em QA');
                expect(response.body).to.have.property('pageCount', 144);
                expect(response.body).to.have.property('excerpt', 'Aprimorando');
            })
        })
    })
})

