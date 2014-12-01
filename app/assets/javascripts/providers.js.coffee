$ ->
  $( '#provider-response-table' ).dataTable
    processing: true
    serverSide: true
    ajax: $('#provider-response-table').data('source')
    pagingType: 'full_numbers'
    scrollX: true,
    scrollY: "500px"
    scrollCollapse: true
    autoWidth: false
    pageLength: 50
    lengthMenu: [ [50, 100, 150, -1], [50, 100, 150, "All"] ]
    stateSave: true
    order: [ 1, 'desc' ]
    columnDefs: [
      { "orderable": false, "targets": 0 }
    ]