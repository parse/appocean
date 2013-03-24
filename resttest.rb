require 'rest_client'

debug = false

if debug
	url = "appocean.herokuapp.com";
	ssl = "https://"
else
	url = "localhost:3000"
	ssl = "http://"
end

p "******* Register user"
begin
	response = RestClient.post ssl + url+'/api/v1/users', 
			:username => 'test', 
			:password => 'test', 
			:meta => { 
				:email => 'test@test.se'
			}
	
	p "Code: " + response.code.to_s
	p "Body: " + response.body
rescue => e
	p "Code " + e.response.code.to_s
	p "Body: " + e.response.body
end
p "******* End register user"

p "******* Test login user 'test'"
begin
	response = RestClient.get ssl + 'test:test@'+url+'/api/v1/users/test/login.json' # 'test' is the username
	p "Code: " + response.code.to_s
	p "Body: " + response.body
rescue => e
	p "Code " + e.response.code.to_s
	p "Body: " + e.response.body
end
p "******* End get user 'test'"

p "******* Get user 'test'"
begin
	response = RestClient.get ssl + 'test:test@'+url+'/api/v1/users/test.json' # 'test' is the username
	p "Code: " + response.code.to_s
	p "Body: " + response.body
rescue => e
	p "Code " + e.response.code.to_s
	p "Body: " + e.response.body
end
p "******* End get user 'test'"


p "******* Get messages for user 'test'"
begin
	response = RestClient.get ssl + 'hej7:hej7@'+url+'/api/v1/messages' # 'test' is the username
	p "Code: " + response.code.to_s
	p "Body: " + response.body
rescue => e
	p "Code " + e.response.code.to_s
	p "Body: " + e.response.body
end
p "******* End get user 'test'"

