#!/bin/ruby
class GetRecommendedScore
  def manage_input_data(filename)
    if filename
      recomm_hash, recomm_arr = {}, []
      file = File.open(filename, "r")
      file.each_line do |line|
        input = line.chomp
        if input == ''
          next
        elsif input == 'EXIT'
          break     
        elsif input.include? 'recommends' 
          parsed_data = input.split(' ')
          recomm_arr << [parsed_data[2].strip.to_s.downcase, parsed_data[4].strip.to_s.downcase]
        elsif input.include? 'accepts' 
          parsed_data = input.split(' ')
          recomm_arr.each do |arr|
            if arr[1] == parsed_data[2].strip.downcase 
              if recomm_hash.keys.member? arr[0]           
                recomm_hash.merge!({arr[0] => (recomm_hash[arr[0]] + [arr[1]])})
              else
                recomm_hash.merge!({arr[0] => [arr[1]]})
              end
              break
            end                    
          end
        end  
      end
      file.close
      print organize_level_score(recomm_hash)
    else
      print 'Please pass valid filename'
    end       
  end

  def organize_level_score(recomm_hash)
    result_hash = {}
    recomm_hash.each do |score|
      total = 0.0
      sum, count = 0.0, 0
      score[1].each do |value|
        total += calculate_level_score(recomm_hash, value, sum, count)
      end
      result_hash.merge!({score[0].upcase => total})
    end
    result_hash  
  end

  def calculate_level_score(recomm_hash, value, sum, count) 
    if recomm_hash.keys.include?(value)
      sum += (0.5)**count
      count += 1
      recomm_hash[value].each do |val|
        sum = calculate_level_score(recomm_hash, val, sum, count)        
      end
    else
      sum += (0.5)**count
    end
    return sum
  end  
end  

