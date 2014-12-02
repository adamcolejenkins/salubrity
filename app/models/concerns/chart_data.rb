module ChartData
  extend ActiveSupport::Concern
  include ApplicationHelper

  DEFAULT_FILL_COLOR = "#dfe2e7"

  def data_for(attribute, *args)
    self.send("#{attribute}_data", *args)
  end

  private

  def total(args)
    logger.debug("START:: ChartData.total =========================================================")
    count = 0
    self.responses.includes(:answers).map do |response|
      count += response.answers.where({ field: args[:field], value: args[:value] }).size
    end

    logger.debug("STOP:: ChartData.total =========================================================")
    count
  end

  def responses_data
    self.send :bar_graph_json,
              labels: self.responses.group('date(created_at)').count.to_a.map { |k, v| k },
              data: self.responses.group('date(created_at)').count.to_a.map { |k, v| v }
  end

  def average_time_data(args)
    
  end

  def multiple_choice_field_data(args)
    a = args[:field].field_choices.inject({}) do |a, choice|
      a[choice.label] = total(field: args[:field], value: choice.id.to_s)
      a
    end
    a
  end

  def multiple_choice_field_colors_data(args)
    a = []
    args[:field].field_choices.map { |choice|
      a << choice.color
    }
    a
  end

  def scale_field_data(args)
    
  end

  def paragraph_text_field_data(args)
    
  end

  def single_line_text_field_data(args)
    
  end

  ## Output:
  # {
  #   labels: ["a", "b", "c"],
  #   datasets: [
  #     {
  #       fillColor: "#dfe2e7",
  #       data: [1, 2, 3]
  #     }
  #   ]
  # }
  def bar_graph_json(args)
    {
      labels: args[:labels]|| [],
      datasets: [
        {
          fillColor: DEFAULT_FILL_COLOR,
          data: args[:data] || []
        }
      ]
    }
  end

  ## Output:
  # {
  #   value: 1,
  #   color: "#ff0000",
  #   highlight: "#00FF00",
  #   label: "a"
  # }
  def pie_chart_json(args)
    {
      value: args[:value],
      color: args[:color],
      highlight: lighten_color(args[:color], 0.1),
      label: args[:label],
    }
  end

end