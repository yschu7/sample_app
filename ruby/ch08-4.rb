#!/usr/bin/env ruby
countdown = Object.new       # A plain old object
def countdown.each           # The each iterator as a singleton method
  yield 3
  yield 2
  yield 1
end
countdown.extend(Enumerable) # Now the object has all Enumerable methods 
p countdown.sort             # [1, 2, 3]

module Mymod
  module MyClassMethod
    def hello
      "Hello!"
    end
    def bye
      "Bye Bye!"
    end
  end
  def hello
    "Hello from #{self}"
  end
  def bye
    "Bye from #{self}"
  end
end
class MyOrg
  include Mymod
  extend Mymod::MyClassMethod
end
p MyOrg.hello   # "Hello!"
p MyOrg.bye     # "Bye Bye!"
obj = MyOrg.new
p obj.hello     # "Hello from #<MyOrg:0x1d9b608>"
p obj.bye       # "Bye from #<MyOrg:0x1d9b608>"

module Mymod
  def self.included(base)
    base.extend(MyClassMethod)
  end
end

class MyTest
  include Mymod
end
p MyTest.hello   # "Hello!"
p MyTest.bye     # "Bye Bye!"
obj = MyTest.new
p obj.hello     # "Hello from #<MyTest:0x1d9b608>"
p obj.bye       # "Bye from #<MyTest:0x1d9b608>"

