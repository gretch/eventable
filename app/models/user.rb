class User < ActiveRecord::Base

  has_many :ideas

  validates_uniqueness_of :user_name

  acts_as_authentic do |c|
    c.validate_password_field false
    c.merge_validates_format_of_email_field_options(:message => I18n.t('error_messages.email_invalid', :default => "address is invalid."))
    c.merge_validates_uniqueness_of_email_field_options
  end

  named_scope :admins, :conditions => { :admin => true }, :order => "user_name ASC"

  def self.find_by_param(*args)
    User.find_by_user_name(*args)
  end

  def to_param
    self.user_name
  end

end
