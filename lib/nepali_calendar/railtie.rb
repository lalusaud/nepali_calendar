# frozen_string_literal: true

module NepaliCalendar
  class Engine < Rails::Engine
    initializer 'nepali_calendar.view_helpers' do
      ActionView::Base.include ViewHelpers
    end
  end
end
