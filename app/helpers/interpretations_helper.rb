module InterpretationsHelper
  def meaning_of_reading card_name
    case card_name
    when :moon
      'The way light is reflected back to us, supporting us.'
    when :birth
      'The light we shine in life. The gift we give in the world.'
    when :mercury
      'How we think, talk, and communicate. How our mind works. How we form conceptual frameworks.'
    when :venus
      'What we are receptive to in life. What we love in life. What our feminine side looks like.'
    when :mars
      'Where we place our aggressive, competitive passions. What our masculine side looks like.'
    when :jupiter
      'What expands our energy. What brings more abundance into our life. Or, what inflates our ego.'
    when :saturn
      'What contracts our energy. How we learn our lessons in life. Our pain points and growth points.'
    when :uranus
      'What keeps us firmly grounded to the Earth, and may ground us unexpectedly if we are caught unaware.'
    when :neptune
      'What lightens us and lifts us up. And, is also the subject of our fantasies, illusions and delusions.'
    when :pluto
      'Our unconscious. Our hidden side. It is the source of continual self-sabotage or else great blessings.'
    when :abundance, :princess
      'The reward we can expect in life for facing our fears and playing our cards right.'
    when :freedom, :prince
      'Where we must give attention to distinguish ourselves if we want to individuate our psyche and mature.'
    when :excellence, :queen
      'The energy we learn to fully embody, the personal excellence that empowers our evolution.'
    when :magician, :king
      'The pattern that allows us to make magic in our lives. How we hold power to shape-shift reality at will. It comes via all the growth, learning and lessons of initiation that allow us the right to hold this power.'
    when :result
      
    end
  end
  
  def sort_params
    params.permit(:suit, :reading, :sort, :by_face)
  end
end
