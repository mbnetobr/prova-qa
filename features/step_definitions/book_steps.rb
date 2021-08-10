Dado('que tenho um livro cadastrado') do
  @book = $stdin.call(ApiFakerRest).get({ url: "#{ENV['URI']}/Books", header: JSON.parse(ENV['HEADER']) }).first
end

Quando('cadastro um livro com a requisição POST para {string}') do |path|
  @endpoint = path
  body = FactoryBot.build(:create_book).to_hash
  books = $stdin.call(ApiFakerRest).get({ url: "#{ENV['URI']}#{@endpoint}", header: JSON.parse(ENV['HEADER']) })
  body[:id] = books.last['id'] + 100
  @request = { url: "#{ENV['URI']}#{@endpoint}", header: JSON.parse(ENV['HEADER']), body: body.to_json }
  @result = $stdin.call(ApiFakerRest).post(@request)
end

Quando('cadastro um livro com a requisição POST para {string} com {string} com {string}') do |endpoint, field, value|
  body = FactoryBot.build(:create_book).to_hash
  body = $stdin.call(ApiFakerRest).change_field_value(body, field, value)
  @request = { url: "#{ENV['URI']}#{endpoint}", header: JSON.parse(ENV['HEADER']), body: body.to_json }
  @result = $stdin.call(ApiFakerRest).post(@request)
end

Quando('tento cadastrar um livro com a requisição POST para {string} com id do livro cadastrado') do |endpoint|
  body = FactoryBot.build(:create_book).to_hash
  body[:id] = @book['id']
  @request = { url: "#{ENV['URI']}#{endpoint}", header: JSON.parse(ENV['HEADER']), body: body.to_json }
  @result = $stdin.call(ApiFakerRest).post(@request)
end

Quando('pesquiso um livro com a requisição GET para {string} com id {string}') do |endpoint, id_book|
  @request = { url: "#{ENV['URI']}#{endpoint}/#{id_book}", header: JSON.parse(ENV['HEADER']) }
  @result = $stdin.call(ApiFakerRest).get(@request)
end

Quando('pesquiso todos os livros com a requisição GET para {string}') do |endpoint|
  @request = { url: "#{ENV['URI']}#{endpoint}", header: JSON.parse(ENV['HEADER']) }
  @result = $stdin.call(ApiFakerRest).get(@request)
end

Quando('tento pesquisar livro com a requisição GET para {string} com id inexistente') do |endpoint|
  @request = { url: "#{ENV['URI']}#{endpoint}", header: JSON.parse(ENV['HEADER']) }
  books = $stdin.call(ApiFakerRest).get(@request)
  nonexistent_id = books.last['id'] + 1000
  @request[:url] << "/#{nonexistent_id}"
  @result = $stdin.call(ApiFakerRest).get(@request)
end

Quando('atualizo um livro com a requisição PUT para {string} com id {string}') do |path, id_book|
  @endpoint = path
  body = FactoryBot.build(:create_book).to_hash
  body[:id] = id_book.to_i
  @request = { url: "#{ENV['URI']}#{@endpoint}/#{id_book}", header: JSON.parse(ENV['HEADER']), body: body.to_json }
  @result = $stdin.call(ApiFakerRest).put(@request)
end

Quando('tento atualizar um livro com a requisição PUT para {string} com {string} com {string} com id {string}') do |endpoint, field, value, id_book|
  body = FactoryBot.build(:create_book).to_hash
  body = $stdin.call(ApiFakerRest).change_field_value(body, field, value)
  @request = { url: "#{ENV['URI']}#{endpoint}/#{id_book}", header: JSON.parse(ENV['HEADER']), body: body.to_json }
  @result = $stdin.call(ApiFakerRest).put(@request)
end

Quando('tento atualizar um livro com a requisição PUT para {string} com id inexistente') do |endpoint|
  @request = { url: "#{ENV['URI']}#{endpoint}", header: JSON.parse(ENV['HEADER']) }
  books = $stdin.call(ApiFakerRest).get(@request)
  nonexistent_id = books.last['id'] + 1000

  body = FactoryBot.build(:create_book).to_hash
  body[:id] = nonexistent_id

  @request[:url] << "/#{nonexistent_id}"
  @request.merge!(body: body.to_json)
  @result = $stdin.call(ApiFakerRest).put(@request)
end

Então('novo livro deve ser listado') do
  expected_body = @request[:body]
  @request = { url: "#{ENV['URI']}#{@endpoint}/#{JSON.parse(@request[:body])['id']}", header: JSON.parse(ENV['HEADER']) }
  @result = $stdin.call(ApiFakerRest).get(@request)
  expect(@result.response.body).to eql expected_body
end

Então('resposta deve conter corpo com dados do livro') do
  book = YAML.load_file(File.join(Dir.pwd, 'features/support/fixtures/book_id_1.txt'))
  expect(@result.parsed_response).to eql book
end

Então('resposta deve conter lista de livros com os campos preenchidos') do
  @result.each do |obj|
    expect(obj.key?('id')).to           be_truthy
    expect(obj['id']).not_to            be_nil
    expect(obj.key?('title')).to        be_truthy
    expect(obj['title']).not_to         be_nil
    expect(obj.key?('description')).to  be_truthy
    expect(obj['description']).not_to   be_nil
    expect(obj.key?('pageCount')).to    be_truthy
    expect(obj['pageCount']).not_to     be_nil
    expect(obj.key?('excerpt')).to      be_truthy
    expect(obj['excerpt']).not_to       be_nil
    expect(obj.key?('publishDate')).to  be_truthy
    expect(obj['publishDate']).not_to   be_nil
  end
end
