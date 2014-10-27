module GithubHelper
  def project
    OpenStruct.new({
      name: 'home.babbel'
    })
  end

  def organization
    'lessonnine'
  end
end
