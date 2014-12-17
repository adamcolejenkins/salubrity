module DashboardHelper

  def to_time_string(t)
    Time.at(t).utc.strftime("%M:%S")
  end

  def percent(count, total, formatted=false, precision=2)
    return 0 unless total > 0

    percent = number_with_precision((count.to_f / total.to_f).to_f, precision: precision).to_i
    percent = number_to_percentage((percent * 100), precision: precision) if formatted
    percent
  end

  def total_answers(opts)
    count = 0
    opts[:resource].find_each do |resource|
      count += resource.answers.where(opts[:where]).size
    end
    count
  end

  def grouped_by(filter)
    case filter
    when 'day'
      return 'by Hour'
    when 'week'
      return 'by Day'
    when 'month'
      return 'by Week'
    end
  end

  def date_range_label(params)
    from = from(params)
    to = to(params)
    
    return from.strftime("%A, %B %d, %Y") if from == to

    from.strftime("%B %d, %Y") + " - " + to.strftime("%B %d, %Y")
  end

  def date_range_filter_label(params)
    self.send(params[:filter] + "_label", from(params), to(params))
  end

  def day_label(from, to)
    return 'Today' if from == to && from == Date.today
    return 'Yesterday' if from == to && from == Date.yesterday
    time_ago_in_words(from) + " ago"
  end

  def week_label(from, to)
    return 'This Week' if from == beginning_of_this_week && to == end_of_this_week
    return 'Last Week' if from == beginning_of_one_week_ago && to == end_of_one_week_ago
    'Week'
  end

  def month_label(from, to)
    return 'This Month' if from == beginning_of_this_month && to == end_of_this_month
    return 'Last Month' if from == beginning_of_one_month_ago && to == end_of_one_month_ago
    'Month'
  end

  def custom_label(from, to)
    'Custom'
  end

  def beginning_of_this_week
    Date.today.beginning_of_week.to_date
  end

  def end_of_this_week
    Date.today.end_of_week.to_date
  end

  def beginning_of_one_week_ago
    1.week.ago.beginning_of_week.to_date
  end

  def end_of_one_week_ago
    1.week.ago.end_of_week.to_date
  end

  def beginning_of_this_month
    Date.today.beginning_of_month.to_date
  end

  def end_of_this_month
    Date.today.to_date
  end

  def beginning_of_one_month_ago
    1.month.ago.beginning_of_month.to_date
  end

  def end_of_one_month_ago
    1.month.ago.end_of_month.to_date
  end

  def from(params)
    params[:from].to_date
  end

  def to(params)
    params[:to].to_date
  end
  
end
