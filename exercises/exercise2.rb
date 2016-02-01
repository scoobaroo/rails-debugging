# Start by opening pry and requiring this file
#   $ pry
#   require './exercise2.rb'

# if that went well you should be able to do:
#   dude = Dude.new
#   dude.say_hello
#   cow = Cow.new
#   cow.say_hello

# Exercise 1 : edit
# Use the pry `ls` and `cd` commands to enter Cow and see it's methods
# Use the pry edit or edit-method commands to fix Cow to be more cow-like.
# Test your fix in pry
# Did the original `cow` get fixed too?

# Don't edit this file here!  Use pry!
class Dude
  def say_hello
    puts "yo"
  end
end

class Cow
  def say_hello
    puts "yo"
  end

  def eat
    puts 'nom nom'
  end
end
