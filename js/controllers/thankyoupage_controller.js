
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
	       })
	    
	    .error(function(data, status, headers, config) {
	          alert("Submitting form failed!");
	       });
		
	
	

});
