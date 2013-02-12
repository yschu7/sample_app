#!/usr/bin/env ruby
# The Ruby Way : Chapter 14
system("echo *")
puts "-"*60
system("echo", "*")
puts "-"*60
system("ls -l | head -n 10")
puts "-"*60

listing0 = `ls -l c*.rb`
listing1 = %x(ls -l c*.rb)
now0 = `date`
now1 = %x(date)
puts listing0
puts now0
puts "-"*60
puts "listing...." if listing0 == listing1
puts "date...." if now0 == now1

puts "-"*60
alias old_execute `

def `(cmd)
  out = old_execute(cmd)
  out.split("\n")
end

entries = `ls -l`
num = entries.size
puts num
first3lines = %x(ls -l | head -n 3)
how_many = first3lines.size
puts how_many

puts "-"*60
fork do
  puts "Ah, I must be the child."
  puts "I guess I'll speak as a child:-)"
end
puts "I'm the parent."

proc1 = Process.pid
fork do
  ppid = Process.ppid
  if ppid == proc1
    puts "proc1: #{proc1} is my parent."
  else
    puts "What's going on? my parent is #{ppid}"
  end
end
puts "-"*60
#sleep 0.5
