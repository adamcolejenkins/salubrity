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
    logger.debug("START:: DashboardHelper.total_answers =========================================================")
    count = 0
    opts[:resource].find_each do |resource|
      count += resource.answers.where(opts[:where]).size
    end

    logger.debug("NEW:::")
    # logger.debug( Answer.where(response_id: opts[:resource].map { |r| r.id }).count )
    logger.debug( "COUNT:: #{count}" )
    logger.debug("STOP:: DashboardHelper.total_answers =========================================================")
    count
  end
  
end
