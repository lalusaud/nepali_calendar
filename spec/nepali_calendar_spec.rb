require 'spec_helper'

describe NepaliCalendar do
  let(:today) {Date.today}
  let(:bs_date) { NepaliCalendar::BsCalendar.ad_to_bs('2015', '09', '09') }
  let(:ad_date) { NepaliCalendar::AdCalendar.bs_to_ad('2072', '05', '23') }

  it 'has a version number' do
    expect(NepaliCalendar::VERSION).not_to be nil
  end

  it 'does not respond to total_days & ref_date' do
    expect(bs_date).to_not respond_to(:total_days)
    expect(bs_date).to_not respond_to(:ref_date)
  end

  it 'does not respond to date_in_range? and valid_date?' do
    expect(bs_date).to_not respond_to(:date_in_range?)
    expect(bs_date).to_not respond_to(:valid_date?)
  end

  it 'responds to get_ad_date & get_bs_date' do
    expect(NepaliCalendar::AdCalendar).to respond_to(:get_ad_date)
    expect(NepaliCalendar::BsCalendar).to respond_to(:get_bs_date)
  end

  it 'converts date from ad_to_bs' do
    expect(bs_date.year).to eq(2072)
    expect(bs_date.month).to eq(5)
    expect(bs_date.day).to eq(23)
    expect(bs_date.wday).to eq(4)
    expect(bs_date.month_name).to eq('Bhadra')
    expect(bs_date.wday_name).to eq('Budhbar')
  end

  it 'converts date from bs_to_ad' do
    expect(ad_date.year).to eq(2015)
    expect(ad_date.month).to eq(9)
    expect(ad_date.day).to eq(9)
    expect(ad_date.wday).to eq(3)
    expect(ad_date.month_name).to eq('September')
    expect(ad_date.wday_name).to eq('Wednesday')
  end
end
