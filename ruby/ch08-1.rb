#!/usr/bin/env ruby
class Point
#Define accessor methods for instance variables
   attr_accessor :x, :y 
   def initialize(x,y)        
      @x, @y = x, y
   end
   def to_s    # Return a String that represents this point
      #[@x, @y]
      "(#@x, #@y)"
   end
   def pr_point
      print "%02d %02d\n" % [self.x, self.y]
   end
   def +(other)   # Define + to do vector addition
      Point.new(@x + other.x, @y + other.y)
   end
   def -@         # Define unary minus to negate both coordinates
      Point.new(-@x, -@y)
   end
   def *(scalar)  # Define * to perform scalar multiplication
      Point.new(@x*scalar, @y*scalar)
   end
# If we try passing a Point to the * method of an Integer, it will call
# this method on the Point and then will try to multiply the elements of
# the array. Instead of doing type conversion, we switch the order of
# the operands, so that we invoke the * method defined above.
   def coerce(other)
      [self, other]
   end
# Define [] method to allow a Point to look like an array or
# a hash with keys :x and :y
   def [](index)
     case index
     when 0, -2 then @x     # Index 0 (or -2) is the X coordinate
     when 1, -1 then @y     # Index 1 (or -1) is the Y coordinate
     when :x, "x" then @x   # Hash keys as symbol or string for X
     when :y, "y" then @y   # Hash keys as symbol or string for Y
     else nil       # Arrays and hashes just return nil on bad indexes
     end
   end
# defining the each iterator allows us to mix in the methods of the
# Enumerable module
   include Enumerable
# This iterator passes the X coordinate to the associated block, and then
# passes the Y coordinate, and then returns. It allows us to enumerate
# a point as if it were an array with two elements. This each method is
# required by the Enumerable module.
   def each
     yield @x
     yield @y
   end
#Point Equality
   def ==(o)               # Is self == o?
     if o.is_a? Point      # If o is a Point object
       @x==o.x && @y==o.y  # then compare the fields.
     elsif                 # If o is not a Point
       false               # then, by definition, self != o.
     end
   end
   def eql?(o)           
     if o.instance_of? Point    
       @x.eql?(o.x) && @y.eql?(o.y)
     elsif
       false
     end
   end
# Because eql? is used for hashes, you must never implement this
# method by itself. If you define an eql? method, you must also
# define a hash method to compute a hashcode for your object. 
   def hash
     code = 17
     code = 37*code + @x.hash
     code = 37*code + @y.hash
     # Add lines like this for each significant instance variable
     code  # Return the resulting code
   end
# Ordering Points
   include Comparable   # Mix in methods from the Comparable module.
# Define an ordering for points based on their distance from the origin.
# This method is required by the Comparable module.
# Enumerable module defines several methods, such as sort, min, and max,
# that only work if the objects being enumerated define the <=> operator.
   def <=>(other)
     return nil unless other.instance_of? Point
     @x**2 + @y**2 <=> other.x**2 + other.y**2
   end
# A Mutable Point
   def add!(p)          # Add p to self, return modified self
     @x += p.x
     @y += p.y
     self
   end
   def add(p)           # A nonmutating version of add!
     q = self.dup       # Make a copy of self
     q.add!(p)          # Invoke the mutating method on the copy
   end
# Inherit by Point3D (ch08-6.rb)
   def self.report
     nil
   end

   ORIGIN = Point.new(0,0)
end
p Point.ancestors    # [Point, Comparable, Object, Kernel, BasicObject]
p1 = Point.new(3,5)
puts p1.is_a? Point  # true
puts p1.class        # Point
print "%2d %2d\n" % [p1.x, p1.y]    #  3  5
p p1                 # [3, 5]   (to_s)
p1.pr_point          # 03 05
p2 = Point.new(1,2)
p p3 = p1 + p2       # [4, 7]
p -p3                # [-4, -7]
p p1 * 2             # [6, 10]
p 2 * p1             # [6, 10]  (coerce)
puts "="*20 + $PROGRAM_NAME
print "(%2d %2d)\n" % [p1[:x], p1[:y]]  # ( 3  5)
print "(%2d %2d)\n" % [p2[0], p2[1]]    # ( 1  2)

p3.each {|x| print x} # 47
puts ""
p p3.map {|x| x * 3}  # [12, 21] (mix in method)
p p3.inject(&:*)      # 28
p p1 == p2            # false
p p3.eql?(Point.new(4,7))  # true
p,q = Point.new(1,0), Point.new(0,1)
p p == q        # false (p is not equal to q)
p p < q         # false (p is not less than q)
p p > q         # false (p is not greater than q)
p p.add!(q)     # [1, 1]
p p.add(q)      # [1, 2]

