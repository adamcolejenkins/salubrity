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
  
end
