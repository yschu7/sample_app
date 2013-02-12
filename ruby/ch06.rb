#!/usr/bin/env ruby -w
3.times do
  print "Hello, world\n"
end
5.times do |i|
  name = "Y.S."
  print "No. #{i} : Hi! #{name}\n"
end
from, to, sum = 1, 100, 0
for i in from..to
  name = "Sum:"
  sum += i
end
puts name + sum.to_s
names = [ "Python", "Perl", "Ruby", "Tcl", "Awk" ]
names.each do |lang|
  puts lang
end
for lang in names do
  puts lang
end
hash = { a:1, b:2, c:3 }
for key, value in hash
  puts "#{key} => #{value}"
end
hash.each_pair do |key, value|
  puts "#{key} => #{value}"
end
class Music
  def each
    yield "Classical"
    yield "Jazz"
    yield "Rock"
  end
end
music = Music.new
for genre in music
  print genre, " "
end
puts
music.each do |genre|
  print genre, "-"
end
puts
i = 0
loop do
  i += 1
  next if i < 3
  print i
  break if i > 4
end
puts
# puts "Please enter the first word you think of"
# words = %w(apple banana cherry)   
# resp = words.collect do |word|
#   print word + "> "
#   response = gets.chop
#   if response.size == 0
#     word.upcase!
#     redo 
#   end
#   response
# end
# p resp
x = 3
(
  puts "x = %d" % x
  x -= 1
) until x == 0

y = 3
begin
  puts "y = %d" % y
  y -= 1
end until y == 0

x = 1
(
  puts "x = %d" % x
  x -= 1
) while x > 1

x = 1
begin
  puts "x = %d" % x
  x -= 1
end while x > 1

klass = Fixnum
begin
  print klass
  klass = klass.superclass
  print " < " if klass
end while klass
puts
p Fixnum.ancestors

chars = "hello world".tap {|x| puts "original object: #{x.inspect}"}
  .each_char         .tap {|x| puts "each_char returns: #{x.inspect}"}
  .to_a              .tap {|x| puts "to_a returns: #{x.inspect}"}
  .map {|c| c.succ } .tap {|x| puts "map returns: #{x.inspect}" }
  .sort              .tap {|x| puts "sort returns: #{x.inspect}"}
print chars

