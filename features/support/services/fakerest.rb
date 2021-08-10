class ApiFakerRest
  def get(req)
    HTTParty.get(req[:url], params: req[:params], headers: req[:header], body: req[:body])
  end

  def post(req)
    HTTParty.post(req[:url], params: req[:params], headers: req[:header], body: req[:body])
  end

  def put(req)
    HTTParty.put(req[:url], params: req[:params], headers: req[:header], body: req[:body])
  end

  def change_field_value(hash, field, vle)
    value = change_value(vle)
    body = hash
    keys = []
    fields = field.split('.')
    fields.each { |x| keys << x.to_sym }
    body.each do |key, val|
      if body.dig(keys.last).eql?(val)
        body[key] = value
      elsif val.is_a?(Hash)
        change_field_value(val, field, vle)
      end
    end
    body
  end

  def change_value(value)
    case value
    when ''
      ''
    when '123'
      value.to_i
    when 'true'
      true
    else
      value
    end
  end
end
