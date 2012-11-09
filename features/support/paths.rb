module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when 'home'
      '/'
      
    when 'sign up'
      '/owners/sign_up'
      
    when 'sign in'
      '/owners/sign_in'
      
    when 'sign out'
      '/owners/sign_out'
      
    when 'vets home'
      '/vets/home'
      
    when 'vets sign up'
      '/vets/sign_up'
      
    when 'vets sign in'
      '/vets/sign_in'
      
    when 'vets sign out'
      '/vets/sign_out'
      
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /(.*)/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
