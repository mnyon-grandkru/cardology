module GuidancesHelper
    
    def text_carousel(carousel_string)
            split_string = carousel_string.split(".",3) || split_string = carousel_string.split("?",3)
            value1 = split_string[0]+". " +split_string[1]+". " 
            value2 = split_string[2]
            join_strings = []
            join_strings<<value1
            join_strings<<value2 
    end
    
end



