#!/usr/bin/env ruby
require_relative "ch08-1"

#A Class Method
#在類別定義內的3種寫法
class Point
# Return the sum of an arbitrary number of points 
   def Point.sum1(*points)
      x = y = 0
      points.each {|p| x += p.x; y += p.y }
      Point.new(x,y)
   end
# Return the sum of an arbitrary number of points 
   def self.sum2(*points)
      x = y = 0
      points.each {|p| x += p.x; y += p.y }
      Point.new(x,y)
   end
# Return the sum of an arbitrary number of points 
   class << self
      def sum3(*points)
         x = y = 0
         points.each {|p| x += p.x; y += p.y }
         Point.new(x,y)
      end
   end
end
#在類別定義外的寫法
# Open up the Point object so we can add methods to it
class << Point      # Syntax for adding methods to a single object
   def sum4(*points)  # This is the class method Point.sum
       x = y = 0
       points.each {|p| x += p.x; y += p.y }
       Point.new(x,y)
   end
end
p1 = Point.new(3,5)
p2 = Point.new(1,2)
p3 = p1 + p2
puts "-"*20 + $PROGRAM_NAME
print p1.to_s, p2.to_s, p3.to_s, "\n" # [3, 5][1, 2][4, 7]
p p4 = Point.sum1(p1,p2,p3)   # [8, 14]
p p4 = Point.sum2(p1,p2,p3)   # [8, 14]
p p4 = Point.sum3(p1,p2,p3)   # [8, 14]
p p4 = Point.sum4(p1,p2,p3)   # [8, 14]

#定義類別的另一種方式：Class.new
def MyStruct(*keys)
    Class.new do
        attr_accessor *keys
        def initialize(hash)
            hash.each do |key, value|
                instance_variable_set("@#{key}", value)
            end
        end
    end
end
Person = MyStruct :name, :address, :likes
dave = Person.new(name: "dave", address: "TX", likes: "Stilton")
chad = Person.new(name: "chad", likes: "Jazz")
chad.address = "CO"
puts "Dave's name is #{dave.name}"
puts "Chad lives in #{chad.address}"
#=> Dave's name is dave
#=> Chad lives in CO

