# frozen_string_literal: true

require 'rails'
require 'byebug'
require 'exceptions/exceptions'

module NepaliCalendar
  class Calendar
    attr_accessor :view_context, :options, :year, :month,
                  :day, :wday, :month_name, :wday_name

    InvalidADDateException = Exception.new('Invalid AD Date!')
    InvalidBSDateException = Exception.new('Invalid BS Date!')
    NilDateFieldsException = Exception.new("Date fields can't be empty!")

    def initialize(view_context, options = {})
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
    alias default_inspect inspect
    alias inspect readable_inspect
    alias to_s readable_inspect

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

    # ref = '2000/1/1'
    def self.total_days_for_bs(date_nep, reference_date)
      ref_year, ref_month, _ref_day = reference_date.split('/').map(&:to_i)
      nep_year, nep_month, nep_day = date_nep.split('/').map(&:to_i)
      temp_day = nep_day
      days = 0
      while nep_year >= ref_year && nep_month >= ref_month
        days += temp_day
        nep_month -= 1
        if nep_month < 1
          nep_year -= 1
          break if nep_year == ref_year - 1

          nep_month = 12
        end

        temp_day = if nep_year == ref_year && nep_month == ref_month
                     # we need to accomodate for that fact that ref date '2000/1/1' so day begins at '1' not '0'
                     # thats why we need to subtract 1 when we successfully time travel to that date
                     NepaliCalendar::BS[nep_year][nep_month].to_i - 1
                   else
                     NepaliCalendar::BS[nep_year][nep_month].to_i
                   end
      end
      days
    end

    def self.valid_date_input?(year, month, day)
      [year.to_i, month.to_i, day.to_i].any? { |item| item.positive? }
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
      date < 10 ? "0#{date}" : date
    end

    def self.ref_date
      {
        'bs_to_ad' => { 'bs' => '2000/01/01', 'ad' => '1943/04/14' },
        'ad_to_bs' => { 'bs' => '2000/09/17', 'ad' => '1944/01/01' }
      }
    end
  end
end
