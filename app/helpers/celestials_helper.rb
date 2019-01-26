module CelestialsHelper
  def celestial_button_for celestial, shown = nil
    if celestial.birthday == shown
      link_to marketing_text('preserving', 'remove') + ' ' + celestial.identifier, celestial, :method => :delete, :class => 'lunar_navigation axis', :title => marketing_text('preserving', 'remove')
    else
      link_to celestial.identifier, birthday_path(celestial.birthday, :navigation_shown => true), :class => 'lunar_navigation'
    end
  end
end
