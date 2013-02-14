#!/usr/bin/env ruby
require_relative 'ch08-1'
# 我們可以定義單例方法(singleton method)：只對某個物件而非對一類物件有效的
# 方法，例如給一個物件Point定義sum方法
def Point.sum
  #... 
end
# 在此，類別方法(sum)無非就是代表該類別的Class實例(Point)上的單例方法。基本上，
# Ruby內所有東西都是物件，類別也不例外，它們是Class類別的實例。
puts "-"*30
puts String.class   # Class
puts Object.class   # Class
puts Kernel.class   # Module
Point.ancestors.each {|x|
  puts x.to_s + " : " + x.class.to_s
}
#Point : Class
#Comparable : Module
#Enumerable : Module
#Object : Class
#Kernel : Module
#BasicObject : Class
puts Class.to_s + " : " + Class.class.to_s   # Class是自己的實例。
#Class : Class

# 一個物件的單例方法並沒有被它的類別所定義，但它們也是方法，必須與某個類別產生
# 某種聯繫。一個物件的單例方法是它關連的匿名eigenclass的實例方法。"Eigen"是德
# 語單字，大致相當於"self、own、particular to或characteristic of"之意。
# eigenclass也被稱為單例類別(singleton class)，或稱之為metaclass。
# Ruby可以使用以下語法來打開一個物件的eigenclass並向其中加入方法，以免逐一定義
# 單例方法，而是一次為eigenclass定義多個單例方法。
class << Point
  def class_method1      # This is an instance method of the eigenclass.
  end                    # It is also a class method of Point.
  def class_method2
  end
end
# 若在class定義內部打開該類別物件的eigenclass，可以使用self來避免重複類別名。
class Point
  # instance methods go here
  class << self
    # class methods go here as instance methods of the eigenclass
  end
end
# 注意以下語法，三者意義皆不相同。
class Point           # Create or open the class Point(定義或開啟類別)
end
class Point3D < Point # Create a subclass of Point(繼承)
end
class << Point        # Open the eigenclass of the object Point
end
# 在打開一個物件的eigenclass時，self指向eigenclass物件，因此一般用以下方式獲得
# 物件Point的eigenclass
eigenclass = class << Point; self; end
# 或將之形式化為Object的一個方法，這樣就可以請求任意物件的eigenclass
class Object
  def eigenclass
    class << self; self; end
  end
end
# Ref: Why is the eigenclass of an object different from self.class?
Point.eigenclass.class_eval do
   def hello(name)
      puts "Hello " + name
   end
end
Point.hello("world")    # Hello world

#新版1.9.2已經有定義了此eigenclass，名為singleton_class，所以也可以這樣寫：
Point.singleton_class.class_eval do
   def hi(name)
      puts "Hi " + name
   end
end
Point.hi("Pal")        # Hi Pal

