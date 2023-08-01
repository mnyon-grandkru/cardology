module GuidancesHelper
	def split_carousel_text(carousel_text)
		return [carousel_text] unless carousel_text.length > 450
		midpoint = carousel_text.length / 2
		split_point = carousel_text.index(' ', midpoint)
		first_half = carousel_text[0...split_point].strip + " ............."
		second_half = carousel_text[split_point..-1].strip
		return [first_half, second_half]
		end

	def show_carousel(carousel_text)
		split_carousel_text(carousel_text).each do |text|
				yield text unless text.strip.empty?
		end
	end

end



