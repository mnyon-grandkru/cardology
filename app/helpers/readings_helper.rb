module ReadingsHelper
  def card_reading_pane card, reading, title, subtitle, side = 'front', &block
    if side == 'fore' && @member.subscription_status != 'active'
      subscription_marketing_pane
    else
      div_for @birthday, "#{reading}_card_for", :class => "card_reading_pane pane #{side}" do
        content_tag(:header, title) +
        content_tag(:header, subtitle, :class => 'subtitle') +
        if card
          div_for(card, :identification_of) do
            div_for(card, :name_of) do
              card.name
            end +
            image_tag(card.image, :class => 'card_face_image') +
            div_for(Card.last, :opportunities_on) do
              "Want to learn more? #{link_to("Get the book.", ENV['BOOK_PURCHASE_LINK'], :target => '_blank')}".html_safe
            end
          end +
          div_for(card, :explication_of) do
            mark_up interpretation_of(card, reading)
          end
        end +
        if block_given?
          capture(&block)
        end
      end
    end
  end
  
  def subscription_marketing_pane
    card = @birthday.birth_card
    div_for @birthday, 'subscription_marketing_for', :class => "card_reading_pane pane fore" do
      content_tag(:header, marketing_text('subscription', 'teaser', 'header')) +
      content_tag(:header, marketing_text('subscription', 'teaser', 'subheader'), :class => 'subtitle') +
      div_for(card, :identification_of) do
        div_for(card, :name_of) do
          card.name
        end +
        image_tag(card.image, :class => 'card_face_image') +
        div_for(Card.last, :opportunities_on) do
          "Want to learn more? #{link_to("Get the book.", ENV['BOOK_PURCHASE_LINK'], :target => '_blank')}".html_safe
        end
      end +
      div_for(card, :explication_of) do
        mark_up marketing_text 'subscription', 'teaser', 'offer'
      end +
      link_to(marketing_text('subscription', 'teaser', 'accept'), 'javascript: null', :class => 'call_to_action trailing lunar_navigation') +
      link_to(marketing_text('subscription', 'teaser', 'defer'), 'javascript: null', :class => 'skip_card call_to_action trailing lunar_navigation')
    end
  end
  
  def zodiac_picker_for member, birthday
    if birthday == member.birthday
      link_to(birthday.zodiac_for_birthday.leader.capitalize, member_assign_zodiac_path(:id => member.id, :member => {:zodiac_sign => birthday.zodiac_for_birthday.leader}), :method => :put, :remote => true, :class => 'zodiac_selection flip_card') +
      link_to(birthday.zodiac_for_birthday.follower.capitalize, member_assign_zodiac_path(:id => member.id, :member => {:zodiac_sign => birthday.zodiac_for_birthday.follower}), :method => :put, :remote => true, :class => 'zodiac_selection flip_card')
    else
      link_to(birthday.zodiac_for_birthday.leader.capitalize, personality_for_zodiac_birthday_path(birthday, :zodiac_sign => birthday.zodiac_for_birthday.leader), :remote => true, :class => 'zodiac_selection flip_card') +
      link_to(birthday.zodiac_for_birthday.follower.capitalize, personality_for_zodiac_birthday_path(birthday, :zodiac_sign => birthday.zodiac_for_birthday.follower), :remote => true, :class => 'zodiac_selection flip_card')
    end
  end
end
