require 'spec_helper'

describe NepaliCalendar do
  it 'has a version number' do
    expect(NepaliCalendar::VERSION).not_to be nil
  end

  it 'responds to total_days & ref_date' do
    expect(NepaliCalendar::Calendar).to respond_to(:total_days)
    expect(NepaliCalendar::Calendar).to respond_to(:ref_date)
  end

  it 'converts date from ad_to_bs' do
    date1 = Date.parse('2072-05-23')
    date2 = Date.parse('2067-01-03')
    expect(NepaliCalendar::Calendar.ad_to_bs('2015', '09', '09')).to eq(date1)
    expect(NepaliCalendar::Calendar.ad_to_bs('2010', '04', '16')).to eq(date2)
  end

  it 'converts date from bs_to_ad' do
    date1 = Date.parse('2015-09-09')
    date2 = Date.parse('2010-04-16')
    expect(NepaliCalendar::Calendar.bs_to_ad('2072', '05', '23')).to eq(date1)
    expect(NepaliCalendar::Calendar.bs_to_ad('2067', '01', '03')).to eq(date2)
  end
end
