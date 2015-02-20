/*
 * Login Related controller
 * Author:Amit Gore
 * */
/*
 * The below controller was used to test the login authentication method from stack-overflow,so 
 * commented to keep the reference 
 * app.controller('mainCtrl', ['$scope', 'Auth', '$location', function ($scope, Auth, $location) {

	  $scope.$watch(Auth.isLoggedIn, function (value, oldValue) {

	    if(!value && oldValue) {
	      console.log("Disconnect");
	      $location.path('/login');
	    }

	    if(value) {
	      console.log("Connect");
	      //Do something when the user is connected
	    }

	  }, true);
}]);*/

app.controller('login',function($scope,$routeParams,$rootScope,$http){ //function as a dependency for login controller here
	
	/*$scope.check_session=function(){
	   	
		$scope.session_check_url= 'serverside/login/login_status.php';
		
		$http.post($scope.session_check_url)
		
				.success(function(dataFromServer,status,headers,config)
						{
							 console.log(dataFromServer);
							 return dataFromServer;
							 
							 //Auth.setUser(dataFromServer);
						})
				
				.error(function(data,status,headers,config){
					
					alert('failure in ajax request:login status check');
					return false;
				});
		return false;
	
		}//check_session function ends here
*/	
$scope.doctorlogin=function(){
		
	   	var dataObject={
	   			username:$scope.doc.email
	   		   ,password:$scope.doc.password	
	   	};
	   	
		$scope.login_check_url= 'serverside/login/doctor/doctor_login_check.php';
		//$rootScope.referrar_url;
		$http.post($scope.login_check_url, dataObject,{})
		
				.success(function(dataFromServer,status,headers,config)
						{
							 console.log(dataFromServer);
							 if(dataFromServer=="1")
								 {
								 //alert("true");
								 window.location.replace('#/DoctDashBoard');
								 }
							 else alert("false");
					   	})
				
				.error(function(data,status,headers,config){
					
					
				});
	
		}//doctorlogin function ends here
	
	

	
$scope.patientlogout=function(){
		
		$scope.logout_url='serverside/login/logout.php';
		$http.post($scope.logout_url)
		
				.success(function(dataFromServer,status,headers,config)
						{
							 console.log(dataFromServer);
							 //Auth.setUser(dataFromServer);
							 window.location.reload();
						})
				
				.error(function(data,status,headers,config){
					
					
				});
	
		}//patientlogout function ends here
	
	
	$scope.patientlogin=function(){
		
	   	var dataObject={
	   			username:$scope.credentials.username
	   		   ,password:$scope.credentials.password	
	   	};
	   	
		$scope.login_check_url= 'serverside/login/usercheck.php';
		//$rootScope.referrar_url;
		$http.post($scope.login_check_url, dataObject,{})
		
				.success(function(dataFromServer,status,headers,config)
						{
							 console.log(dataFromServer);
							 //Auth.setUser(dataFromServer);
							 if(!($rootScope.referrar_url))
								 {
								 window.location.replace('#/');
								 }
							 else
								 {
							 window.location.replace('#'+$rootScope.referrar_url);
								 }
						})
				
				.error(function(data,status,headers,config){
					
					
				});
	
		}//patientlogin function ends here

});