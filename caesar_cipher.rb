# This program takes in a string and a shift value. Then encrypts the message by using Ceasars Cipher and displays the new message. The program can process just about any positive integer by taking the shift value and reducing the cycles it would take from going from z to a to just 1. IE. a shift number of 60 would get reduced to 8 since there are 26 letters.

# TODO:
# Validation for shift value
# Process negative shift values

# ASCII Decimals
# a to z in decimals = 97 - 122
# A to Z in decimals = 65 - 90

# Pass the string and shift factor to the cipher method
def encrypt message, shift
  letters = 26

  # Converts the string into an array with ascii decimals
  message_array = to_ascii(message);

  # TEST
  print "ASCII Code: "
  message_array.each do |i|
    print i.to_s + " "
  end
  puts ""

  shift = shift_wrapper(shift, letters)

  # Traverses to the end of the array
  counter = 0

  while counter < message_array.length
    # Checks if we have a valid letter, skips the index if not

    # is Uppercase
    if message_array[counter] > 64 and message_array[counter] < 91
      # Checks if adding the shift will make the letter go over 91
      if message_array[counter] + shift > 90
        # Wraps around from Z to A 
        # Example: 90 when shifted by 5 is 95. So we add 5 to 90 and
        # subtract 91 to get 4. 
        message_array[counter] += shift - letters
      else
        message_array[counter] += shift
      end
    # is Lowercase
    elsif message_array[counter] > 96 and message_array[counter] < 123
      # Checks if adding the shift will make the letter go over 123
      if message_array[counter] + shift > 122
        # Wraps around from z to a 
        # Example: 120 when shifted by 5 is 125. So we add 5 to 120 and subtract 123 to get 2.
        message_array[counter] += shift - letters
      else
        message_array[counter] += shift
      end
    end

    counter += 1
  end

  # TEST
  print "NEW ASCII Code: "
  message_array.each do |i|
    print i.to_s + " "
  end
  puts ""

  # Converts the array to a string with characters
  message_array = to_char(message_array)

  # Cipher method returns the new string
  return message_array

end

# Provide a string
def to_ascii string
  # Splits the string into an array to avoid overuse of #to_s
  message_array = string.split("")

  # Converts characters into ascii
  message_array.each_index do |i| 
    message_array[i] = message_array[i].ord 
  end

  return message_array
end

# Provide an array
def to_char array
  # Converts ascii to characters
  array.each_index do |i|
    array[i] = array[i].chr
  end

  # Converts the array into a string before returning it
  return array.join
end

# Cuts the shift to a size from 0 to letters - 1
# This optimizes #encrypt from having to wrap around
# more than once.
def shift_wrapper shift, letters
  return shift % letters
end

# Take in a string and a shift factor
puts "Enter a message you wish to encrypt: "
message = gets.chomp

puts "Enter a shift factor to encrypt your message by: "
shift = gets.chomp.to_i

new_message = encrypt(message, shift)

puts "Your new encrypted message: "
puts new_message