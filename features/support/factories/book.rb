FactoryBot.define do
  factory :create_book, class: BookModel do
    id { nil }
    title { Faker::Book.title }
    description { "Descrição do livro [#{title}]" }
    pageCount { Faker::Number.number(digits: 3) }
    excerpt { "Trecho do livro [#{title}]" }
    publishDate { '2010-01-01T00:00:00' }
  end
end
