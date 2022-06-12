# SlackAuth

SlackAuth is a new gem that uses the new openId authentication for slack.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slack_auth'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install slack_auth

## Usage

### Configurations

To use this gem you will need to have the `client_id` and the `client_secret` from your slack application.
If you don't have a slack app you can create one [here](https://api.slack.com/apps/).

#### Using Environment Variables

The SlackAuth will search for `ENV["SLACK_CLIENT_ID"]` and `ENV["SLACK_CLIENT_SECRET"]` so you just need to define it on your `.env` file.

#### Using Initializer

You can also define the keys creating a file `slack_auth.rb` on `config/initializers` and use it like the following:

```ruby
    SlackAuth.configure do |config|
        config.client_id = ENV["MY_CLIENT_ID"]
        config.client_secret = ENV["MY_CLIENT_SECRET"]
    end
```

Although you can just put the keys here we really recomend you to keep your keys secret on a env variable.

### Implementation

After you receive your code from slack by using the slack button that you can generate it [here](https://api.slack.com/authentication/sign-in-with-slack#generator).
You should be redirected to your controller `callback` and here you can just call the `authorize` method to have the user info like the following:

This method will receive the request from the `ActionDispatch` of your application.

```ruby
    user = SlackAuth::Client.authorize(request)
```

```ruby
    SlackAuth::Client.authorize(request) do |user, response|
    name = user["name"]
    end
```

The `user` will be an hash with:

```ruby
{
    profile: {
        "iss": "https://slack.com",
        "sub": "U0R7MFMJM",
        "aud": "25259531569.11152291",
        "exp": 1626874955,
        "iat": 1626874655,
        "auth_time": 1626874655,
        "nonce": "abcd",
        "at_hash": "tUbyWGBHe0V32FJEupkgVQ",
        "https://slack.com/team_id": "T0RR",
        "https://slack.com/user_id": "U0JM",
        "email": "bront@slack-corp.com",
        "email_verified": true,
        "date_email_verified": 1622128723,
        "locale": "en-US",
        "name": "brent",
        "given_name": "",
        "family_name": "",
        "https://slack.com/user_image_24": "https://secure.gravatar.com/avatar/bc.png",
        "https://slack.com/user_image_32": "...",
        "https://slack.com/user_image_48": "...",
        "https://slack.com/user_image_72": "...",
        "https://slack.com/user_image_192": "...",
        "https://slack.com/user_image_512": "...",
        "https://slack.com/team_image_34": "...",
        "https://slack.com/team_image_44": "...",
        "https://slack.com/team_image_68": "...",
        "https://slack.com/team_image_88": "...",
        "https://slack.com/team_image_102": "...",
        "https://slack.com/team_image_132": "...",
        "https://slack.com/team_image_230": "...",
        "https://slack.com/team_image_default": true
    }
    access_token: "123455.123.321"
}
```

For mor information about what means some profile properties check [here](https://api.slack.com/methods/openid.connect.token#markdown).

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/slack_auth.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
