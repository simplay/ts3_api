# TS3API

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/ts3_api`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ts3_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ts3_api

## Usage

Initially, you have to create a file `.env` in the project's root directory.

See `.env.example` for further information.

### Establish a connection

```rb
Server.start
# Run some code
Server.execute('serverinfo')
Server.responses.each do |response|
  puts response.inspect
end
Server.stop
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/simplay/ts3_api.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

