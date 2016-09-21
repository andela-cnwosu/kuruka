class Payment < ApplicationRecord
  enum status: [ :pending, :successful, :failed ]
  belongs_to :flight
  belongs_to :booking
  belongs_to :airfare

  def self.paypal_url(booking, return_path)
    values = {
        business: "#{ENV['PAYPAL_BUSINESS']}",
        cmd: "_xclick",
        upload: 1,
        return: "#{ENV['app_host']}#{return_path}",
        invoice: booking.booking_ref,
        amount: booking.cost_in_dollar,
        item_name: "Flight from #{booking.departure} to #{booking.arrival}",
        item_number: booking.booking_ref,
        quantity: '1'
        # notify_url: "#{ENV['app_host']}/hook"
    }
    "#{ENV['paypal_host']}/cgi-bin/webscr?" + values.to_query
  end

  def self.validate_url
    "#{ENV['paypal_host']}/cgi-bin/webscr?cmd=_notify-validate"
  end
end
