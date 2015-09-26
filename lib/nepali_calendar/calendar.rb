require 'rails'

module NepaliCalendar
  class Calendar

    attr_accessor :view_context, :options, :year, :month,
                  :day, :wday, :month_name, :wday_name

    def initialize(view_context, options={})
      @view_context = view_context
      @year = options[:year]
      @month = options[:month]
      @day = options[:day]
      @wday = options[:wday]
      @month_name = options[:month_name]
      @wday_name = options[:wday_name]
    end

    def render(&block)
      view_context.render(
        partial: 'nepali_calendar/bs_calendar',
        locals: {
          block: block,
          start_date: start_date,
          date_range: date_range
        }
      )
    end

    # Overrides the default inspect method with a human readable one, e.g., "Sombar, 21 Magh 2072"
    def readable_inspect
      "#{wday_name}, #{day} #{month_name}, #{year}"
    end
    alias_method :default_inspect, :inspect
    alias_method :inspect, :readable_inspect

    private

      def date_range
        (start_date..(start_date + 4))
      end

      def start_date
        Date.today
      end

      def self.total_days(date_eng, reference_date)
        days = date_eng - reference_date
        days.to_i
      end

      def self.date_in_range?(date, reference_date)
        date > reference_date
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
