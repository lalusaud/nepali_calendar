require 'nepali_calendar/version'
require 'nepali_calendar/bs'
require 'date'

module NepaliCalendar
  class Calendar

    attr_reader :bs_year, :bs_month, :bs_day, :bs_wday, :bs_month_name, :bs_wday_name

    MONTHNAMES = %w{nil Baisakh Jestha Ashad Shrawn Bhadra Ashwin Kartik Mangshir Poush Magh Falgun Chaitra}
    DAYNAMES = %w{nil Aitabar Sombar Mangalbar Budhbar Bihibar Sukrabar Sanibar}

    def initialize(year=nil, month=nil, day=nil, wday=nil, month_name=nil, wday_name=nil)
      @bs_year, @bs_month, @bs_day = year, month, day
      @bs_wday, @bs_month_name, @bs_wday_name = wday, month_name, wday_name
    end

    def ad_to_bs(year, month, day)
      fail 'Invalid date!' unless valid_date?(year, month, day)

      ref_day_eng = Date.parse(ref_date['ad_to_bs']['ad'])
      date_ad = Date.parse("#{year}/#{month}/#{day}")
      return unless date_in_range?(date_ad, ref_day_eng)

      days = total_days(date_ad, ref_day_eng)
      get_bs_date(days, ref_date['ad_to_bs']['bs'])
    end

    def get_bs_date(days, ref_day_nep)
      year, month, day = ref_day_nep.split('/').map(&:to_i)
      i = year
      j = month
      wday = 7

      while days != 0
        bs_month_days = NepaliCalendar::BS[i][j - 1]
        day += 1
        wday += 1

        if day > bs_month_days
          month += 1
          day = 1
          j += 1
        end

        wday = 1 if wday > 7

        if month > 12
          year += 1
          month = 1
        end

        if j > 12
          j  = 1
          i += 1
        end
        days -= 1
      end

      month_name = MONTHNAMES[month]
      wday_name = DAYNAMES[wday]
      Calendar.new(year, month, day, wday, month_name, wday_name)
    end

    def bs_to_ad(year, month, day)
      fail 'Invalid date!' unless valid_date?(year, month, day)

      ref_day_nep = ref_date['bs_to_ad']['bs']

      date_bs = Date.parse("#{year}/#{month}/#{day}")
      return unless date_in_range?(date_bs, Date.parse(ref_day_nep))

      get_ad_date(year, month, day, ref_day_nep)
    end

    def get_ad_date(year, month, day, ref_day_nep)
      ref_year, ref_month, ref_day = ref_day_nep.split('/').map(&:to_i)
      k = ref_year

      # No. of Days from year
      i = 0
      days = 0
      j = 0
      while i < (year.to_i - ref_year)
        i += 1
        while j < 12
          days += NepaliCalendar::BS[k][j]
          j += 1
        end
        j = 0
        k += 1
      end

      # No. of Days from month
      j = 0
      while j < (month.to_i - ref_month)
        days += NepaliCalendar::BS[k][j]
        j += 1
      end

      days += (day.to_i - ref_day)
      Date.parse(ref_date['bs_to_ad']['ad']) + days
    end

    private

      def total_days(date_eng, reference_date)
        days = date_eng - reference_date
        days.to_i
      end

      def date_in_range?(date, reference_date)
        date > reference_date
      end

      def valid_date?(year, month, day)
        Date.valid_date?(year.to_i, month.to_i, day.to_i)
      end

      def ref_date
        {
          'bs_to_ad' => { 'bs' => '2000/01/01', 'ad' => '1943/04/14' },
          'ad_to_bs' => { 'bs' => '2000/09/17', 'ad' => '1944/01/01' }
        }
      end
  end
end
