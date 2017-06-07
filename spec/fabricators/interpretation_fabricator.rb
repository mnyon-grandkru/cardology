Fabricator :interpretation do
  card { Fabricate :card }
  explanation "you all good"
  reading { Interpretation.readings.keys.sample }
end
