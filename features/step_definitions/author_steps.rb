Dado('que tenho um autor cadastrado') do
  @author = $stdin.call(ApiFakerRest).get({ url: "#{ENV['URI']}/Authors", header: JSON.parse(ENV['HEADER']) }).first
end

Quando('que envio a requisição POST para {string}') do |path|
  @endpoint = path
  body = FactoryBot.build(:create_author).to_hash
  authors = $stdin.call(ApiFakerRest).get({ url: "#{ENV['URI']}#{@endpoint}", header: JSON.parse(ENV['HEADER']) })
  body[:id] = authors.last['id'] + 100
  @request = { url: "#{ENV['URI']}#{@endpoint}", header: JSON.parse(ENV['HEADER']), body: body.to_json }
  @result = $stdin.call(ApiFakerRest).post(@request)
end

Quando('que envio a requisição POST para {string} com id do autor cadastrado') do |endpoint|
  body = FactoryBot.build(:create_author).to_hash
  body[:id] = @author['id']
  @request = { url: "#{ENV['URI']}#{endpoint}", header: JSON.parse(ENV['HEADER']), body: body.to_json }
  @result = $stdin.call(ApiFakerRest).post(@request)
end

Quando('envio a requisição POST para {string} com {string} com {string}') do |endpoint, field, value|
  body = FactoryBot.build(:create_author).to_hash
  body = $stdin.call(ApiFakerRest).change_field_value(body, field, value)
  @request = { url: "#{ENV['URI']}#{endpoint}", header: JSON.parse(ENV['HEADER']), body: body.to_json }
  @result = $stdin.call(ApiFakerRest).post(@request)
end

Quando('que envio a requisição GET para {string} com id {string}') do |endpoint, id_author|
  @request = { url: "#{ENV['URI']}#{endpoint}/#{id_author}", header: JSON.parse(ENV['HEADER']) }
  @result = $stdin.call(ApiFakerRest).get(@request)
end

Então('resposta deve conter corpo da requisição enviada') do
  expect(@result.response.body).to eql @result.response.body
end

Então('novo autor deve ser listado') do
  expected_body = @request[:body]
  @request = { url: "#{ENV['URI']}#{@endpoint}/#{JSON.parse(@request[:body])['id']}", header: JSON.parse(ENV['HEADER']) }
  @result = $stdin.call(ApiFakerRest).get(@request)
  expect(@result.response.body).to eql expected_body
end

Então('resposta deve conter corpo com dados do autor') do |author|
  expect(@result.response.body).to eql author
end
