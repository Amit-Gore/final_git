/**************************************************CONTROLLERS RELATED TO SEARCH RESULT PAGE*********************************************************/

			app.filter('startFrom', function() {
				return function(input, start) {
					if(input) {
						start = +start; //parse to int
						return input.slice(start);
					}
					return [];
				}
			});


app.controller('doctor_search', function($scope, $routeParams, $rootScope, $http, $location,filterFilter) {

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
			
			
			
			
			$scope.currentPage = 1; //current page
			$scope.maxSize = 5; //pagination max size
			$scope.entryLimit = 5; //max rows for data table

			/* init pagination with $scope.list */
			$scope.noOfPages = Math.ceil($rootScope.cards.length/$scope.entryLimit);
			
			$scope.$watch('search', function(term) {
				// Create $scope.filtered and then calculat $scope.noOfPages, no racing!
				$scope.filtered = filterFilter($rootScope.cards, term);
				$scope.noOfPages = Math.ceil($scope.filtered.length/$scope.entryLimit);
			});
			
			
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
						
						title: 'Dr. '+info.FirstName+' '+info.LastName
					});
					marker.content = '<div class="infoWindowContent">' + info.address + '</div>';
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
						
				
			
			
			
			/******************* Filters *****************************/
			
			
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
				
				
				$scope.filterOver = function (a) {
					return $scope.filter[a.area]|| $scope.filter[a.speciality] || noFilter($scope.filter);
				};
				
				
				function noFilter(filterObj) {
					for (var key in filterObj) {
						if (filterObj[key]) {
							return false;
						}
					}
					return true;
				} 

			/******************* Filters *****************************/
			
			
			
			
			
			
		
			


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

// (function(angular) {
  // 'use strict';
// angular.module('anchorScrollExample', [])
  // .controller('ScrollController', ['$scope', '$location', '$anchorScroll',
    // function ($scope, $location, $anchorScroll) {
      // $scope.gotoBottom = function() {
        // // set the location.hash to the id of
        // // the element you wish to scroll to.
        // $location.hash('bottom');

        // // call $anchorScroll()
        // $anchorScroll();
      // };
    // }]);
// });
	
 

// app.run(['$anchorScroll', function($anchorScroll) {
  // $anchorScroll.yOffset = 150;   // always scroll by 50 extra pixels
// }])
app.controller('headerCtrl', ['$anchorScroll', '$location', '$scope',
  function ($anchorScroll, $location, $scope) {
    $scope.gotoAnchor = function(x) {
      var newHash = 'anchor' + x;
      if ($location.hash() !== newHash) {
        // set the $location.hash to `newHash` and
        // $anchorScroll will automatically scroll to it
        $location.hash('anchor' + x);
      } else {
        // call $anchorScroll() explicitly,
        // since $location.hash hasn't changed
        $anchorScroll();
      }
    };
  }
]);
 
 
 
/**************************************************end of controllers related to SEARCH FILTER page*********************************************************/
function iframe($scope, $timeout) {
    $scope.frameName = 'foo';
    $scope.frameUrl = 'test1.html';
    
    // The timeout is here to be sure that the DOM is fully loaded.
    // This is a dirty-as-hell example, please use a directive in a real application.
    $timeout(function () { console.log(window.frames.foo); }, 1000);
}

angular.module('anchorScrollOffsetExample', [])
.run(['$anchorScroll', function($anchorScroll) {
  $anchorScroll.yOffset = 50;   // always scroll by 50 extra pixels
}])
.controller('headerCtrl', ['$anchorScroll', '$location', '$scope',
  function ($anchorScroll, $location, $scope) {
    $scope.gotoAnchor = function(x) {
      var newHash = 'anchor' + x;
      if ($location.hash() !== newHash) {
        // set the $location.hash to `newHash` and
        // $anchorScroll will automatically scroll to it
        $location.hash('anchor' + x);
      } else {
        // call $anchorScroll() explicitly,
        // since $location.hash hasn't changed
        $anchorScroll();
      }
    };
  }
]);