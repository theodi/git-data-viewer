module OpenData::Dataset::Hosts::Github
  
  def hosted_by_github?
    (@uri =~ /\A(git|https?):\/\/github\.com\//).present?
  end

  def github_path(path = '')
    hosted_by_github? ? "https://github.com/#{github_user_name}/#{github_repository_name}/#{path}" : nil
  end

  private

  def github_user_name
    @github_user_name ||= hosted_by_github? ? uri.split('/')[-2] : nil
  end
  
  def github_repository_name
    @github_repository_name ||= hosted_by_github? ? uri.split('/')[-1].split('.')[0] : nil
  end

end