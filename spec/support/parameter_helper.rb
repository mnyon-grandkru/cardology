def birthdate_parameters_from_date_picker attributes
  {
    'date(1i)' => attributes['year'],
    'date(2i)' => attributes['month'],
    'date(3i)' => attributes['day']
  }
end
