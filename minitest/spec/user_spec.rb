
require 'minitest/spec'
require 'minitest/autorun'
require 'rest_client'
require 'yajl'

describe 'Users' do
  before do
    debug = false

	  if debug
			@base_url = "appocean.herokuapp.com";
			@ssl = "https://"
		else
			@base_url = "localhost:3000"
			@ssl = "http://"
		end

  end

  it "should be able to register" do
    response = RestClient.post create_url_without_user(@base_url, @ssl) +'/api/v1/users', 
      :username => 'test', 
      :password => 'test', 
      :meta => { 
        :email => 'test@test.se'
      }
  
    json_p = Yajl::Parser.parse(response.body)
    json_p['status'].must_equal "ok"
    json_p['message'].must_equal "Successfully registered user."
    response.code.must_equal 201
  end

  it "should be able to login" do
    response = RestClient.get create_url_with_user('test', 'test', @base_url, @ssl) + '/api/v1/users/test/login.json'
  	json_p = Yajl::Parser.parse(response.body)
    json_p['status'].must_equal "ok"
    json_p['message'].must_equal "Successfully logged in."
    response.code.must_equal 200
  end

  it "should be able to delete" do
    response = RestClient.delete create_url_with_user('test', 'test', @base_url, @ssl) + '/api/v1/users', :username => 'test'
    json_p = Yajl::Parser.parse(response.body)
    json_p['status'].must_equal "ok"
    json_p['message'].must_equal "Successfully deleted user."
    response.code.must_equal 200
  end

end

###############################################################################
# Helper methods
###############################################################################

def create_url_with_user(username, password, url, ssl)
  ssl + username + ':' + password + '@' + url
end

def create_url_without_user(url, ssl)
  ssl + url
end

def get_data(ids, with_parts = false)
  id_string = ids.respond_to?(:join) ? ids.join(',') : ids
  query_string = (with_parts) ? '&packageseries_parts=true' : ''
  url = "#{@ssl}#{@base_url}?ur_product_ids=#{id_string}#{query_string}"
  Yajl::Parser.parse(RestClient.get(url))
end

def type_data(product_type, data, id)
  data["#{id}"][product_type]
end

def get_type_data(product_type, ids, with_parts = false)
  data = get_data(ids, with_parts)

  response_data = {}

  ids.each do |id|
    response_data[id] ||= []
    response_data[id] << type_data(product_type, data, id)
  end

  response_data
end