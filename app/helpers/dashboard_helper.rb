module DashboardHelper
  def time_diff(started, ended)
    TimeDifference.between(started, ended).in_minutes
  end

  def avg_time_diff()
    
  end

  def percent(count, total, formatted=false, precision=2)
    return 0 unless total > 0

    percent = (count.to_f / total.to_f).to_f
    percent = number_to_percentage((percent * 100), precision: precision) if formatted
    percent
  end

  def total_answers(opts)
    count = 0
    opts[:resource].each do |resource|
      count += resource.answers.where(opts[:where]).count
    end
    count
  end
end
