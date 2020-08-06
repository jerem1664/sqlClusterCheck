#! /usr/bin/env ruby
require 'mysql2'
conn=Mysql2::Client.new(:host => "127.0.0.1", :username => "replication", :password => "XXXXXXXXXXXXX")

i=conn.query("show global status like '%wsrep_ready%';").to_a
j=conn.query("show global status like '%wsrep_connected%';").to_a
k=conn.query("show global status like '%wsrep_local_state_comment%';").to_a


i.each do |row|
    if row["Value"] != "ON"
            exit(1)
    end
end
j.each do |row|
    if row["Value"] != "ON"
            exit(1)
    end
end
k.each do |row|
    if row["Value"] != "Synced"
            exit(1)
    end
end

system("touch /tmp/sqlClusterCheck")


conn.close if conn

