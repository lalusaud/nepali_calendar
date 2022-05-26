require 'rails'
require 'byebug'
require 'exceptions/exceptions'

module NepaliCalendar
  class Calendar

    attr_accessor :view_context, :options, :year, :month,
                  :day, :wday, :month_name, :wday_name

    InvalidADDateException = Exception.new("Invalid AD Date!")
    InvalidBSDateException = Exception.new("Invalid BS Date!")
    NilDateFieldsException = Exception.new("Date fields can't be empty!")

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
    alias_method :to_s, :readable_inspect


    private

      def date_range
        (start_date.beginning_of_month.beginning_of_week..(start_date.end_of_month.end_of_week))
      end

      def start_date
        Date.today
      end

      def self.total_days(date_eng, reference_date)
        days = date_eng - reference_date
        days.to_i
      end

      def self.total_days_for_bs(date_nep, reference_date)
        ref_year, ref_month, ref_day = reference_date.split('/').map(&:to_i)
        nep_year, nep_month, nep_day = date_nep.split('/').map(&:to_i)
        temp_day = nep_day
        days = 0
        # nep_year = 2078
        # nep_month = 1
        # 2000/01/01'
        while nep_year >= ref_year && nep_month >= ref_month
          days += temp_day
          nep_month -= 1
          if nep_month < 1
            nep_year -= 1
            if nep_year == ref_year - 1
              break
            end
            nep_month = 12
          end
          temp_day = begin
            if nep_year == ref_year && nep_month == ref_month
              NepaliCalendar::BS[nep_year][nep_month].to_i - 1
            else
              NepaliCalendar::BS[nep_year][nep_month].to_i
            end
          end

        end
        days
      end

    def self.valid_date_input?(year, month, day)
        [year.to_i,month.to_i,day.to_i].any? { |item| item > 0 }
      end

      def self.date_in_range?(date, reference_date)
        date > reference_date && date.to_s < '2091/01/01'
        # TODO: Check for both BS & AD (Upper and Lower limit)
      end

      def self.valid_ad_date?(year, month, day)
        Date.valid_date?(year.to_i, month.to_i, day.to_i)
      end

      def self.valid_bs_date?(year, month, day)
        day.to_i <= NepaliCalendar::BS[year.to_i][month.to_i]
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
