i = 123045

while i > 0 
  digit = i % 10
  i /= 10
  puts "#{digit}"
end


split=->(x, y=[]) {x < 10 ? y.unshift(x) : split.(x/10, y.unshift(x%10))}

puts "#{split.(1000)}" #=> [1,0,0,0]
puts "#{split.(1234)}" #=> [1,2,3,4]