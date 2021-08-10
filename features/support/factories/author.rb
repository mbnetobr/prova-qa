FactoryBot.define do
  factory :create_author, class: AuthorModel do
    id { nil }
    idBook { 1 }
    firstName { Faker::Name.first_name.gsub(%r{([_@#!\-=;,{}\~\./\?\"\'\-]+)}, '') }
    lastName { Faker::Name.last_name.gsub(%r{([_@#!\-=;,{}\~\./\?\"\'\-]+)}, '') }
  end
end
