# frozen_string_literal: true

module NepaliCalendar
  module ViewHelpers
    def bs_calendar(options = {}, &block)
      raise 'Please pass a block to bs calendar' unless block_given?

      NepaliCalendar::BsCalendar.new(self, options).render(&block)
    end

    def travel(day, date)
      option = { year: date.year, month: date.month, day: date.day, wday: date.wday }
      date = NepaliCalendar::BsCalendar.travel(day, option)
      "#{date.year}-#{date.month}-#{date.day}"
    end
  end
end
