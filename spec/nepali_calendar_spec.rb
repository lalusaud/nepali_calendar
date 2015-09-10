require 'spec_helper'

describe NepaliCalendar do
  it 'has a version number' do
    expect(NepaliCalendar::VERSION).not_to be nil
  end

  it 'converts date from ad_to_bs' do
    expect(NepaliCalendar::Calendar.ad_to_bs('2015', '09', '09')).to eq(Date.parse('2072-05-23'))
    expect(NepaliCalendar::Calendar.ad_to_bs('2010', '04', '16')).to eq(Date.parse('2067-01-03'))
  end

  it 'converts date from bs_to_ad' do
    expect(NepaliCalendar::Calendar.bs_to_ad('2072', '05', '23')).to eq(Date.parse('2015-09-09'))
    expect(NepaliCalendar::Calendar.bs_to_ad('2067', '01', '03')).to eq(Date.parse('2010-04-16'))
  end
end
