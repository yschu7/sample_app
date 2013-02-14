#!/usr/bin/env ruby
module Mod
   def meth
     puts "meth"
   end
   def calc
     puts "calc : #{pmeth}"
   end
   module_function :meth, :calc
   # 使用private，並不如我們的預期可以隱藏pmeth方法，但可以讓methd1呼叫。
   private
   def pmeth
     "pmeth"
   end
end
Mod::meth  # meth
#Mod::calc # 錯誤！undefined local variable or method `pmeth'
include Mod
meth       # meth
calc       # calc : pmeth
p pmeth    # "pmeth" (include Mod之後就可以呼叫)

module MyUtils
   module_function
   def hello
      puts "hello"
   end
   def world
      puts "world"
   end
end
include MyUtils
hello    # hello
world    # world

module Mod
   extend self   # 模組也是物件，也可以mix-in自己。
   def math
     puts "math"
   end
   def comp
     puts "comp : #{pmeth}"
   end
   # 如此可以達到類似module_function的效果，同時可以使用private達成隱藏
   # pmeth方法，但可以讓內部methd1呼叫。
   private
   def pmeth
     "private method"
   end
end
Mod::math     # math
Mod::comp     # comp : private method
#p Mod::pmeth  # 錯誤！private method `pmeth' called
include Mod
math          # math
comp          # comp : private method
p pmeth       # "private method" (include Mod之後就可以呼叫)

