# frozen_string_literal: true

require 'byebug'
module NepaliCalendar
  class AdCalendar < NepaliCalendar::Calendar
    class << self
      def bs_to_ad(year, month, day)
        raise NepaliCalendar::Calendar::NilDateFieldsException unless valid_date_input?(year, month, day)
        raise NepaliCalendar::Calendar::InvalidBSDateException unless valid_bs_date?(year, month, day)

        ref_day_nep = get_ref_day_nep
        date_bs = "#{year}/#{month}/#{day}"
        return unless date_in_range?(date_bs, ref_day_nep)

        days = total_days_for_bs(date_bs, ref_day_nep) # ref = '2000/01/01'
        get_ad_date(days, ref_date['bs_to_ad']['ad'])
      end

      def get_ad_date(days, ref_day_eng)
        ref_day_eng.split('/').map(&:to_i)
        travel days
      end

      def today
        date = Date.today
        bs_to_ad(date.year, date.month, date.day)
      end
    end

    def beginning_of_week
      date = { year: year, month: month, day: day, wday: wday, month_name: Date::MONTHNAMES[month.to_i],
               wday_name: Date::DAYNAMES[wday.to_i] }
      formatted_date = Date.parse(NepaliCalendar::Calendar.new('', date).to_s)
      formatted_date.beginning_of_week
    end

    def end_of_week
      date = { year: year, month: month, day: day, wday: wday, month_name: Date::MONTHNAMES[month.to_i],
               wday_name: Date::DAYNAMES[wday.to_i] }
      formatted_date = Date.parse(NepaliCalendar::Calendar.new('', date).to_s)
      formatted_date.end_of_week
    end

    def beginning_of_month
      date = { year: year, month: month, day: day, wday: wday, month_name: Date::MONTHNAMES[month.to_i],
               wday_name: Date::DAYNAMES[wday.to_i] }
      formatted_date = Date.parse(NepaliCalendar::Calendar.new('', date).to_s)
      formatted_date.beginning_of_month
    end

    def end_of_month
      date = { year: year, month: month, day: day, wday: wday, month_name: Date::MONTHNAMES[month.to_i],
               wday_name: Date::DAYNAMES[wday.to_i] }
      formatted_date = Date.parse(NepaliCalendar::Calendar.new('', date).to_s)
      formatted_date.end_of_month
    end

    def self.travel(days)
      return if days.nil? && days.zero?

      option = if days.negative?
                 travel_backward(days)
               else
                 travel_forward(days)
               end
      NepaliCalendar::AdCalendar.date_object(option)
    end

    def self.travel_forward(days)
      ad = Date.parse(ref_date['bs_to_ad']['ad']) + days

      option = { year: ad.year, month: ad.month, day: ad.day, wday: ad.wday,
                 month_name: Date::MONTHNAMES[ad.month.to_i], wday_name: ad.strftime('%A') }
      new('', option)
    end

    def self.travel_backward(days)
      ad = Date.parse(ref_date['bs_to_ad']['ad']) - days

      option = { year: ad.year, month: ad.month, day: ad.day, wday: ad.wday,
                 month_name: Date::MONTHNAMES[ad.month], wday_name: ad.strftime('%A') }
      new('', option)
    end

    def self.date_object(date)
      month_name = date.month_name
      wday_name = date.wday_name
      option = { year: date.year, month: date.month, day: date.day,
                 wday: date.wday, month_name: month_name, wday_name: wday_name }
      new('', option)
    end

    def self.get_ref_day_nep
      ref_date['bs_to_ad']['bs']
    end

    def start_date
      date = view_context.params.fetch(:start_date, '')
      date.blank? ? NepaliCalendar::AdCalendar.today : to_ad_date(date)
    end

    def to_ad_date(date)
      d = date.split('-').map(&:to_i)
      d = NepaliCalendar::BsCalendar.ad_to_bs(d[0], d[1], d[2])
      NepaliCalendar::AdCalendar.bs_to_ad(d.year, d.month, d.day)
    end

    def date_range
      [
        start_date.beginning_of_month.beginning_of_week,
        start_date.end_of_month.end_of_week
      ]
    end

    def to_date
      Date.new(year, month, day)
    end
  end
end
