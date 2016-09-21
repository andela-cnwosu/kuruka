class KurukaMailer < ActionMailer::Base
  include MessagesHelper
  default from: "chineze.nwosu@andela.com"
  layout 'mailer'

  def booking_email(booking)
    mail_to booking, booking_mail_subject_message
  end

  def booking_updated_email(booking)
    mail_to booking, booking_update_mail_subject_message
  end

  def contact_email(contact)
    @contact = contact
    mail(
      from: contact.email,
      to: "chineze.nwosu@andela.com", 
      subject: contact_mail_subject_message
    )
  end

  def mail_to(booking, subject)
    @booking = booking
    @confirmation_path = "#{ENV['app_host']}/bookings/#{booking.id}/confirmation"
    mail to: booking.user_email, subject: subject
  end
end
