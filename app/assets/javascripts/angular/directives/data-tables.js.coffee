@salubrity

.directive('ngDataTables', ["$timeout", "$parse", ($timeout, $parse) ->

  return (
    restrict: "A"
    link: ($scope, $el, attrs) ->
      $timeout ->
        # Data Tables
        $el.dataTable
          processing: true
          serverSide: true
          ajax: attrs.source
          pagingType: 'full_numbers'
          scrollX: true,
          scrollY: "900px"
          scrollCollapse: true
          autoWidth: false
          pageLength: 50
          searching: false
          lengthMenu: [ [50, 100, 150, -1], [50, 100, 150, "All"] ]
          order: [ 0, 'desc' ]
          columnDefs: [
            { "orderable": false, "targets": $parse(attrs.sortDisabled)($scope) }
          ]
  )

])

.directive('ngDatePicker', ["$timeout", ($timeout) ->

  return (
    restrict: "A"
    link: ($scope, $el, attrs) ->
      $timeout ->
        $URI = new Uri(window.location.href)

        # Date Range Pickers
        $el.daterangepicker
          format: 'YYYY-MM-DD'
          startDate: $URI.getQueryParamValue('from')
          endDate: $URI.getQueryParamValue('to')
          maxDate: new Date()
          showDropdowns: true
          applyClass: 'primary'
          cancelClass: ''
          opens: 'left'
          ranges:
            'Today': [moment(), moment()]
            'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)]
            'This Week': [moment().startOf('week'), moment().endOf('week')]
            'Last Week': [moment().subtract('week', 1).startOf('week'), moment().subtract('week', 1).endOf('week')]
            'This Month': [moment().startOf('month'), moment().endOf('month')]
            'Last Month': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
        , (start, end, label) ->

          start = start.format('YYYY-MM-DD')
          end = end.format('YYYY-MM-DD')
          filter = (if start is end then "day" else "custom")

          $URI.replaceQueryParam('from', start)
          $URI.replaceQueryParam('to', end)
          $URI.replaceQueryParam('filter', filter)
          window.location.href = $URI

        $el.on 'show.daterangepicker', (ev, picker) ->
          $(this).attr('aria-expanded', 'true')

        $el.on 'hide.daterangepicker', (ev, picker) ->
          $(this).attr('aria-expanded', 'false')
  )

])