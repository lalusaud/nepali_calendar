module NepaliCalendar
  class AdCalendar < NepaliCalendar::Calendar

    def self.bs_to_ad(year, month, day)
      fail 'Invalid date!' unless valid_date?(year, month, day)

      ref_day_nep = ref_date['bs_to_ad']['bs']

      date_bs = Date.parse("#{year}/#{month}/#{day}")
      return unless date_in_range?(date_bs, Date.parse(ref_day_nep))

      get_ad_date(year, month, day, ref_day_nep)
    end

    def self.get_ad_date(year, month, day, ref_day_nep)
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
      ad = Date.parse(ref_date['bs_to_ad']['ad']) + days
      {
        ad_year: "#{ad.year}", ad_month: "#{format_initial(ad.month)}",
        ad_day: "#{format_initial(ad.day)}", ad_wday: "#{ad.wday}",
        ad_month_name: "#{Date::MONTHNAMES[ad.month]}",
        ad_wday_name: "#{ad.strftime("%A")}"
      }
    end
  end
end
