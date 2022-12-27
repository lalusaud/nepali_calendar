# Nepali Calendar
This repo is a fork of https://github.com/lalusaud/nepali_calendar/. Since the original repo wasn't being actively maintained, we took the liberty to add/fix functionalities

[![Build Status](https://travis-ci.org/lalusaud/nepali_calendar.svg)](https://travis-ci.org/lalusaud/nepali_calendar)
[![Gem Version](https://badge.fury.io/rb/nepali_calendar.svg)](http://badge.fury.io/rb/nepali_calendar)
[![Code Climate](https://codeclimate.com/github/lalusaud/nepali_calendar/badges/gpa.svg)](https://codeclimate.com/github/lalusaud/nepali_calendar)
[![Test Coverage](https://codeclimate.com/github/lalusaud/nepali_calendar/badges/coverage.svg)](https://codeclimate.com/github/lalusaud/nepali_calendar/coverage)

A Ruby gem for generating Nepali Calendar (Bikram Sambat Calendar). You can also convert dates between BS and AD. Nepali Calendar is based on the API from [codeartsnepal](http://sourceforge.net/projects/nepalidateconve/).

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'nepali_calendar', git: 'https://github.com/Daanphe/nepali_calendar.git', branch: 'master'
```

And then execute:

    $ bundle


## Usage

##### Rails 6.1.0+
Initialize Calendar Object in controller with:

#### Calendar
```ruby
@cal = NepaliCalendar::Calendar.new
```

#### BSCalendar
To convert date from AD to BS, copy the following code in the view file:
```ruby
<%= @cal.ad_to_bs('2015', '09', '10') %>
```
To create new BS date object:
```ruby
NepaliCalendar::BsCalendar.new(nil, { year: , month: , day:  })
```

#### ADCalendar
To convert date from BS to AD, copy the following code:
```ruby
<%= @cal.bs_to_ad('2072', '05', '24') %>
```
To create new AD date object:
```ruby
NepaliCalendar::AdCalendar.new(nil, { year: , month: , day:  })
```

#### FiscalYear
To get beginning date of the Nepali Fiscal year
```ruby
NepaliCalendar::FiscalYear.new(@start_year, @end_year).beginning_of_year
```
To get end date of the Nepali Fiscal year
```ruby
NepaliCalendar::FiscalYear.new(@start_year, @end_year).end_of_year
```
To get Nepali Fiscal year from BS date
```ruby
NepaliCalendar::FiscalYear.fiscal_year_for_bs_date(date_in_bs)
```
To get Nepali Fiscal year from AD date object
```ruby
NepaliCalendar::FiscalYear.fiscal_year_in_bs_for_ad_date(date_in_ad)
```
To get current Nepali Fiscal year
```ruby
NepaliCalendar::FiscalYear.current_fiscal_year
```

## Contributing
1. Fork it ( https://github.com/Daanphe/nepali_calendar.git )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
