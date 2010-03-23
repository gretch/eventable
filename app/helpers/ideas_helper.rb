module IdeasHelper
  def author_link(name)
    user = User.find_by_user_name(name)
    if user
      link_to name, user_path(user)
    else
      name
    end
  end

  def author_nick(idea)
    idea.author ? idea.author.user_name : idea.author_name
  end
  
  def status_indicator(status)
    case (status.downcase)
    when 'new'
      'new'
    when 'in-progress'
      'in_progress'
    when 'done'
      'done'
    end
  end

end
