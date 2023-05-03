require 'amqp/client'
require 'cgi'

# Azure Service Bus namespace, access key, and queue name
SASPolicyName = "RootManageSharedAccessKey"
SASPolicyKey = CGI.escape("CHANGE_ME")
Namespace = "CHANGE_ME"
queue_name = 'CHANGE_ME'

# Establish a connection to the Service Bus
amqp_conn_string = "amqps://#{SASPolicyName}:#{SASPolicyKey}@#{Namespace}.servicebus.windows.net"

connection = AMQP::Client.new(amqp_conn_string).connect

channel = AMQP::Client::Channel.new(connection)
queue = channel.queue(queue_name)

# Start consuming messages from the queue
queue.subscribe do |headers, payload|
  puts "Received message with ID: #{headers.message_id}"
  puts "Message body: #{payload}"

  # Process the message as needed

  # Acknowledge the message to remove it from the queue
  headers.ack
end

# Keep the application running to continue receiving messages
sleep