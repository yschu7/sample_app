#!/usr/bin/env ruby
#---------------------------------------------------------------------
#使用類別實例變數(class instance variable)
#---------------------------------------------------------------------
# 定義類別實例變數：在類別定義內、實例方法之外。(都是實例變數，以@開頭，勿混淆)
# 類別實例變數與類別變數相似，都與類別本身相關連，而非與某個特定實例相關連。
# 與類別變數不同的是類別實例變數不可以在實例方法內引用，變通的方法是使用時，以
# self.class開頭(實例方法的self.class就是類別)。
# 另外一種就是定義類別方法來使用它，如此就不用再每個變數前加上self.class。
# 類別變數本質上和實例變數不同，它永遠在定義它的類別中求值，可以在實例方法、類別
# 方法內或是類別定義內(方法之外)使用。而對於實例變數而言，它的求值總是參考self，
# 所以就跟它所在位置的上下文有關。在實例方法內就是實例變數，在類別方法內就視為
# 類別實例變數。
class Point           
   attr_accessor :x, :y
   class << self       # Define class instance variables
      attr_accessor :n, :totalX, :totalY, :sw_first
   end
   def initialize(x,y)
      @x, @y = x, y
      init unless self.class.sw_first
      record(self)
   end
   def init
      self.class.n = 0
      self.class.totalX = 0.0
      self.class.totalY = 0.0
      self.class.sw_first = true
   end
   def record(point)    # Record a new point
      self.class.n += 1
      self.class.totalX += point.x
      self.class.totalY += point.y
   end

   def report            # Report point statistics
      puts "self.class #{self.class}"
      puts "Number of points created: #{self.class.n}"
      puts "Average X coordinate: #{self.class.totalX/self.class.n}"
      puts "Average Y coordinate: #{self.class.totalY/self.class.n}"
   end
end

class Point3D < Point; end
class Point4D < Point; end
p1 = Point3D.new(1,3)
p2 = Point3D.new(12,32)
p3 = Point3D.new(50,100)
p6 = Point4D.new(1,3)
p7 = Point4D.new(2,4)
p1.report
p6.report
# output
#self.class Point3D
#Number of points created: 3
#Average X coordinate: 21.0
#Average Y coordinate: 45.0
#self.class Point4D
#Number of points created: 2
#Average X coordinate: 1.5
#Average Y coordinate: 3.5

puts "-"*30
class PointA
  # Define accessor methods for our instance variables
  attr_accessor :x, :y  
 
  # Initialize class variables in the class definition itself
  @@n = 0              # How many points have been created
  @@totalX = 0         # The sum of all X coordinates
  @@totalY = 0         # The sum of all Y coordinates
  # 類別實例變數：定義在類別之中，實例方法之外的＠變數。
  # Initialize class instance variables in the class definition itself
  @n = 0              # How many points have been created
  @totalX = 0         # The sum of all X coordinates
  @totalY = 0         # The sum of all Y coordinates
 
  def initialize(x,y)
    @x,@y = x, y   # Sets initial values for instance variables
 
    # Use the class variables in this instance method to collect data
    @@n += 1       # Keep track of how many Points have been created
    @@totalX += x  # Add these coordinates to the totals
    @@totalY += y
  end
 
  # 類別實例變數不能在實例方法(如initialize)內使用，所以要另外定義類別方法。
  def self.new(x,y)   # Class method to create new Point objects
  # Use the class instance variables in this class method to collect data
    @n += 1       # Keep track of how many Points have been created
    @totalX += x  # Add these coordinates to the totals
    @totalY += y
   
    super      # Invoke the real definition of new to create a Point
  end
 
  # A class method to report the data we collected
  def self.report1
    # Here we use the class variables in a class method
    puts "Number of points created: #@@n"
    puts "Average X coordinate: #{@@totalX.to_f/@@n}"
    puts "Average Y coordinate: #{@@totalY.to_f/@@n}"
  end
 
  # A class method to report the data we collected
  def self.report2
    # Here we use the class instance variables in a class method
    puts "Number of points created: #@n"
    puts "Average X coordinate: #{@totalX.to_f/@n}"
    puts "Average Y coordinate: #{@totalY.to_f/@n}"
  end
end

p1 = PointA.new(1,3)
p2 = PointA.new(12,32)
p3 = PointA.new(50,100)
PointA.report1
PointA.report2
# output
#Number of points created: 3
#Average X coordinate: 21.0
#Average Y coordinate: 45.0
#Number of points created: 3
#Average X coordinate: 21.0
#Average Y coordinate: 45.0

puts "-"*30
# 類別實例變數的宣告賦值部分在繼承時(PointA)不會執行到，子類別本身要自行處理。
class PointC < PointA
  @n = 0              # How many points have been created
  @totalX = 0         # The sum of all X coordinates
  @totalY = 0         # The sum of all Y coordinates
end
class PointD < PointA
  @n = 0              # How many points have been created
  @totalX = 0         # The sum of all X coordinates
  @totalY = 0         # The sum of all Y coordinates
end
p1 = PointC.new(1,3)
p2 = PointC.new(12,32)
p3 = PointC.new(50,100)
p6 = PointD.new(1,3)
p7 = PointD.new(2,4)
PointC.report1
PointC.report2
PointD.report1
PointD.report2
#output
#Number of points created: 8
#Average X coordinate: 16.125
#Average Y coordinate: 34.625
#Number of points created: 3
#Average X coordinate: 21.0
#Average Y coordinate: 45.0
#Number of points created: 8
#Average X coordinate: 16.125
#Average Y coordinate: 34.625
#Number of points created: 2
#Average X coordinate: 1.5
#Average Y coordinate: 3.5

puts "="*30
# 關鍵是類別實例變數的定義是每個類別都有各自的一份，若要使繼承的子類別也定義，
# 而不使用eigenclass的寫法同時定義其accessor方法，可以用下面inherited hook
# 加上class_eval來定義並賦值。
class PointA
  def self.inherited(c)
    puts "class #{c} < #{self}"
    c.class_eval {
      @n = 0              # How many points have been created
      @totalX = 0         # The sum of all X coordinates
      @totalY = 0         # The sum of all Y coordinates
    }
  end
end
class PointE < PointA; end;
class PointF < PointA; end;
p1 = PointE.new(5,3)
p7 = PointF.new(6,4)
PointE.report1
PointE.report2
PointF.report1
PointF.report2
#output:
#class PointE < PointA
#class PointF < PointA
#Number of points created: 10
#Average X coordinate: 14.0
#Average Y coordinate: 28.4
#Number of points created: 1
#Average X coordinate: 5.0
#Average Y coordinate: 3.0
#Number of points created: 10
#Average X coordinate: 14.0
#Average Y coordinate: 28.4
#Number of points created: 1
#Average X coordinate: 6.0
#Average Y coordinate: 4.0

# 也可以使用instance_variable_set方法，效果相同。
  def self.inherited(c)
    c.instance_variable_set(:@n,0)
    c.instance_variable_set(:@totalX,0)
    c.instance_variable_set(:@totalY,0)
  end

