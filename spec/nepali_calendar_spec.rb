require 'spec_helper'

describe NepaliCalendar do
  let(:today) {Date.today}
  let(:calendar) {NepaliCalendar::Calendar.new}

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
    date = calendar.ad_to_bs('2015', '09', '09')
    expect(date.bs_year).to eq(2072)
    expect(date.bs_month).to eq(5)
    expect(date.bs_day).to eq(23)
    expect(date.bs_wday).to eq(4)
    expect(date.bs_month_name).to eq('Bhadra')
    expect(date.bs_wday_name).to eq('Budhbar')
  end

  it 'converts date from bs_to_ad' do
    date1 = Date.parse('2015-09-09')
    date2 = Date.parse('2010-04-16')
    expect(calendar.bs_to_ad('2072', '05', '23')).to eq(date1)
    expect(calendar.bs_to_ad('2067', '01', '03')).to eq(date2)
  end
end
