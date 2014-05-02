class Product < ActiveRecord::Base
  # set table_name
  self.table_name = "PRODUCT"
  # set primary_key
  self.primary_key = "product_id"
end


# CRUD

# Create
# create and save a new record into the databasde
user = User.create(name: "David", occupation: "Code Arist")
# an object can be instantiated without being save:
user = User.new
user.name = "David"
user.occupation = "Code Artist"
# class user.save to commit the record to the database
user.save
# use block
user = User.new do |u|
  u.name = "David"
  u.occupation = "Code Artist"
end

# Read
# return a collection with all users
users = User.all
# return the first user
user = User.first
# return the first user named David
david = User.find_by(name: 'David')
# find all users named David who are Code Artists and sort by created_at in reverse chronological order
users = User.where(name: 'David', occupation: 'Code Artist').order('created_at DESC')

# Update
user = User.find_by(name: 'David')
user.name = 'Dave'
user.save
# shorthand
user = User.find_by(name: 'David')
user.update(name: 'Dave')
# update all
User.update_all "max_login_attempts = 3, must_change_password = 'true'"

# Delete
user = User.find_by(name: 'David')
user.destroy
