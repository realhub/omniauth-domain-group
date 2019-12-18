# Omniauth::DomainGroup

This is an unofficial OmniAuth strategy for authenticating with Domain Group. To get started, read the documentation at https://developer.domain.com.au

You will need to get permission from a Domain customer to be added to their account. Contact the Domain API team (api@domain.com.au) once you are ready.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-domain-group'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-domain-group

## Usage with Rails & Devise

Add the following to `config/initializers/devise.rb`
```ruby
config.omniauth :domain_group,
    ENV['DOMAIN_GROUP_CLIENT_ID'],
    ENV['DOMAIN_GROUP_SECRET_KEY'],
    :scope => 'openid profile offline_access api_agencies_read'
```

Add `:domain_group` to the `:omniauth_providers` array for your devise model. e.g.

```ruby
class User < ApplicationRecord
  devise :omniauthable, :omniauth_providers => [:domain_group]
end
```

You can then access the url using the helper `user_domain_group_omniauth_authorize_path`

## Basic Usage

```ruby
use OmniAuth::Builder do
  provider :domaing_group, ENV['DOMAIN_GROUP_CLIENT_ID'], ENV['DOMAIN_GROUP_SECRET_KEY'], scope: 'openid profile offline_access api_agencies_read'
end
```

## Potential Scopes

```ruby
# See: securityDefinitions
# https://developer.domain.com.au/docs/media/public-adapter-v1.json

openid
profile
offline_access # (required for refresh token)
api_addresslocators_read
api_agencies_read
api_agencies_write
api_demographics_read
api_disclaimers_read
api_enquiries_read
api_enquiries_write
api_listings_read
api_listings_write
api_locations_read
api_properties_read
api_propertyreports_read
api_salesresults_read
api_statistics_write
api_suburbperformance_read
api_webhooks_write
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/realhub/omniauth-domain-group. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Omniauth::DomainGroup project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/realhub/omniauth-domain-group/blob/master/CODE_OF_CONDUCT.md).
