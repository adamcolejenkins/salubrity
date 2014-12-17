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
          scrollY: "500px"
          scrollCollapse: true
          autoWidth: false
          pageLength: 50
          searching: false
          lengthMenu: [ [50, 100, 150, -1], [50, 100, 150, "All"] ]
          order: [ 1, 'desc' ]
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
          cancelClass: 'secondary'
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