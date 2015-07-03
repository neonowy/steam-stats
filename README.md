# SteamStats

Get Steam player's info and games stats.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'steam_stats'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install steam_stats

## Usage

1. Find user by ID (you have to get it by yourself by looking at URL in browser)
```ruby
user = Steam.user '76561198041851025'
```

2. Get array of played games
```ruby
games = user.games #=> [{ name: 'Team Fortress 2', played_hours: 93 }, { name: 'Sniper Elite V2', played_hours: 2.4 }]
```

3. And now you have your stats, have fun with it!
```ruby
hours_in_tf2 = games[0].played_hours
```

## Contributing

1. Fork it ( https://github.com/neonowy/steam_stats/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Code, code, code :computer: :computer:
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
