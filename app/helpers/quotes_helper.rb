module QuotesHelper
  def quote
    q = Quote.order_by_rand.take
    return unless q
    content_tag :div, :class => 'quote_single' do
      [
        content_tag(:span, "“#{q.phrasing}”", :class => 'poignant_quote'),
        content_tag(:span, q.source, :class => 'poignant_person')
      ].join.html_safe
    end
  end
end
