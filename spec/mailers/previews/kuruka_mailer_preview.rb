# Preview all emails at http://localhost:3000/rails/mailers/kuruka_mailer
class KurukaMailerPreview < ActionMailer::Preview
  def booking_mail_preview
    @booking = Booking.last
    KurukaMailer.booking_email(@booking)
  end

  def booking_update_mail_preview
    @booking = Booking.last
    KurukaMailer.booking_updated_email(@booking)
  end

  def contact_mail_preview
    @contact = Contact.new(name: "him", email: "her@him.she", message: "Hey")
    KurukaMailer.contact_email(@contact)
  end
end
