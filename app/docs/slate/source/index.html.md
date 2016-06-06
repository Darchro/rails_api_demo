---
title: API Reference

language_tabs:
  - ruby

toc_footers:
  - <a href='#'>Sign Up for a Developer Key</a>
  - <a href='https://github.com/tripit/slate'>Documentation Powered by Slate</a>

includes:
  - errors

search: true
---

# Introduction

Welcome to the Kittn API! You can use our API to access Kittn API endpoints, which can get information on various cats, kittens, and breeds in our database.

We have language bindings in Shell, Ruby, and Python! You can view code examples in the dark area to the right, and you can switch the programming language of the examples with the tabs in the top right.

This example API documentation page was created with [Slate](https://github.com/tripit/slate). Feel free to edit it and use it as a base for your own API's documentation.

# Authentication

> To authorize, use this code:

```ruby
require 'kittn'

api = Kittn::APIClient.authorize!('meowmeowmeow')
```


> Make sure to replace `meowmeowmeow` with your API key.

Kittn uses API keys to allow access to the API. You can register a new Kittn API key at our [developer portal](http://example.com/developers).

Kittn expects for the API key to be included in all API requests to the server in a header that looks like the following:

`Authorization: meowmeowmeow`

<aside class="notice">
You must replace <code>meowmeowmeow</code> with your personal API key.
</aside>

# Users

## get user token

### HTTP Request

`POST http://localhost:3000/api/v1/sessions.json`

### Query Parameters

Parameter | allow_null | Description
--------- | ------- | -----------
user_email | false | the user email.
user_password | false | the user password.

```ruby
api_response = Faraday.post 'http://localhost:3000/api/v1/sessions.json', {user: {email: your_email, password: your_password}}
```

> The above command returns JSON structured like this:

```json
{
  "id": 1, 
  "email": "zoujinfu@163.com", 
  "name": "gh-user", 
  "token": "s1aZscFRheFlpm0UG5MY+4wwJvk+cfWETtB88DmJYhFp/tuEH2gnyb+QEwDTmmZYnt3wvtbRH9Cs8Md50lIhow=="
}
```

## get users list

### HTTP Request

`GET http://localhost:3000/api/v1/users.json`

```ruby
api_response = Faraday.get 'http://localhost:3000/api/v1/users.json'
```

> The above command returns JSON structured like this:

```json
[
  {
    "id": 1, "email": "xxx@163.com", "name": "name1", "micropost_ids": [1, 2]
  }, 
  {
    "id": 2, "email": "xxx@126.com", "name": "name2", "micropost_ids": []
  }
]
```

## get user info

### HTTP Request

`GET http://localhost:3000/api/v1/users/:id.json`

### Query Parameters

Parameter | allow_null | Description
--------- | ------- | -----------
user_id | false | the user id.

```ruby
api_response = Faraday.get 'http://localhost:3000/api/v1/users/:id.json'
```

> The above command returns JSON structured like this:

```json
{
  "user": 
    {
      "id": 1, 
      "email": "xxx@163.com", 
      "name": "name1", 
      "micropost_ids": [1, 2]
    }
}
```

## update user info

### HTTP Request

`PUT http://localhost:3000/api/v1/users/:id.json`

### Query Parameters

Parameter | allow_null | Description
--------- | ------- | -----------
user_id | false | the user id.
token   | false | authentication_token.


