class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :author, :class_name => "User", :foreign_key => :author_id

  validates_presence_of :description

  acts_as_commentable

end
