class Contact < MailForm::Base
   attribute :name, :validate => true
   # email regex validation (needs @ etc)
   attribute :email, :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
   attribute :message, :validate => true
   # to prevent span
   attribute :seguridad, :captcha => true
   
   def headers
        {
            :subject => "Contact Form",
            :to => "jagonzacas@hotmail.com",
            :from => %("#{name}" <#{email}>)
        }
   end
end