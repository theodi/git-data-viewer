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

  def stripped_url(url)
    uri = URI.parse(url)
    path_without_extension = uri.path.rpartition('.')[0]
    [uri.host, path_without_extension].join('')
  end

end
