class ResponseDatatable < AjaxDatatablesRails::Base
  # uncomment the appropriate paginator module,
  # depending on gems available in your project.
  include AjaxDatatablesRails::Extensions::Kaminari
  # include AjaxDatatablesRails::Extensions::WillPaginate
  # include AjaxDatatablesRails::Extensions::SimplePaginator
  
  def_delegators :@view, :h, :current_team, :check_box_tag

  def sortable_columns
    # list columns inside the Array in string dot notation.
    # Example: 'users.email'
    @sortable_columns ||= [
      '',
      'responses.created_at',
      'clinics.title',
      'providers.surname'
    ]
  end

  def searchable_columns
    # list columns inside the Array in string dot notation.
    # Example: 'users.email'
    @searchable_columns ||= [
      '',
      'responses.created_at',
      'clinics.title',
      'providers.surname'
    ]
  end

  private

  def data
    records.map do |record|
      [
        check_box_tag("response[#{record.id}]", record.id),
        record.created_at.strftime("%B %e, %Y at %H:%M:%S"),
        record.clinic.title,
        record.provider.full_name,
        record.time.to_s + " seconds"
      ] + record.answers.joins(:field).select(:value).order('fields.priority ASC').map(&:value)
    end
  end

  def get_raw_records
    current_team.responses
      .joins(:provider, :clinic)
      .includes(:provider, :clinic)
      .between(params[:from], params[:to])
      .filter(params.slice(:limit, :survey, :clinic, :provider))
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
