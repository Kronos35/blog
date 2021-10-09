puts "\n------------------"

users = (0..100).to_a.map do |n|
  print "\rCreating Users #{n}%"
  FactoryBot.create :user, :sequential_user
end

puts "\n------------------"

users.each_with_index do |user, i|
  print "\rCreating Posts #{i}%"
  FactoryBot.create_list :post, 3, user: user
end

puts "\n------------------"
puts "\nSeeding completed."
