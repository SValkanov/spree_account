Spree::User.class_eval do
  def username_or_email
    self.username || email_name
  end

  private

  def email_name
    self.email.split('@').first
  end
end
