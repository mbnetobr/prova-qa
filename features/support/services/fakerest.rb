class ApiFakerRest
  def get(req)
    HTTParty.get(req[:url], params: req[:params], headers: req[:header], body: req[:body])
  end

  def post(req)
    HTTParty.post(req[:url], params: req[:params], headers: req[:header], body: req[:body])
  end
end
