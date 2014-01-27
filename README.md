[![Code Climate](https://codeclimate.com/github/bqsoft/suretax.png)](https://codeclimate.com/github/bqsoft/suretax)
[![TravisCI](https://api.travis-ci.org/bqsoft/suretax.png)](https://api.travis-ci.org/bqsoft/suretax.png)
# Suretax


## Synopsis

```ruby
request = Suretax::Api::Request.new({ initial: data })
request.items = [ Suretax::Api::RequestItem.new({ initial: data }) ]
connection = Suretax::Connection.new

if request.valid?
  response = connection.post(body: request.params)
  response.params
end
```

You can peek inside the tests for more examples and to see what data
methods are available.


## Development Environment

Suretax uses [dotenv] to easily switch between development/test environments
and production.

You will need to set the following environment variables for the gem to work:

- `SURETAX_VALIDATION_KEY` (You can get this from [SureTax][suretax].)
- `SURETAX_BASE_URL` (This is usually `https://testapi.taxrating.net` for testing.)

You can do this by creating a .env file in the root of the Suretax gem
repository (gitignored by default). For more information, please see
the [dotenv documentation][dotenv]

[dotenv]: https://github.com/bkeepers/dotenv
[suretax]: http://suretax.com
