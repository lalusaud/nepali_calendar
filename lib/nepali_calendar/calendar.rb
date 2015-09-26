require 'rails'

module NepaliCalendar
  class Calendar

    attr_accessor :view_context, :options

    def initialize(view_context, options={})
      @view_context = view_context
    end

    def render(&block)
      view_context.render(
        partial: 'nepali_calendar/bs_calendar',
        locals: {
          block: block,
          # start_date: start_date,
          # date_range: date_range
        }
      )
    end

    private

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
