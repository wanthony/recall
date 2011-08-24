%w[sinatra haml coffee-script less couchrest_model].each do |f|
  require f
end

class Application < Sinatra::Base
  @couch_server = CouchRest.new(ENV['CLOUDANT_URL'] || YAML::load_file('config/database.yml')['development'])
  @couch_server.database!('recall')

  get '/' do
    haml :index
  end

  get '/tasks' do
    haml :tasks
  end
end
