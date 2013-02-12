#!/usr/bin/env ruby
require 'fileutils'

dir = ENV["ORACLE_HOME"] + "/network/admin"
tnsnames = dir + "/tnsnames.ora"
listener = dir + "/listener.ora"
# backup original files
FileUtils.cp(tnsnames, tnsnames + ".bak")
FileUtils.cp(listener, listener + ".bak")
# process file : change hostname
def change_hostname(fname, outfile)
  hostname = `hostname`.chomp
  File.open(fname) do |f|
    f.each_line do |line|
      line = line.sub(/ip-\d{1,3}-\d{1,3}-\d{1,3}-\d{1,3}/,hostname)
      outfile.puts line
    end
  end
end

tnsnames_tmp = tnsnames + ".tmp"
listener_tmp = listener + ".tmp"
begin
  tf = File.open(tnsnames_tmp, "w")
  change_hostname(tnsnames, tf)
  lf = File.open(listener_tmp, "w")
  change_hostname(listener, lf)
rescue => ex
  puts ex.message
  tf.close if tf
  lf.close if lf
  exit 1
end
tf.close
lf.close

FileUtils.cp(tnsnames_tmp, tnsnames)
FileUtils.cp(listener_tmp, listener)

