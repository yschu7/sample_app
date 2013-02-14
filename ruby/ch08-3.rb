#!/usr/bin/env ruby
#方法的可見性：public、private、protected
#沒有明確聲明，方法的預設可見性為public，一個例外是initialize，它總是private。
#另一個例外是定義在類別外的"全域"方法，他們被視為Object物件的私有實例方法。
#public方法可在任何地方被呼叫，沒有使用上的限制。
#private方法是用來實作一個類別的內部方法，他們只能被這的類別(或子類別)的實例方法所呼叫。
#private方法只能以隱式地被self物件所呼叫，不可經由一個物件進行顯示呼叫。
#例如m是一個private方法，那只能用m這種方式來呼叫它，不能用o.m或self.m來呼叫它。
#protected方法與private近似的地方是，它也只能在該類別或其子類別內被呼叫。
#與private方法不同之處在於，它可以被該類的實例顯示呼叫，而不僅僅是被self隱式呼叫。
#一個類別C所定義的protected pm方法，只有當物件o與p的類別都是C本身(或其子類別)時，
#物件p中的方法才可以呼叫物件o中的該pm方法。
class Point
  # public methods go here

  # The following methods are protected
  protected
  # protected methods go here

  # The following methods are private
  private
  # private methods go here
end
class Point
  attr_accessor :x, :y       # 定義存取方法
  protected :x=, :y=         # 將x=與y=設定成protected
  def initialize(x=0.0, y=0.0)
    @x = x
    @y = y
  end
  def swap(other)           # 用來交換x, y兩個值的方法
    xtmp, ytmp = @x, @y
    @x, @y = other.x, other.y
    other.x = xtmp          # 相同類別之間可以呼叫
    other.y = ytmp
    self
  end
end
pa = Point.new(1,2)
pb = Point.new(3,4)
pa.swap(pb)
p pa, pb
#pa.y = 5   # 錯誤！y=為protected方法

#限制方法的呼叫
class AccTest
  def pub
    puts "pub is a public method."
  end
  public :pub               # 將pub方法設定為public（不指定意義也一樣）
  def priv
    puts "priv is a private method."
  end
  private :priv             # 將priv方法設定為private
end
acc = AccTest.new
acc.pub                     #=> pub is a public method.
#acc.priv                   #=> 錯誤

#在Ruby中，public、private和protected僅僅應用於方法。
#被封裝的實例變數及類別變數在效果上是private，而常數則是public。
#如果想把類別方法變為private，可以使用private_class_method :方法名
#變回public則使用public_class_method :方法名
#Ruby的metaprogramming能力可以很容易實現呼叫private或protected方法。
class Widget
  def x    # Accessor method for @x
    @x
  end
  protected :x     # Make it protected
  def utility_method # Define a method
    nil
  end
  private :utility_method # And make it private
end
w = Widget.new                      # Create a Widget
w.send :utility_method              # Invoke private method!
w.instance_eval { utility_method }  # Another way to invoke it
w.instance_eval { @x }              # Read instance variable of w

