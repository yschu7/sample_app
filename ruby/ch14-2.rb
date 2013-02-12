#!/usr/bin/env ruby
# The Ruby Way : Chapter 14
# 運行外部程序, 然後分別同該進程的標準輸入,標準輸出,標準錯誤輸出之間建立管道
require 'open3'
l, w, c = Open3.popen3 "wc" do |stdin, stdout, stderr|
  stdin.write File.read($0)
  stdin.close
  stdout.read.split
end
puts "This file contains #{l} lines, #{w} words, and #{c} characters."

filename = %w( file1 abc.rb ch14-1.rb ch14-2.rb oratab.rb )
inp, out, err = Open3.popen3("xargs", "ls", "-l")
filename.each {|f| inp.puts f}
inp.close     # close is necessary
output = out.readlines
errout = err.readlines
puts "Send #{filename.size} lines of input."
puts "Got back #{output.size} lines from stdout"
puts "and #{errout.size} lines from stderr."

stdin, stdout, stderr = Open3.popen3('nroff -man')
# 在這裡寫
Thread.fork do
  IO.popen('gzip -dc /usr/share/man/man1/join.1.gz') do |f|
    f.each do |line|
      stdin.print line
    end
    stdin.close    # 或 close_write
  end
end
# 在這裡讀
stdout.each do |line|
  print line
end

