app.controller('patient_registration',function($scope,$rootScope,$http,$location){
	//alert($location.path());
	$scope.registration_url= 'serverside/registration/patient_registration.php';
	$scope.fbregistration_url= 'serverside/registration/fp_patient_registration.php';
	$scope.p_registrationform = {};
	
	//defining submit form function
	$scope.p_registrationform.submitForm=function(){
		console.log("Submitting the form");
		var dataObject = {
				fname : $scope.p_registrationform.fname
				,lname : $scope.p_registrationform.lname
				,mobile : $scope.p_registrationform.mobile
				,password : $scope.p_registrationform.password
		};
		console.log(dataObject);$http.post($scope.registration_url,dataObject,{})
		.success(function(dataFromServer, status, headers, config) {
			  //alert("success");
			  window.location.replace('#/mobile_verification');
	          console.log(dataFromServer);
	       })
	    
	    .error(function(data, status, headers, config) {
	          alert("Submitting form failed!");
	       });
		
		
	     }//submitForm function ends
	
	$scope.p_registrationform.submitForm_facebook=function(){
		console.log("Submitting the facebook form");
		var dataObject = {
				 mobile : $scope.p_registrationform.mobile
				,password : $scope.p_registrationform.password
		};
		console.log(dataObject);$http.post($scope.fbregistration_url,dataObject,{})
		.success(function(dataFromServer, status, headers, config) {
			  //alert("success");
			  //window.location.replace('#/mobile_verification');
	          console.log(dataFromServer);
	       })
	    
	    .error(function(data, status, headers, config) {
	          alert("Submitting form failed!");
	       });
		
		
	     }//submitForm function ends
	 
	
	$scope.OTPcheck=function(OTPcharacters){
	   	 
		//$scope.OTPcharacters=angular.copy(OTPcharacters);
		$scope.OTPmatch_status;
		$scope.check_otp_url='serverside/registration/checkOTP.php';
		$http.post($scope.check_otp_url,OTPcharacters,{})
		.success(function(dataFromServer,status,headers,config)
		{
			 console.log(dataFromServer);
		})
		
		.error(function(data,status,headers,config){
			
			
		});
	
		}//OTPcheck ends here
		
		$scope.OTPresend=function(){
		   	 
			//$scope.OTPcharacters=angular.copy(OTPcharacters);
			$scope.resend_otp_url='serverside/registration/ResendOTP.php';
			$http.post($scope.resend_otp_url)
			.success(function(dataFromServer,status,headers,config)
			{
				 console.log(dataFromServer);
			})
			
			.error(function(data,status,headers,config){
				
				
			});
		
		}//OTPresend end here
	 
	
	
});//patient_registration controller ends here