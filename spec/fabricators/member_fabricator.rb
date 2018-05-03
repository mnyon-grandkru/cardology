Fabricator :member do
  email { Faker::Internet.email }
  password { Member.generate_password }
end

Fabricator :born_member, :from => :member do
  birthday
end
