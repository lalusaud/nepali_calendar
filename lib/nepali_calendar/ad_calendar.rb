require 'exceptions/exceptions'
module NepaliCalendar
  class AdCalendar < NepaliCalendar::Calendar

    class << self
      InvalidBSDateException = Exception.new("Invalid BS Date!")
      def bs_to_ad(year, month, day)
        ref_day_nep = ref_date['bs_to_ad']['bs']
        date_bs = "#{year}/#{month}/#{day}"
        return unless date_in_range?(date_bs, ref_day_nep)
        get_ad_date(year, month, day, ref_day_nep)
      end

      def get_ad_date(year, month, day, ref_day_nep)
        raise InvalidBSDateException unless valid_bs_date?(year, month, day)

        ref_year, ref_month, ref_day = ref_day_nep.split('/').map(&:to_i)
        k = ref_year

        # No. of Days from year
        i = days = 0
        j = 1
        while i < (year.to_i - ref_year)
          i += 1
          while j <= 12
            days += NepaliCalendar::BS[k][j]
            j += 1
          end
          j = 0
          k += 1
        end

        # No. of Days from month
        j = 1
        while j <= (month.to_i - ref_month)
          days += NepaliCalendar::BS[k][j]
          j += 1
        end

        days += (day.to_i - ref_day)
        ad = Date.parse(ref_date['bs_to_ad']['ad']) + days

        options = {year: ad.year, month: ad.month, day: ad.day, wday: ad.wday,
          month_name: Date::MONTHNAMES[ad.month], wday_name: ad.strftime("%A")}
        new('', options)
      end
    end
  end
end
