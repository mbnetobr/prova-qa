Então('status da resposta deve ser {string}') do |status_code|
  expect(@result.response.code).to eql status_code
end

Então('resposta deve conter corpo da requisição enviada') do
  expect(@result.body).to eql @request[:body]
end
