
/*
  ThankYouPage related controller 
*/
app.controller('ThankYouPage',function($scope,$routeParams,$rootScope,$http){
	$scope.ID = $routeParams.appID;
	$scope.ID2= $routeParams.docID;
	$scope.fetch_data_url= 'serverside/bookappointment/thankyou_DataFetch.php';
    
	var dataObject = {
				app_id:$scope.ID
				,doc_id : $scope.ID2
				};
	$http.post($scope.fetch_data_url,dataObject,{})
		.success(function(dataFromServer, status, headers, config) {
			  //alert("success");
			 // window.location.replace('#/thankyou');
	            console.log(dataFromServer);
				$scope.thankyoupageData=dataFromServer;
				//window.location.replace('#/thankyou/'+dataFromServer+'/'+doctor_id);
				//redirecttoThankYou(dataFromServer);
				
				var mapOptions = {
					zoom: 14,
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
						
						title: 'Dr. '+info.FirstName +' '+ info.LastName
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
				
				console.log($scope.thankyoupageData);
				
				for (i = 0; i < $scope.thankyoupageData.length; i++)
				{
					createMarker($scope.thankyoupageData[i]);
				}
				
				
	       })
	    
	    .error(function(data, status, headers, config) {
	          alert("Submitting form failed!");
	       });
		
	
	

});
