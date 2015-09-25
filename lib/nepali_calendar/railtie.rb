module NepaliCalendar
  class Engine < Rails::Engine
    initializer "nepali_calendar.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end
  end
end
