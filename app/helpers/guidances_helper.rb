module GuidancesHelper
    
    def text_carousel(arr)
            split_arr = arr.split(".",3)    
            value1 = split_arr[0]+". " +split_arr[1]+". " 
            value2 = split_arr[2]
            join = []
            join<<value1
            join<<value2      
    end
end

