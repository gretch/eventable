module UsersHelper
  def owner?(user)
    if user.kind_of?(String)
      user.eql?(current_user.user_name)
    else
      current_user.eql?(user)
    end
  end
end
