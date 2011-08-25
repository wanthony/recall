$: << File.dirname(__FILE__)

require 'sinatra/base'
require 'couchrest'
require 'yaml'
require 'haml'

class App < Sinatra::Base
  configure do
    set :app_file, __FILE__
    set :bind, 'localhost'
    set :port, '4567'
    set :run, true
    set :server, %w[thin mongrel webrick]
    set :conf, YAML.load_file(File.dirname(__FILE__) + '/config/database.yml') unless ENV['CLOUDANT_URL']
    set :db, CouchRest.database!("#{ENV['CLOUDANT_URL'] || "http://#{settings.conf['username']}:#{settings.conf['password']}@localhost:5984"}/recall")
  end

  get '/' do
    haml :index
  end

  get '/tasks' do
    @page_title = "Tasks"
    @tasks = settings.db.view('recall/by_created_at')['rows'].sort do |a, b|
      Time.parse(b['key']) <=> Time.parse(a['key'])
    end
    haml :tasks
  end

  run! if app_file == $0
end

