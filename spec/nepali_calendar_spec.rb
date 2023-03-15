# frozen_string_literal: true

require 'spec_helper'
require 'date'

describe NepaliCalendar do
  let(:today) { Date.today }
  let(:bs_date) { NepaliCalendar::BsCalendar.ad_to_bs('2015', '09', '09') }
  let(:ad_date) { NepaliCalendar::AdCalendar.bs_to_ad('2072', '05', '23') }

  it 'counts nepali days' do
    expect(NepaliCalendar::Calendar.total_days_for_bs('2000/03/13', '2000/01/01')).to eq(74)
  end

  it 'counts english days' do
    expect(NepaliCalendar::Calendar.total_days(Date.parse('1944/02/13'), Date.parse('1944/01/01'))).to eq(43)
  end

  it 'has a version number' do
    expect(NepaliCalendar::VERSION).not_to be nil
  end

  it 'BS date does not respond to total_days & ref_date' do
    expect(bs_date).to_not respond_to(:total_days)
    expect(bs_date).to_not respond_to(:ref_date)
  end

  it 'AD date does not respond to date_in_range? and valid_date?' do
    expect(ad_date).to_not respond_to(:date_in_range?)
    expect(ad_date).to_not respond_to(:valid_date?)
  end

  it 'BS date does not respond to date_in_range? and valid_date?' do
    expect(bs_date).to_not respond_to(:date_in_range?)
    expect(bs_date).to_not respond_to(:valid_date?)
  end

  it 'AD date does not respond to date_in_range? and valid_date?' do
    expect(ad_date).to_not respond_to(:date_in_range?)
    expect(ad_date).to_not respond_to(:valid_date?)
  end

  it 'responds to get_ad_date & get_bs_date' do
    expect(NepaliCalendar::AdCalendar).to respond_to(:get_ad_date)
    expect(NepaliCalendar::BsCalendar).to respond_to(:get_bs_date)
  end

  context '#BsCalendar' do
    let(:bs_date_from_invalid_ad_date) { NepaliCalendar::BsCalendar.ad_to_bs('2072', '2', '30') }
    let(:bs_date_from_nil_ad_date) { NepaliCalendar::BsCalendar.ad_to_bs('', '', '') }

    it 'checks validity of ad date to be converted' do
      expect { bs_date_from_invalid_ad_date }.to raise_exception NepaliCalendar::Calendar::InvalidADDateException
      expect { bs_date_from_nil_ad_date }.to raise_exception NepaliCalendar::Calendar::NilDateFieldsException
    end
    it 'converts date from ad_to_bs' do
      expect(bs_date.year).to eq(2072)
      expect(bs_date.month).to eq(5)
      expect(bs_date.day).to eq(23)
      expect(bs_date.wday).to eq(4)
      expect(bs_date.month_name).to eq('Bhadra')
      expect(bs_date.wday_name).to eq('Budhbar')
    end

    it 'returns todays date' do
      d = Date.today
      bs_today = NepaliCalendar::BsCalendar.ad_to_bs(d.year, d.month, d.day)
      expect(bs_today.to_s).to eq(NepaliCalendar::BsCalendar.today.to_s)
    end

    it 'returns beginning of week' do
      d1 = NepaliCalendar::BsCalendar.ad_to_bs(2015, 9, 20).beginning_of_week
      d2 = NepaliCalendar::BsCalendar.ad_to_bs(2015, 9, 19).beginning_of_week
      d3 = NepaliCalendar::BsCalendar.ad_to_bs(2015, 10, 2).beginning_of_week
      d4 = NepaliCalendar::BsCalendar.ad_to_bs(2015, 4, 15).beginning_of_week
      expect(d1.to_s).to eq('Aitabar, 3 Ashwin, 2072')
      expect(d2.to_s).to eq('Aitabar, 27 Bhadra, 2072')
      expect(d3.to_s).to eq('Aitabar, 10 Ashwin, 2072')
      expect(d4.to_s).to eq('Aitabar, 29 Chaitra, 2071')
    end

    it 'returns end of week' do
      d1 = NepaliCalendar::BsCalendar.ad_to_bs(2015, 9, 20).end_of_week
      d2 = NepaliCalendar::BsCalendar.ad_to_bs(2015, 9, 19).end_of_week
      d3 = NepaliCalendar::BsCalendar.ad_to_bs(2015, 9, 28).end_of_week
      expect(d1.to_s).to eq('Sanibar, 9 Ashwin, 2072')
      expect(d2.to_s).to eq('Sanibar, 2 Ashwin, 2072')
      expect(d3.to_s).to eq('Sanibar, 16 Ashwin, 2072')
    end

    it 'returns beginning of month' do
      d1 = NepaliCalendar::BsCalendar.ad_to_bs(2015, 10, 30).beginning_of_month
      expect(d1.to_s).to eq('Aitabar, 1 Kartik, 2072')
    end

    it 'returns end of month' do
      d1 = NepaliCalendar::BsCalendar.ad_to_bs(2015, 10, 20).end_of_month
      expect(d1.to_s).to eq('Sombar, 30 Kartik, 2072')
    end

    it 'returns Calendar class object' do
      d1 = NepaliCalendar::BsCalendar.ad_to_bs(2015, 10, 20).end_of_month
      expect(d1.class).to eq(NepaliCalendar::BsCalendar)
    end

    describe '#to_ad' do
      let(:expected_date) { { year: 2023, month: 3, day: 7, wday: 2, month_name: "March", wday_name: "Tuesday" } }
      let(:bs_calendar) { NepaliCalendar::BsCalendar.new(nil, { year: 2079, month: 11, day: 23 }) }

      it 'converts the date from the BS to the AD date' do
        expect(bs_calendar.to_ad).to eq(expected_date)
      end
    end
  end

  context '#AdCalendar' do
    let(:ad_date_from_invalid_bs_date) { NepaliCalendar::AdCalendar.bs_to_ad('2072', '10', '30') }
    let(:ad_date_from_nil_bs_date) { NepaliCalendar::AdCalendar.bs_to_ad('', '', '') }

    it 'checks validity of bs date to be converted' do
      expect { ad_date_from_invalid_bs_date }.to raise_exception(NepaliCalendar::Calendar::InvalidBSDateException)
      expect { ad_date_from_nil_bs_date }.to raise_exception(NepaliCalendar::Calendar::NilDateFieldsException)
    end

    let(:ad_date) { NepaliCalendar::AdCalendar.bs_to_ad('2072', '04', '01') }
    it 'converts date from bs_to_ad' do
      expect(ad_date.year).to eq(2015)
      expect(ad_date.month).to eq(7)
      expect(ad_date.day).to eq(17)
      expect(ad_date.wday).to eq(5)
      expect(ad_date.month_name).to eq('July')
      expect(ad_date.wday_name).to eq('Friday')
    end

    it 'returns todays date' do
      d = Date.today
      bs_today = NepaliCalendar::AdCalendar.bs_to_ad(d.year, d.month, d.day)
      expect(bs_today.to_s).to eq(NepaliCalendar::AdCalendar.today.to_s)
    end

    it 'returns beginning of week' do
      d1 = NepaliCalendar::AdCalendar.bs_to_ad(2076, 7, 15).beginning_of_week
      d2 = NepaliCalendar::AdCalendar.bs_to_ad(2076, 9, 19).beginning_of_week
      d3 = NepaliCalendar::AdCalendar.bs_to_ad(2076, 10, 2).beginning_of_week
      d4 = NepaliCalendar::AdCalendar.bs_to_ad(2076, 4, 15).beginning_of_week
      expect(d1).to eq(Date.parse('Mon, 28 Oct, 2019'))
      expect(d2).to eq(Date.parse('Mon, 30 Dec, 2019'))
      expect(d3).to eq(Date.parse('Mon, 13 Jan, 2020'))
      expect(d4).to eq(Date.parse('Mon, 29 Jul, 2019'))
    end

    it 'returns end of week' do
      d1 = NepaliCalendar::AdCalendar.bs_to_ad(2076, 7, 15).end_of_week
      d2 = NepaliCalendar::AdCalendar.bs_to_ad(2076, 9, 19).end_of_week
      d3 = NepaliCalendar::AdCalendar.bs_to_ad(2076, 10, 2).end_of_week
      expect(d1).to eq(Date.parse('Sun, 3 Nov, 2019'))
      expect(d2).to eq(Date.parse('Sun, 5 Jan, 2020'))
      expect(d3).to eq(Date.parse('Sun, 19 Jan, 2020'))
    end

    it 'returns beginning of month' do
      d1 = NepaliCalendar::AdCalendar.bs_to_ad(2076, 7, 15).beginning_of_month
      expect(d1).to eq(Date.parse('Fri, 1 Nov, 2019'))
    end

    it 'returns end of month' do
      d1 = NepaliCalendar::AdCalendar.bs_to_ad(2076, 7, 15).end_of_month
      expect(d1).to eq(Date.parse('Sat, 30 Nov, 2019'))
    end

    describe '#to_date' do
      it 'returns a Date object for a valid Ad date' do
        ad_calendar = NepaliCalendar::AdCalendar.new(nil, { year: 2033, month: 12, day:12 })
        date = ad_calendar.to_date
        expect(date).to be_a(Date)
        expect(date.year).to eq(2033)
        expect(date.month).to eq(12)
        expect(date.day).to eq(12)
      end

      it 'raises an error for an invalid date string' do
        expect { ad_date.to_date('2022-02-31') }.to raise_error(ArgumentError)
        expect { ad_date.to_date('2022-13-01') }.to raise_error(ArgumentError)
        expect { ad_date.to_date('2022-01-') }.to raise_error(ArgumentError)
      end
    end
  end

  context '#FiscalYear' do
    it 'returns start of fiscal year date in BS' do
      start_date = NepaliCalendar::FiscalYear.new(78, 79).beginning_of_year
      expect(start_date.year.to_s).to eq('2078')
      expect(start_date.month.to_s).to eq('4')
      expect(start_date.day.to_s).to eq('1')
    end

    it 'returns end of fiscal year date in BS' do
      start_date = NepaliCalendar::FiscalYear.new(78, 79).end_of_year
      expect(start_date.year.to_s).to eq('2079')
      expect(start_date.month.to_s).to eq('3')
      expect(start_date.day.to_s).to eq('32')
    end

    it 'returns fiscal year date in BS' do
      fiscal_year = NepaliCalendar::FiscalYear.fiscal_year_for_bs_date(2077, 4, 1)
      expect(fiscal_year.to_s).to eq('7778')
      fiscal_year = NepaliCalendar::FiscalYear.fiscal_year_for_bs_date(2077, 3, 29)
      expect(fiscal_year.to_s).to eq('7677')
    end

    it 'returns fiscal year date in BS from AD date' do
      fiscal_year = NepaliCalendar::FiscalYear.fiscal_year_in_bs_for_ad_date(Date.new(2021, 3, 22))
      expect(fiscal_year.to_s).to eq('7778')

      # edge case
      fiscal_year = NepaliCalendar::FiscalYear.fiscal_year_in_bs_for_ad_date(Date.new(2022, 7, 16))
      expect(fiscal_year.to_s).to eq('7879')
    end

    it 'returns the current fiscal year represented as a string' do
      allow(Date).to receive(:today).and_return(Date.new(2022, 5, 26))
      fiscal_year = NepaliCalendar::FiscalYear.current_fiscal_year
      expect(fiscal_year.to_s).to eq('7879')
    end
  end
end
