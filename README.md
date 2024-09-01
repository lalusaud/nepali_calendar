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

### Convert from AD to BS

```sh
bs_cal = NepaliCalendar::BsCalendar.ad_to_bs('2024',  '09',  '10')
=> Mangalbar, 25 Bhadra, 2081

bs_cal.year
=> 2081

bs_cal.month
=> 5

bs_cal.month_name
=> "Bhadra"

bs_cal.wday
=> 3

bs_cal.wday_name
=> "Mangalbar"

bs_cal.day
=> 25

bs_cal.to_s
=> "2081-05-25" 

bs_cal.beginning_of_month
=> Sanibar, 1 Bhadra, 2081

bs_cal.beginning_of_week
=> Aitabar, 23 Bhadra, 2081

bs_cal.end_of_month
=> Sombar, 31 Bhadra, 2081

bs_cal.end_of_week
=> Sanibar, 29 Bhadra, 2081
```


### Convert from BS to AD

```sh
ad_cal = NepaliCalendar::AdCalendar.bs_to_ad('2072', '05', '24')
=> Thursday, 10 September, 2015

ad_cal.to_s
=> "2015-09-10"
```

** Convert to Ruby date object **

```sh
ad_cal.to_s.to_date
=> Thursday,  10  September,  2015
```

## Contributing

1. Fork it ( https://github.com/lalusaud/nepali_calendar/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
