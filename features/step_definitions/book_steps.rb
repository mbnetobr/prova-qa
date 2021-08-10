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
