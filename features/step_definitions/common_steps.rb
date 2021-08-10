Então('status da resposta deve ser {string}') do |status_code|
  expect(@result.response.code).to eql status_code
end
