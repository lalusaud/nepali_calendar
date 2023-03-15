# frozen_string_literal: true

module NepaliCalendar
  class BsCalendar < NepaliCalendar::Calendar
    MONTHNAMES = %w[nil Baisakh Jestha Ashad Shrawn Bhadra Ashwin Kartik Mangshir Poush Magh Falgun Chaitra].freeze
    DAYNAMES = %w[nil Aitabar Sombar Mangalbar Budhbar Bihibar Sukrabar Sanibar].freeze

    class << self
      def ad_to_bs(year, month, day)
        raise NepaliCalendar::Calendar::NilDateFieldsException unless valid_date_input?(year, month, day)
        raise NepaliCalendar::Calendar::InvalidADDateException unless valid_ad_date?(year, month, day)

        ref_day_eng = get_ref_day_eng # 1994/1/1
        date_ad = Date.parse("#{year}/#{month}/#{day}")
        return unless date_in_range?(date_ad, ref_day_eng)

        days = total_days(date_ad, ref_day_eng)
        get_bs_date(days, ref_date['ad_to_bs']['bs']) # days = 10372 when '2022-05-26', ref_date = '2009/9/17'
      end

      def get_bs_date(days, ref_day_nep)
        wday = 7
        year, month, day = ref_day_nep.split('/').map(&:to_i)
        travel days, year: year, month: month, day: day, wday: wday
      end

      def today
        date = Date.today
        ad_to_bs(date.year, date.month, date.day)
      end
    end

    def date
      # Convert nepali date to Ad date
      date = self.to_ad

      # Create new date object with the Ad date
      date_object = Date.new(date[:year], date[:month], date[:day])

      # Get the week_day name, month name
      weekday_name = DAYNAMES[date_object.wday + 1]
      month_name = MONTHNAMES[@month]

      { weekday_name: weekday_name, month_name: month_name, day: @day, month: @month, year: @year }
    end

    def beginning_of_week
      date = { year: year, month: month, day: day, wday: wday }
      days = wday > 1 ? -(wday - 1) : 0
      NepaliCalendar::BsCalendar.travel days, date
    end

    def end_of_week
      date = { year: year, month: month, day: day, wday: wday }
      days = wday < 7 ? (7 - wday) : 0
      NepaliCalendar::BsCalendar.travel days, date
    end

    def beginning_of_month
      date = { year: year, month: month, day: day, wday: wday }
      days = -(day - 1)
      NepaliCalendar::BsCalendar.travel days, date
    end

    def end_of_month
      date = { year: year, month: month, day: day, wday: wday }
      days = NepaliCalendar::BS[year][month] - day
      NepaliCalendar::BsCalendar.travel days, date
    end

    def self.travel(days, option = {})
      return if days.nil? && days.zero?

      option = if days.negative?
                 travel_backward(days, option)
               else
                 travel_forward(days, option)
               end
      NepaliCalendar::BsCalendar.date_object(option)
    end

    def self.travel_forward(days, option = {})
      year = option[:year]
      month = option[:month]
      day = option[:day]
      wday = option[:wday]

      while days != 0
        bs_month_days = NepaliCalendar::BS[year][month]
        day += 1
        wday += 1
        wday = 1 if wday > 7

        if day > bs_month_days
          month += 1
          day = 1
        end

        if month > 12
          year += 1
          month = 1
        end

        days -= 1
      end
      { year: year, month: month, day: day, wday: wday }
    end

    def self.travel_backward(days, option = {})
      year = option[:year]
      month = option[:month]
      day = option[:day]
      wday = option[:wday]

      while days != 0
        day -= 1
        wday -= 1
        wday = 7 if wday < 1

        if day < 1
          month -= 1
          if month < 1
            year -= 1
            month = 12
          end
          day = NepaliCalendar::BS[year][month]
        end

        days += 1
      end
      { year: year, month: month, day: day, wday: wday }
    end

    def self.date_object(date)
      month_name = MONTHNAMES[date[:month]]
      wday_name = DAYNAMES[date[:wday]]
      option = { year: date[:year], month: date[:month], day: date[:day],
                 wday: date[:wday], month_name: month_name, wday_name: wday_name }
      new('', option)
    end

    def self.get_ref_day_eng
      Date.parse(ref_date['ad_to_bs']['ad'])
    end

    def start_date
      date = view_context.params.fetch(:start_date, '')
      date.blank? ? NepaliCalendar::BsCalendar.today : to_bs_date(date)
    end

    # date = "2079-01-01"
    def to_bs_date(date)
      d = date.split('-').map(&:to_i)
      d = NepaliCalendar::AdCalendar.bs_to_ad(d[0], d[1], d[2])
      NepaliCalendar::BsCalendar.ad_to_bs(d.year, d.month, d.day)
    end

    def date_range
      [
        start_date.beginning_of_month.beginning_of_week,
        start_date.end_of_month.end_of_week
      ]
    end

    def to_ad
      if !year || !month || !day
        raise NilDateFieldsException
      end

      if !NepaliCalendar::Calendar.valid_date_input?(year, month, day)
        raise InvalidBSDateException
      end

      ad_date = NepaliCalendar::Calendar.ref_date['bs_to_ad']['ad']
      bs_date = NepaliCalendar::Calendar.ref_date['bs_to_ad']['bs']

      total_days = NepaliCalendar::Calendar.total_days_for_bs("#{year}/#{month}/#{day}", bs_date)
      ad_date = Date.parse(ad_date) + total_days
      {
        year: ad_date.year,
        month: ad_date.month,
        day: ad_date.day,
        wday: ad_date.wday,
        month_name: I18n.t("date.month_names")[ad_date.month],
        wday_name: I18n.t("date.day_names")[ad_date.wday],
      }
    end
  end
end
