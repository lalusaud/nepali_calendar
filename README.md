# Nepali Calendar

[![Build Status](https://travis-ci.org/lalusaud/nepali_calendar.svg)](https://travis-ci.org/lalusaud/nepali_calendar)
[![Gem Version](https://badge.fury.io/rb/nepali_calendar.svg)](http://badge.fury.io/rb/nepali_calendar)
[![Code Climate](https://codeclimate.com/github/lalusaud/nepali_calendar/badges/gpa.svg)](https://codeclimate.com/github/lalusaud/nepali_calendar)

A Ruby gem for generating Nepali Calendar (Bikram Sambat Calendar). You can also convert dates between BS and AD.

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

#### Rails 3/4
To convert date from AD to BS, copy the following code in the view file:
```sh
<%= NepaliCalendar::Calendar.ad_to_bs('2015', '09', '10') %>
```

To convert date from BS to AD, copy the following code:
```sh
<%= NepaliCalendar::Calendar.bs_to_ad('2072', '05', '24') %>
```

## Contributing

1. Fork it ( https://github.com/lalusaud/nepali_calendar/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
