require 'spec_helper'

describe NepaliCalendar do
  let(:today) {Date.today}
  let(:calendar) {NepaliCalendar::Calendar.new(today.year, today.month, today.day)}

  it 'has a version number' do
    expect(NepaliCalendar::VERSION).not_to be nil
  end

  it 'does not respond to total_days & ref_date' do
    expect(calendar).to_not respond_to(:total_days)
    expect(calendar).to_not respond_to(:ref_date)
  end

  it 'does not respond to date_in_range? and valid_date?' do
    expect(calendar).to_not respond_to(:date_in_range?)
    expect(calendar).to_not respond_to(:valid_date?)
  end

  it 'responds to get_ad_date & get_bs_date' do
    expect(calendar).to respond_to(:get_ad_date)
    expect(calendar).to respond_to(:get_bs_date)
  end

  it 'converts date from ad_to_bs' do
    date1 = Date.parse('2072-05-23')
    date2 = Date.parse('2067-01-03')
    expect(calendar.ad_to_bs('2015', '09', '09')).to eq(date1)
    expect(calendar.ad_to_bs('2010', '04', '16')).to eq(date2)
  end

  it 'converts date from bs_to_ad' do
    date1 = Date.parse('2015-09-09')
    date2 = Date.parse('2010-04-16')
    expect(calendar.bs_to_ad('2072', '05', '23')).to eq(date1)
    expect(calendar.bs_to_ad('2067', '01', '03')).to eq(date2)
  end

  it 'returns today' do
    date = calendar.ad_to_bs(today.year, today.month, today.day)
    expect(NepaliCalendar::Calendar.today).to eq(date)
  end

  it 'returns BS month of a date' do
    bs_date = calendar.ad_to_bs('2015', '09', '09')
    expect(NepaliCalendar::Calendar::MONTHS[bs_date.month-1]).to eq('Bhadra')
  end
end
