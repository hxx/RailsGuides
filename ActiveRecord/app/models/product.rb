class Product < ActiveRecord::Base
  # after_initialize
  after_initialize do |product|
    puts "You have initialized an object!"
  end

  # after_find
  after_find do |product|
    puts "You have found an object!"
  end

  # after_touch
  after_touch do |product|
    puts "You have touched an object"
  end
end
