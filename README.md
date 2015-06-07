
											Greetings from TricingCode

--------------------------------------------------------------------------------------------------------------------------------

Introduction :
	A prototype mailer application which allows us to send confidential emails with enhanced security using Aadhaar's OTP authentication.
	
	
How it works:
	- User signs up with the system using the following parameters: 
		-- UserName (Ex: Your Name)
		-- E-mail (Ex: something@somedummydomain.com)
		-- Password (Ex: >8 characters)
		-- Aadhaar Number (Ex: A valid Aadhaar Number please. We haven't provided validations..)
		
	- For a successful sign-up, OTP is mandatory thus authenticating the User.
	
	- After successful authentication a mail account is created for the user which would allow him to send secured mails.
	
	- Sending a Mail:
		-- The sender can tick the check-box "Secured" which would prompt for Aadhaar card authentication for the recipient when he
		   tries to open the mail.
		-- Also in future if the sender wants to re-visit the secured E-mail then he would himself have to provide OTP for his own 
		   Aadhaar card authentication.
	
	- Receiving a Mail:
		-- If a user receives an Secured Email, then the user has to provide OTP via Aadhaar authentication to view the contents
		   of the mail.
		   
	- Try it out:
		-- All you need to do is just Sign up and send a mail.
		
		
What we Aimed at:
	- Hacking of mobile account, losing mobile phones/laptops with pre-configured mail account is always a risk we are facing 
	  in our day to day lives.
	  
	- Also ever wondered what would happen when someone gets hold of your mails where your privacy is invaded.
	
	- Ex: A bank site sending you a ATM pin, A previous employer sending you payslips, Your personal photos.
	
	- Data has been misused regularly when it falls into the wrong hands. So taking a step forward in privacy we aimed at placing 
	  Aadhaar Card authentication for the Secure Mails.
	  
	- This prototype could be enhanced as a plug-in for our regular mails (gmail,yahoo etc..) with a hope that Google lets us :P
	
	- Suffice to say that this prototype could lead us into paving a path of a thoughtful process in making data secure.

	
Technical Specs:
	- Ruby on Rails v2.0.0
	
	- Ruby Dev Kit v4.7.2

	- Ruby Mailboxer 
	
Hosted URL:
	- Lets make life easier. We've hosted our application for you.
		-- http://tricingcode-mailer.herokuapp.com/
		

Development Steps:
	- If you want to go through the pain of setting up the application and running it local. Then here goes:
		-- Install Ruby from the site below:
			 ## http://rubyinstaller.org/downloads/
			 
			 Windows Compatible version : Ruby 2.0.0-p645
			 MAC						: Ruby 2.2.2
			 
		-- Install Ruby Dev-Kit Addon:
			 ## http://dl.bintray.com/oneclick/rubyinstaller/DevKit-mingw64-32-4.7.2-20130224-1151-sfx.exe
			 
		-- Open CMD/Terminal. CD to the installed directory of Ruby Dev-Kit Addon. Run the following cmds.
			 ## ruby dk.rb init
			 ## ruby dk.rb install
			 
			 This would bind the Ruby set-up with the Dev-Kit.
			 
		-- Extract the downloaded source code to a folder. CD to the extracted directory and run the following command:
			 ## bundle install
			 
			 This would install all the dependencies.
			 
		-- Finally start the server within the same directory:
			 ## rails s 
			 
		-- That's it. We are done setting up. Open up a browser and hit the local url
			 ## http://localhost:3000/
			 
		-- If you face any issues do write us back. We are glad to help.
		
		
Summary:
	Forget about changing password or from snooping eyes as this prototype with the help of Aadhaar authentication hopes to take security to another level


--------------------------------------------------------------------------------------------------------------------------------

Cheers,
	TRICERS
		   