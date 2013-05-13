module RepositoriesHelper

  def license_name(l)
    l.id ? t(l.id) : (l.name || l.uri)
  end
  
end
