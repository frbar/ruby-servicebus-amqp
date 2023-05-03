#!/usr/bin/env ruby

require 'bunny'
require 'cgi'

SASPolicyName = "RootManageSharedAccessKey"
SASPolicyKey = CGI.escape("CHANGE_ME")
Namespace = "CHANGE_ME"

amqp_conn_string = "amqps://#{SASPolicyName}:#{SASPolicyKey}@#{Namespace}.servicebus.windows.net"
connection = Bunny.new(amqp_conn_string, automatically_recover: false) 
connection.start

channel = connection.create_channel
queue = channel.queue('task_queue', durable: true) 

channel.prefetch(1) 
puts ' [*] Waiting for messages. To exit press CTRL+C'
begin 
    # block: true is only used to keep the main thread 
    # alive. Please avoid using it in real world applications. 
    queue.subscribe(manual_ack: true, block: true) do |delivery_info, _properties, body| 
        puts " [x] Received '#{body}'" 
        # imitate some work 
        sleep 1000 
        puts ' [x] Done' 
        channel.ack(delivery_info.delivery_tag) 
    end
rescue Interrupt => _ 
    connection.close
end

