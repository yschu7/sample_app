#!/usr/bin/env ruby
# coding: utf-8

$stdout.print "output to $stdout.\n"
$stderr.print "output to $stderr.\n"
puts "STDIN = #{STDIN}"
puts "STDOUT = #{STDOUT} #{STDOUT.object_id}"
puts "STDERR = #{STDERR} #{STDERR.object_id}"
puts $stdout.object_id
puts $stderr.object_id
if $stdin.tty?
  puts "$stdin is a TTY."
else
  puts "$stdin is not a TTY."
end
platform = %x(uname)
puts platform

require 'stringio'
def sio_print(sio)
  puts "-"*30
  sio.rewind
  sio.each_char {|ch|
    puts ch
  }
end
sio = StringIO.new("A\nB\nC\n\X\n")
4.times { p sio.gets }
sio = StringIO.new("中文測試AB")
p sio.getc
p sio.getc
sio.each_char {|ch|
  puts ch
}
sio.write('測試')
sio_print(sio)
sio.write('中文')
sio_print(sio)

$stdout.puts "foo", "bar", "baz"

$stdout.putc(82)        #=> R
$stdout.putc(65)        #=> A    
$stdout.putc(??)        #=> ?
$stdout.putc(?a)        #=> a
$stdout.putc(?R)        #=> R
$stdout.putc('中')
$stdout.putc("\n")         

open(IO::NULL,'w+') do |f|
  100.times {f.puts "xxx"}
  f.rewind
  p f.readlines
end

IO.popen("ls *.txt") do |f|
  arr = f.readlines
  arr.each {|fname| print "#{fname}"}
end
IO.write("abc.txt","Hello, world\n")
open("|cat abc.txt","r") do |f|
  print f.readlines 
end

open("| less", "w"){|f|
  f.puts "A string to display."
  f.puts "More string to display."
  f.puts "More and more string to display!"
  f.puts "....ls "
}
