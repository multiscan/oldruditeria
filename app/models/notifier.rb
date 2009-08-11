class Notifier < ActionMailer::Base

def signup_thanks(user)
  # Email header info MUST be added here
  @recipients = user.email
  @from = "yvonne.huskie@epfl.ch" 
  @subject = "Thank you for registering to our cafetaria" 

  # Email body substitutions go here
  @body["name"] = user.name
	@body["camipro"] = user.camipro
end

def personal_report(user)
	# Email header info MUST be added here
  @recipients = user.email
  @from = "yvonne.huskie@epfl.ch" 
  @subject = "Cafeteria LTHC - Report" 
	
	# Email body substitutions go here
	@body["month"] = Time.now.at_beginning_of_month.last_month.strftime("%B")
	@body["start"] = Time.now.at_beginning_of_month.last_month
	@body["end"] = Time.now.at_beginning_of_month
	@body["user"] = user
	@body["balance"] =user.balance
	@body["products"] = Product.find :all
end

end
