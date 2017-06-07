Fabricator :birthday do
  year { (1900..2100).to_a.sample }
  month { (1..12).to_a.sample }
  day { (1..28).to_a.sample }
end
