class UserMailer < ApplicationMailer
	def publish_msg(email)
	    @email = email
	    mail(to: email, subject: "Album Published")
    end
end
