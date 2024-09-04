require 'rails'

module NepaliCalendar
  class Calendar

    attr_accessor :options, :year, :month,
                  :day, :wday, :month_name, :wday_name

    def initialize(options={})
      raise 'Invalid params' unless options.is_a?(Hash)

      @year = options.fetch(:year, start_date.year)
      @month = options.fetch(:month, start_date.month)
      @day = options.fetch(:day, start_date.day)
      @wday = options.fetch(:wday, start_date.wday)
      @month_name = options.fetch(:month_name, '')
      @wday_name = options.fetch(:wday_name, '')

      # @view_context = view_context
    end

    # def render(&block)
    #   raise 'View context not defined!' if view_context.nil?

    #   view_context.render(
    #     partial: 'nepali_calendar/bs_calendar',
    #     locals: {
    #       block: block,
    #       start_date: start_date,
    #       date_range: date_range
    #     }
    #   )
    # end

    def to_s
      "#{year}-#{two_digits(month)}-#{two_digits(day)}"
    end

    # Overrides the default inspect method with a human readable one, e.g., "Sombar, 21 Magh 2072"
    def readable_inspect
      "#{wday_name}, #{day} #{month_name}, #{year}"
    end
    alias_method :default_inspect, :inspect
    alias_method :inspect, :readable_inspect

    def date_range
      [
        start_date.beginning_of_month.beginning_of_week,
        start_date.end_of_month.end_of_week
      ]
    end

    def start_date
      Date.today
    end

    private

      def two_digits(number)
        number.to_s.chars.unshift('0')[-2..-1].join
      end

      def self.total_days(date_eng, reference_date)
        days = date_eng - reference_date
        days.to_i
      end

      def self.date_in_range?(date, reference_date)
        date > reference_date
        # TODO: Check for both BS & AD (Upper and Lower limit)
      end

      def self.valid_date?(year, month, day)
        Date.valid_date?(year.to_i, month.to_i, day.to_i)
      end

      def self.format_initial(date)
        (date < 10) ? "0#{date}" : date
      end

      def self.ref_date
        {
          'bs_to_ad' => { 'bs' => '2000/01/01', 'ad' => '1943/04/14' },
          'ad_to_bs' => { 'bs' => '2000/09/17', 'ad' => '1944/01/01' }
        }
      end
  end
end
