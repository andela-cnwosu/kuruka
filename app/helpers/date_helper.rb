module DateHelper
  def date_range(start, duration_in_days)
    (start..duration_in_days.days.from_now)
  end

  def date_range_from_now(duration_in_days)
    (Date.today..duration_in_days.days.from_now)
  end

  def day(date)
    date.strftime("%A")
  end

  def month_day(date)
    date.strftime("%B %e")
  end

  def short_month_day(date)
    date.strftime("%b %e")
  end

  def full_date(date)
    date.strftime("%B %e, %Y")
  end

  def full_date_time(date)
    date.strftime("%I:%M%p  %B %e, %Y")
  end

  def short_date_time(date)
    date.strftime("%I:%M%p  %d-%m-%Y")
  end

  def time(date)
    date.strftime("%I:%M%p")
  end

  def parse_date(date)
    DateTime.parse(date)
  end

  def date_without_time(datetime)
    datetime.strftime("%Y-%m-%d")
  end

  def date_human_format(datetime)
    datetime.strftime("%d-%m-%Y")
  end
end