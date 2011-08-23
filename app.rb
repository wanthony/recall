require 'sinatra'
require 'erb'
require 'coffee'
require 'less'

get '/' do
  erb :index
end
