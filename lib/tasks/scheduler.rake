namespace :scheduler do

  desc "This task is called by the Heroku cron add-on"
  task :call_page do
     uri = URI.parse('http://petcuida-production.herokuapp.com/')
     Net::HTTP.get(uri)
  end
  
end