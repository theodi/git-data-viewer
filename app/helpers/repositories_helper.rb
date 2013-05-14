module RepositoriesHelper

  def license_name(l)
    l.id ? t(l.id) : (l.name || l.uri)
  end
  
  def agent_link(agent)    
    if agent.uri
      link_to agent.name, agent.uri
    elsif agent.email
      mail_to agent.email, agent.name
    else
      h(agent.name)
    end
  end

end
