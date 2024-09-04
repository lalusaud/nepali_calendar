module NepaliCalendar
  module ViewHelpers
    def bs_calendar options = {}, &block
      render partial: '/nepali_calendar/bs_calendar', locals: {
        cal: calendar(options[:start_date]),
        block: block
      }
    end

    def travel day, date
      option = {year: date.year, month: date.month, day: date.day, wday: date.wday}
      NepaliCalendar::BsCalendar.travel(day, option)
    end

    private

    def calendar(start_date = nil)
      return NepaliCalendar::BsCalendar.today if start_date.nil?

      NepaliCalendar::BsCalendar.to_bs_date(start_date)
    end
  end
end
