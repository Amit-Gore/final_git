
/*
 * Book appointment Related controller
 * Author:Amit Gore
 * */
app.controller('book_appointment',function($scope,$routeParams,$rootScope,$http){
	
	
	$scope.slot = $routeParams.slot;
	$scope.date=$routeParams.date;
	$scope.doc_id=$routeParams.doctor;
	$scope.slot_id=$routeParams.slotid;
	$scope.fetch_data_url= 'serverside/bookappointment/docdata_bookappointment_page.php';
	
	$http.post($scope.fetch_data_url,{"data" : $scope.doc_id}).
	success(function(data,status){
		//alert('success');
		$scope.status=status;
		$scope.doc_data = data;
				
		var mapOptions = {
					zoom: 12,
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
				
				console.log($scope.doc_data);
				
				for (i = 0; i < $scope.doc_data.length; i++)
				{
					createMarker($scope.doc_data[i]);
				}
				
				 $scope.map.fitBounds(bounds);
		
	}).
	error(function(data,status){
		alert('Failure');
		$scope.data = data||"Request failed";
		$scope.status = status;
	});
	
	/*
	 * Book appointment function definations
	 * 
	 * 
	 * */
	$scope.appointment_related = {};
	$scope.save_to_database_url='serverside/bookappointment/save_appointment.php';
	$scope.thankyou_page_data='serverside/bookappointment/thankyou_DataFetch.php';
	

	//defining submit form function
	$scope.appointment_related.submitForm=function(){
		console.log("Submitting the form");
		
		var dataObject = {
				patientname : $scope.appointment_related.patientname
				,Reason : $scope.appointment_related.Reason
				,app_date : $scope.date
				,slot : $scope.slot
				,slot_id:$scope.slot_id
				,doc_id : $scope.doc_id
				};
		var doctor_id= $scope.doc_id;
		console.log(dataObject);
		$scope.loading = true;	
		$http.post($scope.save_to_database_url,dataObject,{})
		.success(function(dataFromServer, status, headers, config) {
			  //alert("success");
			  window.location.replace('#/thankyou');
	            console.log(dataFromServer);
				window.location.replace('#/thankyou/'+dataFromServer+'/'+doctor_id);
				//redirecttoThankYou(dataFromServer);
				$scope.loading = false;
	       })
	    
	    .error(function(data, status, headers, config) {
	          alert("Submitting form failed!");
	       });
		
		
	     }//submitForm function ends
	
	

});
