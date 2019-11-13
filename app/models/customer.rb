class Customer < ApplicationRecord

  def publish
    connection = Bunny.new(host: Rails.configuration.mqhost, user: 'admin', password: 'admin')
    connection.start
    channel = connection.create_channel
    queue_name = 'customer_queue'
    message = self.to_json
    exchange = channel.queue(queue_name, durable: true)
    exchange.publish(message)
    n = GELF::Notifier.new('zaklog1', 12_201)
    n.notify!(short_message: "Published new user #{name}", full_message: message)
  end
end
