Dado('que tenho um autor cadastrado') do
  @author = $stdin.call(ApiFakerRest).get({ url: "#{ENV['URI']}/Authors", header: JSON.parse(ENV['HEADER']) }).first
end

Dado('que tenho o autor') do |author|
  @author = author
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

Quando('que envio a requisição PUT para {string} com id {string}') do |path, id_author|
  @endpoint = path
  body = FactoryBot.build(:create_author).to_hash
  body[:id] = id_author.to_i
  @request = { url: "#{ENV['URI']}#{@endpoint}/#{id_author}", header: JSON.parse(ENV['HEADER']), body: body.to_json }
  @result = $stdin.call(ApiFakerRest).put(@request)
end

Quando('envio a requisição PUT para {string} com {string} com {string} com id {string}') do |endpoint, field, value, id_author|
  body = FactoryBot.build(:create_author).to_hash
  body = $stdin.call(ApiFakerRest).change_field_value(body, field, value)
  @request = { url: "#{ENV['URI']}#{endpoint}/#{id_author}", header: JSON.parse(ENV['HEADER']), body: body.to_json }
  @result = $stdin.call(ApiFakerRest).put(@request)
end

Quando('envio a requisição PUT para {string} com id inexistente') do |endpoint|
  @request = { url: "#{ENV['URI']}#{endpoint}", header: JSON.parse(ENV['HEADER']) }
  authors = $stdin.call(ApiFakerRest).get(@request)
  nonexistent_id = authors.last['id'] + 1000

  body = FactoryBot.build(:create_author).to_hash
  body[:id] = nonexistent_id

  @request[:url] << "/#{nonexistent_id}"
  @request.merge!(body: body.to_json)
  @result = $stdin.call(ApiFakerRest).put(@request)
end

Quando('envio a requisição GET para {string}') do |endpoint|
  @request = { url: "#{ENV['URI']}#{endpoint}", header: JSON.parse(ENV['HEADER']) }
  @result = $stdin.call(ApiFakerRest).get(@request)
end

Quando('envio {string} vezes a requisição GET para {string} com id {string}') do |amount, endpoint, id_author|
  @request = { url: "#{ENV['URI']}#{endpoint}/#{id_author}", header: JSON.parse(ENV['HEADER']) }
  (1..amount.to_i).each_with_index do |_k, i|
    @result = $stdin.call(ApiFakerRest).get(@request)
    raise "API apresentou inconsistência na [#{i + 1}]ª requisição" unless @result.response.body.eql?(@author)
  end
end

Quando('envio a requisição GET para {string} com id inexistente') do |endpoint|
  @request = { url: "#{ENV['URI']}#{endpoint}", header: JSON.parse(ENV['HEADER']) }
  authors = $stdin.call(ApiFakerRest).get(@request)
  nonexistent_id = authors.last['id'] + 1000
  @request[:url] << "/#{nonexistent_id}"
  @result = $stdin.call(ApiFakerRest).get(@request)
end

Quando('envio a requisição DELETE para {string} com o id do autor') do |endpoint|
  @request = { url: "#{ENV['URI']}#{endpoint}/#{@author['id']}", header: JSON.parse(ENV['HEADER']) }
  @result = $stdin.call(ApiFakerRest).delete(@request)
end

Então('resposta deve conter corpo da requisição enviada') do
  expect(@result.response.body).to eql @request[:body]
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

Então('resposta deve conter corpo com dados do autor requisitado') do
  expect(@result.response.body).to eql @author
end

Então('resposta deve conter lista de autores com os campos preenchidos') do
  @result.each do |obj|
    expect(obj.key?('id')).to        be_truthy
    expect(obj['id']).not_to         be_nil
    expect(obj.key?('idBook')).to    be_truthy
    expect(obj['idBook']).not_to     be_nil
    expect(obj.key?('firstName')).to be_truthy
    expect(obj['firstName']).not_to  be_nil
    expect(obj.key?('lastName')).to  be_truthy
    expect(obj['lastName']).not_to   be_nil
  end
end

Então('resposta deve conter lista com 4 autores') do |authors|
  authors = authors.gsub("\n", '').gsub(', ', ',')
  expect(@result.response.body).to eql authors
end

Então('consulta não deve exibir o autor excluído') do
  expect(@result.key?('id')).to        be_falsey
  expect(@result.key?('idBook')).to    be_falsey
  expect(@result.key?('firstName')).to be_falsey
  expect(@result.key?('lastName')).to  be_falsey
  expect(@result.response.code).to     eql '404'
end
