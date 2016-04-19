$(document).on('ready', function() {
  $('#select-dashboard-company').on('change', function() {
    window.location = '/dashboards' + (this.value ? ('/' + this.value) : '')
  })
});
