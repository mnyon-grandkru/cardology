module CelestialsHelper
  def celestial_button_for celestial, shown = nil
    if celestial.birthday == shown
      if celestial.name.present?
        link_to(marketing_text('preserving', 'remove') + ' ' + celestial.identifier, celestial, :method => :delete, :class => 'lunar_navigation axis', :title => marketing_text('preserving', 'remove'))
      else
        link_to(marketing_text('preserving', 'dub'), edit_celestial_path(celestial), :class => 'lunar_navigation', :remote => true) +
        form_with(:model => celestial, :id => 'celestial_renaming') do |celestial_form|
          celestial_form.text_field(:name) +
          celestial_form.submit(:name)
        end +
        link_to(marketing_text('preserving', 'remove') + ' ' + celestial.identifier, celestial, :method => :delete, :class => 'lunar_navigation axis', :title => marketing_text('preserving', 'remove'))
      end
    else
      link_to celestial.identifier, birthday_path(celestial.birthday, :navigation_shown => true), :class => 'lunar_navigation'
    end
  end
end
