/**************************************************CONTROLLERS RELATED TO SEARCH RESULT PAGE*********************************************************/

app.controller('doctor_search', function($scope, $routeParams, $rootScope, $http, $location) {

    var doc_name = $routeParams.param11;

    $scope.url = 'serverside/search/search_result.php'; // The url of php file which is intended to populate $scope with the help of AJAX call

    var search_by_url = function(doc_name) {
        //Creating the http post request here
        $http.post($scope.url, {
            "data": doc_name
        }).
        success(function(data, status) {
            //alert('success');
            $scope.status = status;
            $rootScope.cards = data;
            $scope.result = data;

            var mapOptions = {

					zoom: 9,
					center: new google.maps.LatLng(18.5203,73.8567),
					mapTypeId: google.maps.MapTypeId.ROADMAP,
					mapTypeControl: false,
							 mapTypeControlOptions: {
							 style: google.maps.MapTypeControlStyle.HORIZONTAL_BAR
							 },
							 navigationControl: true,
							 navigationControlOptions: {
							 style: google.maps.NavigationControlStyle.SMALL
							 }
				}
				
				var bounds = new google.maps.LatLngBounds();
				
				$scope.map = new google.maps.Map(document.getElementById('map'), mapOptions);

				$scope.markers = [];
				
				var infoWindow = new google.maps.InfoWindow();
				var createMarker = function (info){
					
					var marker = new google.maps.Marker({
						map: $scope.map,
						position: new google.maps.LatLng(info.lat, info.lng),
						
						title: info.city
					});
					marker.content = '<div class="infoWindowContent">' + info.desc + '</div>';
					bounds.extend( marker.position);
					// map.fitBounds(bounds.extend);
					//console.log(bounds);	
					google.maps.event.addListener(marker, 'click', function(){
						infoWindow.setContent('<h2>' + marker.title + '</h2>' + marker.content);
						infoWindow.open($scope.map, marker);
					});
					
					$scope.markers.push(marker);
					
				}  
				
				console.log($rootScope);
				
				for (i = 0; i < $rootScope.cards.length; i++)
				{
					createMarker($rootScope.cards[i]);
				}
				$scope.map.fitBounds(bounds);		
						
				
			
			
			  $scope.filter = {};

				$scope.getArea = function () {
					return ($rootScope.cards || []).map(function (w) {
						return w.area;
					}).filter(function (w, idx, arr) {
						return arr.indexOf(w) === idx;
					});
				};
				
				$scope.getSpeciality = function () {
					return ($rootScope.cards || []).map(function (w) {
						return w.speciality;
					}).filter(function (w, idx, arr) {
						return arr.indexOf(w) === idx;
					});
				};
				
				
				$scope.filterByArea = function (a) {
					return $scope.filter[a.area] || noFilter($scope.filter);
				};
				
				function noFilter(filterObj) {
					for (var key in filterObj) {
						if (filterObj[key]) {
							return false;
						}
					}
					return true;
				} 




        }).
        error(function(data, status) {
            alert('Failure');
            $scope.data = data || "Request failed";
            $scope.status = status;
        });
    }
    if (doc_name) //if there is a parameter in the url,which would be doctor name
    {
        $scope.keywords = doc_name;
        search_by_url(doc_name); //call the function 
        //need to implement logic for this,calling the result two times

    }

    $scope.search = function() {
        //Creating the http post request here
        $http.post($scope.url, {
            "data": $scope.keywords
        }).
        success(function(data, status) {
            //alert('success');
            $scope.status = status;
            $rootScope.cards = data;
            $scope.result = data;
            //console.log($scope.data);

            window.location.replace('#/search/docname-' + $scope.keywords);
            //window.location.replace('#/search');
            //$location.path('#/search');




        }).
        error(function(data, status) {
            alert('Failure');
            $scope.data = data || "Request failed";
            $scope.status = status;
        });
    }


    $scope.show_calandar = function(doc_id) {
        $scope.url = 'serverside/search/search_result_calandar.php';
        //alert(doc_id);
        //Creating the http post request here
        $scope.loading = true;
        $http.post($scope.url, {
            "data": doc_id
        }).
        success(function(data, status) {
            // alert('success');
            var chutiya = doc_id;
            $scope.status = status;
            $scope.slots = data; //check this and if not done upload files and send the link to abhishek
            //$scope.slots.splice(1,0,doc_id);
            $scope.result = data;
            $scope.loading = false;
        }).
        error(function(data, status) {
            alert('Failure');
            $scope.data = data || "Request failed";
            $scope.status = status;
        });
    }


    /*************Search by Speciality function  ***********/


    // $scope.searchBySpeciality

    /*************Search by Speciality function ***********/


});
/**************************************************end of controllers related to SEARCH RESULT page*********************************************************/
/**************************************************end of controllers related to SEARCH FILTER page*********************************************************/

(function(angular) {
  'use strict';
angular.module('anchorScrollExample', [])
  .controller('ScrollController', ['$scope', '$location', '$anchorScroll',
    function ($scope, $location, $anchorScroll) {
      $scope.gotoBottom = function() {
        // set the location.hash to the id of
        // the element you wish to scroll to.
        $location.hash('bottom');

        // call $anchorScroll()
        $anchorScroll();
      };
    }]);
});
	


/**************************************************end of controllers related to SEARCH FILTER page*********************************************************/
