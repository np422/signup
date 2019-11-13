class Customer < ApplicationRecord

  def publish
    connection = Bunny.new(host: Rails.configuration.mqhost)
    connection.start
    channel = connection.create_channel
    queue_name = 'customer_queue'
    message = self.to_json
    exchange = channel.queue(queue_name, durable: true)
    exchange.publish(message)
  end
end
