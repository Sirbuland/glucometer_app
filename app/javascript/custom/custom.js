$(document).ready(function(){
  $('#datepicker').datepicker();

  // Reports

  $('body').on('click', '.generate-report', function(){
    let end_date = $('#date').val();
    let data_url = $(this).attr('data-url');
    let report_type = $(this).attr('data-report-type');
    let url = `${data_url}?end_date=${end_date}&report_type=${report_type}`;
    window.location.href = url;
  });

});