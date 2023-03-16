# frozen_string_literal: true

module NepaliCalendar
  class FiscalYear
    attr_accessor :start_year, :end_year

    def initialize(start_year, end_year)
      @start_year = start_year
      @end_year = end_year
    end

    # returns start of fiscal year date in BS
    def beginning_of_year
      start_date = start_year.to_s.prepend('20')
      NepaliCalendar::BsCalendar.new(nil, { year: start_date, month: 4, day: 1 })
    end

    # returns end of fiscal year date in BS
    def end_of_year
      end_date = end_year.to_s.prepend('20')
      NepaliCalendar::BsCalendar.new(nil, { year: end_date, month: 3, day: NepaliCalendar::BS[end_date.to_i][3] })
    end

    # returns fiscal year date in BS
    # (2079, 2, 12) ==> 7879
    def self.fiscal_year_for_bs_date(bs_year, bs_month, bs_day)
      bs_date = NepaliCalendar::BsCalendar.new(nil, { year: bs_year, month: bs_month, day: bs_day })
      fiscal_year = if bs_date.month < 4
                      (bs_date.year - 1).to_s.slice(2, 2).to_s + bs_date.year.to_s.slice(2, 2).to_s
                    else
                      bs_date.year.to_s.slice(2, 2).to_s + (bs_date.year + 1).to_s.slice(2, 2).to_s
                    end
      NepaliCalendar::FiscalYear.new(fiscal_year.to_s.slice(0, 2), fiscal_year.to_s.slice(2, 2))
    end

    # [date] -> This is a Date object (and obviously represents AD date)
    # Returns the fiscal year represented as a string in the form of 7778.
    def self.fiscal_year_in_bs_for_ad_date(date)
      bs_date = NepaliCalendar::BsCalendar.ad_to_bs(date.year.to_s, date.month.to_s, date.day.to_s)
      fiscal_year = if bs_date.month < 4
                      (bs_date.year - 1).to_s.slice(2, 2).to_s + bs_date.year.to_s.slice(2, 2).to_s
                    else
                      bs_date.year.to_s.slice(2, 2).to_s + (bs_date.year + 1).to_s.slice(2, 2).to_s
                    end
      NepaliCalendar::FiscalYear.new(fiscal_year.to_s.slice(0, 2), fiscal_year.to_s.slice(2, 2))
    end

    # Returns the  current fiscal year represented as a string in the form of 7778.
    def self.current_fiscal_year
      bs_date_today = NepaliCalendar::BsCalendar.ad_to_bs(Date.today.year, Date.today.month, Date.today.day)
      fiscal_year = if bs_date_today.month < 4
                      (bs_date_today.year - 1).to_s.slice(2, 2) + bs_date_today.year.to_s.slice(2, 2)
                    else
                      bs_date_today.year.to_s.slice(2, 2) + (bs_date_today.year + 1).to_s.slice(2, 2)
                    end

      NepaliCalendar::FiscalYear.new(fiscal_year.to_s.slice(0, 2), fiscal_year.to_s.slice(2, 2))
    end

    # Should return the '7879' form of string.
    def to_s
      start_year.to_s + end_year.to_s
    end
  end
end
