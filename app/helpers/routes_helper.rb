module RoutesHelper
  def trip_day_label(day)
    today = Date.current

    case day
    when today
      "Today"
    when today.tomorrow
      "Tomorrow"
    else
      day.strftime("%a %-d %b")
    end
  end

  def day_range
    Date.current..6.days.from_now
  end
end
