# Nepali Calendar

[![Gem Version](https://badge.fury.io/rb/nepali_calendar.svg)](http://badge.fury.io/rb/nepali_calendar)

A Ruby gem for generating Nepali Calendar (Bikram Sambat Calendar). You can also convert dates between BS and AD. Nepali Calendar is based on the API from [codeartsnepal](http://sourceforge.net/projects/nepalidateconve/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nepali_calendar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nepali_calendar

## Usage

To convert date from AD to BS, try the following code in console:

```sh
NepaliCalendar::BsCalendar.ad_to_bs('2015', '09', '10')
=> Bihibar, 24 Bhadra, 2072 
```

To convert date from BS to AD:

```sh
NepaliCalendar::AdCalendar.bs_to_ad('2072', '05', '24')
=> Thursday, 10 September, 2015
```

## Contributing

1. Fork it ( https://github.com/lalusaud/nepali_calendar/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
