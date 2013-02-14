#!/usr/bin/env ruby
require_relative 'ch08-1'

class Point3D < Point  # Define class Point3D as a subclass of Point
end
p2 = Point.new(1,2)
p3 = Point3D.new(1,2)
puts "-"*20 + $PROGRAM_NAME
print p2.to_s,' ',p2.class,"\n"   # prints "(1,2) Point"
print p3.to_s,' ',p3.class,"\n"   # prints "(1,2) Point3D"

class WorldGreeter
  def greet                      # Display a greeting
    puts "#{greeting} #{who}"
  end
  def greeting                   # What greeting to use
    "Hello"
  end
  def who                        # Who to greet
    "World"
  end
end
# Greet the world in Spanish
class SpanishWorldGreeter < WorldGreeter
  def greeting                   # Override the greeting
    "Hola"
  end
end
# We call a method defined in WorldGreeter, which calls the overridden
# version of greeting in SpanishWorldGreeter, and prints "Hola World"
SpanishWorldGreeter.new.greet    #=> Hola World

# super會呼叫父類別中與當前方法同名稱的方法。可以像普通方法一樣為super指定引數。
# 如果單獨使用super，不帶引數和括弧，會使用當前方法的所有參數對父類別的方法進行呼叫。
# 所以如果不要使用任何引數呼叫，則要顯示的使用空的括號super()表示。
class Point3D < Point
  attr_accessor :z
  def initialize(x,y,z)
    # Pass our first two arguments along to the superclass initialize
    # method
    super(x,y)
    # And deal with the third argument ourself
    @z = z;
  end
# 在Ruby中，對於抽象類別並不需要特別語法定義，任何類別它呼叫的方法是打算由其子類別
# 來進行實作的，就是一個抽象類別。
# This class is abstract; it doesn't define greeting or who
# No special syntax is required: any class that invokes methods that are
# intended for a subclass to implement is abstract.
  class AbstractGreeter
     def greet
        puts "#{greeting} #{who}"
     end
  end
# A concrete subclass
  class WorldGreeter < AbstractGreeter
     def greeting; "Hello"; end
     def who; "World"; end
  end
  WorldGreeter.new.greet # Displays "Hello World"
# 類別方法可以像實例方法一樣被繼承和覆蓋。如果Point中定義了一個類別方法sum，那麽
# Point3D子類別會繼承這個方法，如若在Point3D中沒有定義sum，那Point3D.sum就會
# 與Point.sum呼叫同一方法。就程式維護考量，最好還是以類別方法定義時所在的類別來
# 呼叫。在類別方法的定義中，可以不明確指明接收者就呼叫其他類別方法，此時接收者隱式
# 地指向self。而在類別方法中的self就是所在類別，所以透過類別方法的繼承，它就可以
#  隱式的呼叫一個類別方法，即使此類別方法在父類別中。
# 最後，在類別方法內也可以使用super來呼叫父類別中的同名類別方法。
  def self.report3d
     report   #self.report which is defined in superclass Point
  end
# 所有的Ruby物件都包含一組實例變數，這些變數不是在相應的類別中被定義的，它們只是
# 在被賦值時才被建立起來。它們與繼承機制無關。不過要注意的是關於實例變數的名稱若在
# 子類別/父類別相同時(衝突)時，這時該物件只有一個變數，而它可能在父子類別內的解釋
# 不同，這可能讓父類別的運作不正常而又難以發現原因。尤其在繼承第三方類別庫或模組時。
  # Ruby's instance variables are not inherited and have nothing to do
  # with the inheritance mechanism. The reason that they sometimes
  # appear to be inherited is that instance variables are created by the
  # methods that first assign values to them, and those methods are
  # often inherited or chained.
  def to_s
    "(#@x, #@y, #@z)"  # Variables @x and @y inherited?
  end
# 當子類別Point3D重定義了一個常數ORIGIN時，這不是重新定義(Ruby沒有發出警告)，而是
# 新建立一個常數。現在我們有了兩個常數：Point::ORIGIN與Point3D::ORIGIN。
# 常數與方法的區別在於，常數首先在其語法空間尋找，然後才在繼承體系中尋找。這意味著如
# 果Point3D繼承的方法中使用到ORIGIN，那麽即使Point3D定義了自己的ORIGIN常數，這些
# 方法的行為也不受影響。
  ORIGIN = Point3D.new(0,0,0)

end
p3 = Point3D.new(1,2,3)
p [p3.x, p3.y, p3.z]   #=> [1, 2, 3]

Point3D.report3d
#=> output
# Number of points created: 6
# Average X coordinate: 0.666666666666667
# Average Y coordinate: 1.16666666666667

p Point3D.new(1,2,3).to_s  #=> "(1, 2, 3)"

# 類別變數可以被該類別及其子類別所共享，如果一個類別使用了類別變數，它的所有子類別和
# 後代類別都可以經由修改此類別變數來改變這個類別的行為，這也是使用類別實例變數而非類
# 別變數的一個有力論據。
# Class variables are shared by a class and all of its subclasses.
class A
  @@value = 1                 # A class variable
  def A.value; @@value; end   # An accessor method for it
end
print A.value                 # Display value of A's class variable
class B < A; @@value = 2; end # Subclass alters shared class variable
print A.value                 # Superclass sees altered value
class C < A; @@value = 3; end # Another alters shared variable again
puts B.value              # 1st subclass sees value from 2nd subclass
#=> 123

# 常數與實例方法相似，可以被繼承及覆蓋。
# Constants are inherited and can be overridden, much like instance
# methods can.
puts Point::ORIGIN      #=> (0, 0)
puts Point3D::ORIGIN    #=> (0, 0, 0)

