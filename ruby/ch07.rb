#!/usr/bin/env ruby -w
def hello(name)
    print("Hello, ", name, ".\n")
end
hello("Ruby")                   #=> Hello, Ruby.

def hellox(name="Ruby")
 print("Hello, ", name, ".\n")
end
hellox("Perl")                   #=> Hello, Perl.
hellox()                         #=> Hello, Ruby.

def test(a, b=1, c=2, d)
  print "a = #{a}, b = #{b}, c = #{c}, d = #{d}\n"
end
test(7,8)
test(7,8,9)
test(7,8,9,0)

def print2(arr, &b)
  n = m = nil
  arr.each {|x| n = yield x}
  puts n
  arr.each {|y| m = b.call y}
  puts m
end
print2([1,2,5]) {|a| print a, "-"; a*2}
print2([3,9]) {|a| print a, "="; a*2}

lang = %w(ruby rython php perl)
p lang.map(&:upcase)       
p lang.map(&:capitalize) 

def arr(a, b=nil, *c, d)
    [a, b, c, d]
end
p arr(1,2)                      #=> [1, nil, [], 2]
p arr(1,2,["a","b","c"])        #=> [1, 2, [], ["a", "b", "c"]]
p arr(1,2,"a","b","c","d")      #=> [1, 2, ["a", "b", "c"], "d"]
p arr(1,2,"a","b")              #=> [1, 2, ["a"], "b"]
p arr(1,"a","b")  

def max(first, *rest)
  max = first
  rest.each {|x| max = x if x > max }
  max     
end
p max(1)       # first=1, rest=[]  
p max(1,2)     # first=1, rest=[2] 
p max(1,2,3)   # first=1, rest=[2,3]

module Enumerable
  def zip1(*args)
    n = 0
    self.each do |x|
      yield [ x, *args.map{|a| a[n]} ]
      n += 1
    end
  end
end
[1,2,3,4].zip1([4,5,6,7],[7,8,9,'a']){|a| p a}
[1,2,3,4].zip1{|a| p a}
[1,2,3,4].zip([4,5,6,7],[7,8,9,'a']){|a| p a}
[1,2,3,4].zip{|a| p a}

p max(*"hello world".each_char)

p "10,20,30,40".split(",")      #=> ["10", "20", "30", "40"]
p [1,2,3,4,5].index(3)          #=> 2
p [1,2,3,4,5].index(9)          #=> nil
p 1000.integer?                 #=> true

p a = Array.new                 #=> []
#f = File.open("ch07.rb")
p t = Time.new                  #=> 2009-03-14 17:52:06 +0800
p a = Array["a","b","x","y"]    #=> ["a", "b", "x", "y"]

p a = Array::new                #=> []
p t = Time::new                 #=> 2009-03-14 17:52:06 +0800

include Math
p sin(3.14)                     #=> 0.00159265291648683
#sleep(1)
print "hello!\n"                #=> hello!

o = "message" 
def o.printme 
  puts self
end
o.printme 
m = "Another message"
class << m
  def printme
    puts self
  end
end
m.printme

def hello                       # A nice simple method
  puts "Hello World"            # Suppose we want to augment it...
end
alias original_hello hello      # Give the method a backup name
def hello  # Now we define a new method with the old name, warning...
  puts "Your attention please"  # That does some stuff
  original_hello                # Then calls the original method
  puts "This has been a test"   # Then does some more stuff
end
hello

def sequence(args)
  n = args[:n] || 0
  m = args[:m] || 1
  c = args[:c] || 0
  a = []                    #Start with an empty array
  n.times {|i| a << m*i+c } #Calculate the value of each array element
  a                         #Return the array
end
p sequence({:n=>3, :m=>5})    # => [0, 5, 10]
p sequence(:m=>3, :n=>5)      # => [0, 3, 6, 9, 12]
p sequence c:1, m:3, n:5      # => [1, 4, 7, 10, 13]


