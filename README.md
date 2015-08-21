# Speechmatics

[![Gem Version](https://badge.fury.io/rb/speechmatics.svg)](http://badge.fury.io/rb/speechmatics)
[![Build Status](https://travis-ci.org/PRX/speechmatics.svg?branch=master)](https://travis-ci.org/PRX/speechmatics)

Speechmatics (https://speechmatics.com) provides an API for speech to text (https://speechmatics.com/api-details).

This gem implements the API making it easier to integrate into Ruby and/or Rails projects.

## Installation

Add this line to your application's Gemfile:

    gem 'speechmatics'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install speechmatics

## Usage

See the tests, or here is basic usage:
```ruby

# configure with api key and user id to use for all requsts
Speechmatics.configure do |sm|
  sm.auth_token = '<your api key here>'
  sm.user_id    = 1234

  # these are defaults
  sm.adapter    = :excon
  sm.endpoint   = 'https://api.speechmatics.com/v1.0/'
  sm.user_agent = "Speechmatics Ruby Gem #{Speechmatics::VERSION}"
end

# create a new client
c = Speechmatics::Client.new

# create a new client, passing in Faraday parameters
# you can also pass in the same options as in `configure`
c = Speechmatics::Client.new(:request => { :timeout => 240 })

# retrieve user
j = c.user.get

# list jobs
jobs = c.user.jobs.list

# create job
info = c.user.jobs.create(data_file: '/Users/nobody/dev/speechmatics/test/zero.wav')

# create job with more options
info = c.user.jobs.create(
  data_file: '/Users/nobody/dev/speechmatics/test/zero.wav',
  content_type: 'audio/x-wav; charset=binary',
  notification: '<email | none | callback>',
  callback: 'http://www.example.com/transcript_callback'
)

# retrieve job
job = c.user.jobs.find(5678)

# retrieve trancript for a job
trans = c.user.jobs(5678).transcript
# alt syntax
trans = c.user.jobs.transcript(5678)

```

## Changes

* 0.1.4 - 8/21/2015
  - Add support for video files.

* 0.1.3 - 6/10/2015
  - Add default timeout of 120 seconds.

* 0.1.2 - 6/10/2015
  - Yanked

* 0.1.1 - 3/26/2015
  - Fix to work with Faraday 0.7.6

* 0.1.0 - 10/24/2014
  - Remove /user/$userid/jobs/$jobid/audio endpoint, no longer supported by speechmatics

* 0.0.2 - 8/7/2014
  - Minor bug fix, treat integers/numbers as strings for params
  - Use mimemagic to determine content type (no more libmagic dependency; this works on heroku)
  - Switched the endpoint to use new 'https' requirement

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
