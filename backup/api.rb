require 'sinatra'
require 'json'
require 'data_mapper'

DataMapper.setup(:default, ENV['HEROKU_POSTGRESQL_ONYX_URL'] || "sqlite3://#{Dir.pwd}/appocean.db")

class Note
    include DataMapper::Resource
    property :id, Serial
    property :content, Text, :required => true
    property :complete, Boolean, :required => true, :default => 0
    property :created_at, DateTime
    property :updated_at, DateTime
end

DataMapper.auto_upgrade!

class API < Sinatra::Base
  get '/sushi.json' do
    content_type :json
    
    {:sushi => ["Maguro", "Hamachi", "Uni", "Saba", "Ebi", "Sake", "Tai"]}.to_json
  end

  get '/notes.json' do
    @notes = Note.all :order => :id.desc
    @title = 'All Notes'
    erb :home
end
end