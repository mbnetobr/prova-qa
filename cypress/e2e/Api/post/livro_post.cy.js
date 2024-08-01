/// <reference types="cypress"/>

const faker = require('faker');

describe('Inserir livro', () => {
    const randomId = faker.datatype.number();
    const randomTitle = faker.lorem.sentence();
    const randomPageCount = faker.datatype.number();
    const randomDescription = faker.lorem.paragraph();
    const randomexcerpt = faker.lorem.paragraph();
    it('Deve inserir um livro com sucesso!', () => {
        cy.request({
            method: 'POST',
            url: '/Books',
            body: {
                "id": randomId,
                "title": randomTitle,
                "description": randomDescription,
                "pageCount": randomPageCount,
                "excerpt": randomexcerpt,
                "publishDate": faker.date.past().toISOString()
            }
        }).then((response) => {
            expect(response.status).to.equal(200)
            expect(response.body).to.have.property('id')
            expect(response.body).to.have.property('publishDate')
            expect(response.body.id).not.be.null;
            expect(response.body.publishDate).not.be.null;
        })
    })
})

