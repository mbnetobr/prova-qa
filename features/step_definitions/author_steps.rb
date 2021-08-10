Quando('que envio a requisição POST para {string}') do |path|
  @endpoint = path
  body = FactoryBot.build(:create_author).to_hash
  authors = $stdin.call(ApiFakerRest).get({ url: "#{ENV['URI']}#{@endpoint}", header: JSON.parse(ENV['HEADER']) })
  body[:id] = authors.last['id'] + 100
  @request = { url: "#{ENV['URI']}#{@endpoint}", header: JSON.parse(ENV['HEADER']), body: body.to_json }
  @result = $stdin.call(ApiFakerRest).post(@request)
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
