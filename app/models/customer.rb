class Customer < ApplicationRecord
  after_create :publish_customer

  def publish_customer
    connection = Bunny.new(host: Rails.configuration.mqhost,
                           user: Rails.configuration.mquser,
                           password: Rails.configuration.mqpassword)
    connection.start
    connection.create_channel.fanout('customer_exchange', durable: true ).publish(to_json)
    Rails.logger.info(short_message: "Published new user #{name}",
                      full_message: to_json)
  end
end
