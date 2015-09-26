module NepaliCalendar
  module ViewHelpers
    def bs_calendar(options = {}, &block)
      raise 'Please pass a block to bs calendar' unless block_given?
      NepaliCalendar::BsCalendar.new(self, options).render(&block)
    end
  end
end
