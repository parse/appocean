require 'rest_client'

p "******* Test login user 'test'"
begin
	response = RestClient.get 'http://test:test@127.0.0.1:3000/api/v1/users/test/login.json' # 'test' is the username
	p "Code: " + response.code.to_s
	p "Body: " + response.body
rescue => e
	p "Code " + e.response.code.to_s
	p "Body: " + e.response.body
end
p "******* End get user 'test'"

p "******* Get user 'test'"
begin
	response = RestClient.get 'http://test:test@127.0.0.1:3000/api/v1/users/test.json' # 'test' is the username
	p "Code: " + response.code.to_s
	p "Body: " + response.body
rescue => e
	p "Code " + e.response.code.to_s
	p "Body: " + e.response.body
end
p "******* End get user 'test'"

p "******* Register user"
begin
	response = RestClient.post 'http://127.0.0.1:3000/api/v1/users', 
			:username => 'hej9', 
			:password => 'hej9', 
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
