var app_ticket = angular.module('app_ticket', ['datatables']);

app_ticket.controller("ticket_ctrl", function($scope, $compile, $q, get_tickets) {

	$scope.test = "Test";

	console.log($scope.test);

	var service_get_tickets = get_tickets.async();

	$q.all([service_get_tickets]).then(function(resp) {
		$scope.list_tickets	 = resp[0].data.data;
	});

	/* sin modificar*/
	$('.chosen-select').chosen({
			//allow_single_deselect: true,
			no_results_text: 'No results matched'
		})
		/***************/
});


/* Llamas a la API de Ruby */	
app_ticket.factory("get_tickets", function($http) {
	var get_tickets = {
		async: function(params) {

			var promise = $http({
				method: 'GET',
				url: 'localhost:3000/api/v1/ticket/get_tickets',
				params: params
			});
			promise.success(function(response) {
				return response.data;
			}).error(function(err) {
				showServiceErrorMessage(err);
				return false;
			});
			return promise;
		}
	};
	return get_tickets;
});

function showServiceErrorMessage(err) {
	alert("Ha ocurrido un error inesperado");
}