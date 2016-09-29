class MailObserver < ActiveRecord::Observer
  observe :booking

  def after_create(booking)
    KurukaMailer.booking_email(booking).deliver_now
  end

  def after_update(booking)
    KurukaMailer.booking_updated_email(booking).deliver_now
  end
end