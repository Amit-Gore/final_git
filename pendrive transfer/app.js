
 var app1 =  angular.module("app",[]); 
var app = angular.module('mainModule', ['ngRoute','ui.bootstrap','angularUtils.directives.dirPagination','ngAnimate']);
var myModule= angular.module('MyServiceModuleOne', ['app']);

/*********************************Services Written by Amit Gore****************************************/
app.factory('search_to_book', function() {
 var doc_data = {}
 function set(data) {
   doc_data = data;
 }
 function get() {
  return doc_data;
 }

 return {
  set: set,
  get: get
 }

});
/*app.factory('Auth', function(){
	var user;

	return{
	    setUser : function(aUser){
	        user = aUser;
	    },
	    isLoggedIn : function(){
	        return(user)? user : false;
	    }
	  }
	});
*/
/***********************************end of services*********************************************/

/*** Configure the Routes*/
app.config(['$routeProvider', function ($routeProvider) {
  $routeProvider
    // Home
	.when("/", {
		templateUrl: "webpage/index.html", 
		controller: "PageCtrl"})
    .when("/search/:param1-:param11", {
    	templateUrl: "webpage/search.html", 
    	controller: "doctor_search"
    		})
    .when("/book_appointment/:date/:doctor/:slot/:slotid/", {
    	templateUrl: "webpage/docPrimaryInfo.html", 
    	controller: "book_appointment"
    		})
    .when("/mobile_verification", {
    	templateUrl: "webpage/login/mobile.html", 
    	controller: "patient_registration"
    		})
	.when("/primary_info", {
		templateUrl: "webpage/docPrimaryInfo.html", 
		controller: "PageCtrl"})
    // login Pages
	.when("/new_user", {
		templateUrl: "webpage/login/new_user.html", 
		controller: "PageCtrl"})
	.when("/mobilenumber", {
		templateUrl: "webpage/Registration/MobileUpdate.html", 
		controller: "patient_registration"})	
	.when("/patient", {
		templateUrl: "webpage/login/patient.html",
		controller: "login"})
	.when("/patientlogout", {
		templateUrl: "webpage/index.html",
		controller: "login"})	
	.when("/doctor", {
		templateUrl: "webpage/login/doctor.html",
		controller: "PageCtrl"})
	.when("/forgotp", {
		templateUrl: "webpage/login/forgotp.html",
		controller: "PageCtrl"})
	.when("/morelocation", {
		templateUrl: "webpage/more/morelocation.html",
		controller: "BlogCtrl"})
	.when("/morespeciality", {
		templateUrl: "webpage/more/morespeciality.html",
		controller: "BlogCtrl"})
	.when("/moreclinic", {
		templateUrl: "webpage/more/moreclinic.html",
		controller: "BlogCtrl"})
	.when("/DoctDashBoard", {
		templateUrl: "views/dashboard.html",
		controller: "BlogCtrl"})
	.when("/Sch", {
		templateUrl: "webpage/Schedule.html",
		controller: "BlogCtrl"})
	.when("/preview", {
		templateUrl: "webpage/priview.html",
		controller: "BlogCtrl"})
	// .when("/thankyou", {
		// templateUrl: "webpage/thankyou.html",
		// controller: "BlogCtrl"})
	.when("/patientDashboard", {
		templateUrl: "webpage/patient.html",
		controller: "BlogCtrl"})
	
	
	 .when("/thankyou/:appID/:docID", {
    	 templateUrl: "webpage/thankyou.html", 
    	 controller: "ThankYouPage"
    	 })	
		
	
	//.when("/primary_info", {templateUrl: "webpage/about.html", controller: "PageCtrl"})
    .when("/about", {templateUrl: "webpage/about.html", controller: "PageCtrl"})
    .when("/faq", {templateUrl: "webpage/faq.html", controller: "PageCtrl"})
    .when("/pricing", {templateUrl: "webpage/pricing.html", controller: "PageCtrl"})
    .when("/services", {templateUrl: "webpage/services.html", controller: "PageCtrl"})
    .when("/contact", {templateUrl: "webpage/contact.html", controller: "PageCtrl"})
    // Blog
    .when("/blog", {templateUrl: "webpage/blog.html", controller: "BlogCtrl"})
    .when("/blog/post", {templateUrl: "webpage/blog_item.html", controller: "BlogCtrl"})
    // else 404
    .otherwise("/404", {templateUrl: "webpage/404.html", controller: "PageCtrl"});
}]);


/* The below method was used to test the login authentication method from stack-overflow,so 
 * commented to keep the reference (31-jan)
 * created a service (Auth) which will handle the user object and have a method to know if the user is logged or not.
 * */

/*app.run(['$rootScope', '$location','login', function ($rootScope, $location, Auth) {
    $rootScope.$on('$routeChangeStart', function (event) {

        if (1) {
            console.log('DENY');
        }
        else {
            console.log('ALLOW');
        }
    });
}]);
*/



/**
 * Controls the Blog
 */
app.controller('BlogCtrl', function (/* $scope, $location, $http */) {
  console.log("Blog Controller reporting for duty.");
});

/**
 * Controls all other Pages
 */
app.controller('PageCtrl', function ( $scope, $location, $http, $routeParams ) {
	console.log("Page Controller reporting for duty.");

  // Activates the Carousel
  $('.carousel').carousel({
    interval: 5000
  });

  // Activates Tooltips for Social Links
  $('.tooltip-social').tooltip({
    selector: "a[data-toggle=tooltip]"
  })
});



/*Author:Amit Gore
 * On every accessable page for'patient',we have included this mainController
 * So to check whether patient is logged in or not is being handled within this controller  
 * 
 * */
app.controller('mainController', function($scope,$http) {
  
  // set the default states for lions and cranes
  $scope.lions = false;
  $scope.cranes = false;
  $scope.session_check_url= 'serverside/login/login_status.php';
	
	$http.post($scope.session_check_url)
	
			.success(function(dataFromServer,status,headers,config)
					{
						 console.log(dataFromServer);
						 $scope.user_session=dataFromServer;
						 if(!($scope.user_session))
							 {
							 console.log("not logged in-maincontroller");
							 }
						 //Auth.setUser(dataFromServer);
					})
			
			.error(function(data,status,headers,config){
				
				alert('failure in ajax request:login status check');
				
			});
  
  
});

app.controller('session_protected_page',function($scope,$rootScope,$location,$http){

$rootScope.referrar_url=$location.path();
$scope.session_check_url= 'serverside/login/login_status.php';
	
	$http.post($scope.session_check_url)
	
			.success(function(dataFromServer,status,headers,config)
					{
						 console.log(dataFromServer);
						 $scope.user_session=dataFromServer;
						 if(!($scope.user_session))
							 {
							 alert("not logged in-session_protected controller");
							 //window.location.replace('#/patient:'+$location.path());
							 window.location.replace('#/patient');
							 }
						 //Auth.setUser(dataFromServer);
					})
			
			.error(function(data,status,headers,config){
				
				alert('failure in ajax request:login status check');
				
			});
  
	
});


/*----------------------------------------------CONTROLLERS WRITTEN BY AMIT GORE--------------------------------------------------------------------*/

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




/**************************************************CONTROLLERS RELATED TO SEARCH RESULT PAGE*********************************************************/
app.controller('doctor_search',function($scope,$routeParams,$rootScope,$http,$location){
	
	var doc_name = $routeParams.param11;
	
	$scope.url= 'serverside/search/search_result.php'; // The url of php file which is intended to populate $scope with the help of AJAX call
	
	 var search_by_url=function(doc_name){
		    //Creating the http post request here
			$http.post($scope.url,{"data" : doc_name}).
			success(function(data,status){
				//alert('success');
				$scope.status=status;
				$rootScope.cards = data;
				$scope.result= data;
				
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
			error(function(data,status){
				alert('Failure');
				$scope.data = data||"Request failed";
				$scope.status = status;
			});
		 }
	if(doc_name) //if there is a parameter in the url,which would be doctor name
		{
		$scope.keywords=doc_name;
		search_by_url(doc_name);   //call the function 
		//need to implement logic for this,calling the result two times
			
		}
	
	$scope.search = function(){
		//Creating the http post request here
		$http.post($scope.url,{"data" : $scope.keywords}).
		success(function(data,status){
			//alert('success');
			$scope.status=status;
			$rootScope.cards = data;
			$scope.result= data;
			//console.log($scope.data);
			
			window.location.replace('#/search/docname-'+$scope.keywords);
			//window.location.replace('#/search');
			//$location.path('#/search');
			
	

			
			
		}).
		error(function(data,status){
			alert('Failure');
			$scope.data = data||"Request failed";
			$scope.status = status;
		});
	}
	
	
	$scope.show_calandar = function(doc_id){
		$scope.url='serverside/search/search_result_calandar.php';
	    //alert(doc_id);
		//Creating the http post request here
		 $scope.loading = true;
		$http.post($scope.url,{"data" :doc_id}).
		success(function(data,status){
			// alert('success');
			var chutiya = doc_id;
			$scope.status=status;
			$scope.slots=data;//check this and if not done upload files and send the link to abhishek
			//$scope.slots.splice(1,0,doc_id);
			$scope.result= data;
			 $scope.loading = false;
		}).
		error(function(data,status){
			alert('Failure');
			$scope.data = data||"Request failed";
			$scope.status = status;
		});
	}
	
	
	
	
});
/**************************************************end of controllers related to SEARCH RESULT page*********************************************************/
/**************************************************end of controllers related to SEARCH FILTER page*********************************************************/



/**************************************************end of controllers related to SEARCH FILTER page*********************************************************/


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
		$http.post($scope.save_to_database_url,dataObject,{})
		.success(function(dataFromServer, status, headers, config) {
			  //alert("success");
			 // window.location.replace('#/thankyou');
	            console.log(dataFromServer);
				window.location.replace('#/thankyou/'+dataFromServer+'/'+doctor_id);
				//redirecttoThankYou(dataFromServer);
	       })
	    
	    .error(function(data, status, headers, config) {
	          alert("Submitting form failed!");
	       });
		
		
	     }//submitForm function ends
	
	

});


/*------------------------------------------------end of controllers WRITTEN BY AMIT GORE----------------------------------------------------------------*/




// form validations

app.controller('formValidation', function($scope) {

	// function to submit the form after all validation has occurred			
	$scope.submitForm = function(isValid) {

		// check to make sure the form is completely valid
		if (isValid) { 
			alert('our form is amazing');
		}

	};

});

// logform

app.controller('FormCtrl', ['$scope', function($scope) {
  // hide error messages until 'submit' event
  $scope.submitted = false;
  // hide success message
  $scope.showMessage = false;
  // method called from shakeThat directive
  $scope.submit = function() {
    // show success message
    $scope.showMessage = true;
  };
}])

app.directive('shakeThat', ['$animate', function($animate) {

  return {
    require: '^form',
    scope: {
      submit: '&',
      submitted: '='
    },
    link: function(scope, element, attrs, form) {
      // listen on submit event
      element.on('submit', function() {
        // tell angular to update scope
        scope.$apply(function() {
          // everything ok -> call submit fn from controller
          if (form.$valid) return scope.submit();
          // show error messages on submit
          scope.submitted = true;
          // shake that form
          $animate.addClass(element, 'shake', function() {
            $animate.removeClass(element, 'shake');
          });
        });
      });
    }
  };

}]);






app.controller('staticpages',function($scope){
	
	$scope.static_page = [
	{
	'images' : 	'images/marker-48.png',
	'titles' : 	' Location',
	'detail' :  ['Aundh','Baner','Shivaji nagar','Pashan','Sinhgad Road','Narhe','Kothrud','Alandi','Pimple Saudaghar'],
	'more':'morelocation'
	},
	{
	'images' : 	'images/tag-48.png',
	'titles' : 	' Speciality',
	'detail' :  ['Endocrinology','Diebetology','Nephrology','Urology','Joint replacement','Spine Surgery','Rheumatology','Neurology','Paed. Neurology'],
	
	'more':'morespeciality'
	},
	{
	'images' : 	'images/hospital-48.png',
	'titles' : 	' Clinic',
	'detail' :  ['HealthServe Community Clinic','Aditya Birla Clinic','Noble Hospital','Ruby Hall Clinic','Jehangir Hospital','Apollo Hospital','Deenanath Mangeshkar Hospital','Sancheti Hospital','Karve Childrens Hospital'],
	'more':'moreclinic'
	}];
	

});

// for static pages
app.controller('speciality',function($scope,$filter){

	$scope.specialitys = ['Endocrinology','Diebetology','Nephrology','Urology','Joint replacement','Spine Surgery','Rheumatology','Neurology','Paed. Neurology','Neuro Surgery','Cardiology','Cardiac Surgery','Oncology','Onco Surgery','Dermatology','Maxillo Facial Surgeon','Retina Surgeon','Gastroenterology','Gastro. Surgeon','Heamatology','Hapatologist','Barriatric Surgery','Orthodontist','Vascular Surgery','Endoscopic Surgery']
	;

});

app.controller('location',function($scope,$filter){

	$scope.locations = 
		  ['Aundh','Alandi','Akhurdi','Ambegoan','Baner','Balewadi','Bavdhan','Chandani Chawk','Kothrud','Karve Road','Nal Stop','Ganesh Nager','Sinhgad Road','Vadgoan','Anand Nagar','Swargate','Camp','Koregoan Park','Viman Nagar','Shaniwar Wada','Deccan']
	;

});

app.controller('clinic',function($scope,$filter){

	$scope.clinic =  ['HealthServe Community Clinic','Aditya Birla Clinic','Noble Hospital','Ruby Hall Clinic','Jehangir Hospital','Apollo Hospital','Deenanath Mangeshkar Hospital','Sancheti Hospital','Karve Childrens Hospital']	;

});

app.filter('mySort', function() {
    return function(input) {
      return input.sort();
    }
  });

  
  
 /***************HEADER CONTROLLERS (PRASHANT)*******************/
		app.controller("header",["$scope",function($scope){
			$scope.unread_messages = "2";
			$scope.unread_mails = "5";
			$scope.unread_notifications = "5";
			$scope.username = "HealthServe";
			
		}])
		
		/***************HEADER CONTROLLERS (PRASHANT)*******************/
		
		
		
		app.controller("NavCtrl", ["$scope", "taskStorage", "filterFilter", function($scope, taskStorage, filterFilter) {
            var tasks;
            return tasks = $scope.tasks = taskStorage.get(), $scope.taskRemainingCount = filterFilter(tasks, {
                completed: !1
            }).length, $scope.$on("taskRemaining:changed", function(event, count) {
                return $scope.taskRemainingCount = count
            })
        }])
		/************************************************************PRASHANT DASHBOARD CONTROLLERS (04 FEB 2015 )***********************************************************************/
		
		
		
		app.controller("DashboardCtrl", ["$scope","$http", function($scope,$http) {
			$scope.session_check_url= 'serverside/login/doctor/doctor_login_status.php';
			$scope.fetch_dashboard_info_url='serverside/dashboards/doctor_dashboard/dashboard_home_related/wrapperfile.php';
			
			
			$http.post($scope.session_check_url)
			
					.success(function(dataFromServer,status,headers,config)
							{
								 console.log(dataFromServer);
								 $scope.user_session=dataFromServer;
								 $scope.init();
								 if(!($scope.user_session))
									 {
									 alert("not logged in");
									 
									 }
								 //Auth.setUser(dataFromServer);
							})
					
					.error(function(data,status,headers,config){
						
						alert('failure in ajax request:login status check');
						
					});
		

			/*Author:Amit Gore
			 * Usage Reasoning: At doctor dashboard,by calling this function dashboard gets the data to show
			 * 					(basically to initialize the dashboard with data like : Appointments for today etc)
			 * */
			$scope.init=function(){
				var dataObject = {
					doc_id : $scope.user_session.doctorID
				};
				$http.post($scope.fetch_dashboard_info_url,dataObject,{})
				.success(function(dataFromServer, status, headers, config) {
					  //window.location.replace('#/mobile_verification');
			          console.log(dataFromServer);
			          $scope.dashboard_data=dataFromServer;
			          console.log($scope.dashboard_data);
			       })
			    
			    .error(function(data, status, headers, config) {
			          alert("failed to fetch data");
			       });
				
				
			     }//init function ends
			
		}])	
			
			
			
		
		/************************************************************PRASHANT DASHBOARD CONTROLLERS (04 FEB 2015 )***********************************************************************/
		/************************************************************PRASHANT DASHBOARD CONTROLLERS (17 FEB 2015 )***********************************************************************/
		
			app.controller("patient_DashboardCtrl",["$scope", function($scope){
				
				$scope.Fname ='Amit';
				$scope.Lname='Gore',
				
				$scope.p_details=[
				{
					'doc_name': ' Sujit Jagtap',
					'A_date': '17- Feb, 2015',
					'A_time' : '1:00 - 3:00',
					'A_reason': 'Personal'	
				},
				{
					'doc_name': ' varsha Jagtap',
					'A_date': '18- Feb, 2015',
					'A_time' : '1:00 - 3:00',
					'A_reason': 'Personal'	
				}
				]
				
			}]);	
		
		
		
		
		
		/************************************************************PRASHANT DASHBOARD CONTROLLERS (17 FEB 2015 )***********************************************************************/
				
		/************************************************************PRASHANT DASHBOARD REQUESTS CONTROLLERS (04 FEB 2015 )***********************************************************************/
		app.controller("patient_request",["$scope", function($scope){
			$scope.requestedP_name="Patient Name";
			$scope.requestedP_date="26 jan 2015";
			$scope.requestedP_time="1:00 - 2:00 PM";
			$scope.requestedP_reason="Stress ";
			
		}])
		
		
		/************************************************************PRASHANT DASHBOARD REQUESTS CONTROLLERS (04 FEB 2015 )***********************************************************************/
		
		
		app.controller("DatepickerDemoCtrl", ["$scope", function($scope) {
            return $scope.today = function() {
                return $scope.dt = new Date
            }, $scope.today(), $scope.showWeeks = !0, $scope.toggleWeeks = function() {
                return $scope.showWeeks = !$scope.showWeeks
            }, $scope.clear = function() {
                return $scope.dt = null
            }, $scope.disabled = function(date, mode) {
                return "day" === mode && (-1 === date.getDay() || 7 === date.getDay())
            }, $scope.toggleMin = function() {
                var _ref;
                return $scope.minDate = null != (_ref = $scope.minDate) ? _ref : {
                    "null": new Date
                }
            }, $scope.toggleMin(), $scope.open = function($event) {
                return $event.preventDefault(), $event.stopPropagation(), $scope.opened = !0
            }, $scope.dateOptions = {
                "year-format": "'yy'",
                "starting-day": 1
            }, $scope.formats = ["dd-MMMM-yyyy", "yyyy/MM/dd", "shortDate"], $scope.format = $scope.formats[0]
        }])
		/**************Time picker controller*****************/	
		app.controller("TimepickerDemoCtrl", ["$scope", function($scope) {
            return $scope.mytime = new Date, $scope.hstep = 1, $scope.mstep = 15, $scope.options = {
                hstep: [1, 2, 3],
                mstep: [1, 5, 10, 15, 25, 30]
            }, $scope.ismeridian = !0, $scope.toggleMode = function() {
                return $scope.ismeridian = !$scope.ismeridian
            }, $scope.update = function() {
                var d;
                return d = new Date, d.setHours(14), d.setMinutes(0), $scope.mytime = d
            }, $scope.changed = function() {
                return console.log("Time changed to: " + $scope.mytime)
            }, $scope.clear = function() {
                return $scope.mytime = null
            }
        }])
		/**************Time picker controller*****************/	
		
		app.controller("CollapseDemoCtrl", ["$scope", function($scope) {
            return $scope.isCollapsed = !1}])
		/**********************Go Easy***********************************/
		
		
		// app.service('schedule',['$scope', function($scope){
			// $scope.setSchedule = function(a)
			// {
				// return data;
			// };
			
		// ]});
		
		
		
		
		
		/**********************Go Easy***********************************/
		app.controller('validateCtrl',["$scope", function($scope){
			$scope.count = 0;
			
			$scope.submit=function(){
				console.log("inside form");
				// var Weekly_CheckBoxes = {;$scope.myForm.sunday,};
				var dataObject = {
				Sch_date : $scope.myForm.Sch_date,
				slot_StartTime1: $scope.myForm.mytime1,
				slot_EndTime1: $scope.myForm.mytime2,
				slot_AvgPatientTime1: $scope.myForm.selected1,
				slot_Location1: $scope.myForm.selected2,
				
				slot_StartTime2: $scope.myForm.mytime3,
				slot_EndTime2: $scope.myForm.mytime4,
				slot_AvgPatientTime2: $scope.myForm.selected3,
				slot_Location2: $scope.myForm.selected4,
				
				slot_StartTime3: $scope.myForm.mytime5,
				slot_EndTime3: $scope.myForm.mytime6,
				slot_AvgPatientTime3: $scope.myForm.selected5,
				slot_Location3: $scope.myForm.selected6,
				
				RepeatDaily_StartDate : $scope.myForm.dt1,
				RepeatDaily_EndDate : $scope.myForm.dt2,
				
				RepeatWeekly_StartDate : $scope.myForm.dt3,
				RepeatWeekly_Days : [$scope.myForm.sunday,$scope.myForm.monday,$scope.myForm.tuesday,$scope.myForm.wednesday,$scope.myForm.thursday,$scope.myForm.friday,$scope.myForm.satureday],
				RepeatWeekly_EndDate : $scope.myForm.dt4,
				
				Repeatmonthly_StartDate : $scope.myForm.dt5,
				Repeatmonthly_Day : [$scope.myForm.m1,$scope.myForm.m2,$scope.myForm.m3,$scope.myForm.m4,$scope.myForm.m5,$scope.myForm.m6,$scope.myForm.m7, $scope.myForm.m8,$scope.myForm.m9,$scope.myForm.m10,$scope.myForm.m11,$scope.myForm.m12,$scope.myForm.m13,$scope.myForm.m14, $scope.myForm.m15,$scope.myForm.m16,$scope.myForm.m17,$scope.myForm.m18,$scope.myForm.m19,$scope.myForm.m20,$scope.myForm.m21,  $scope.myForm.m22,$scope.myForm.m23,$scope.myForm.m24,$scope.myForm.m25,$scope.myForm.m26,$scope.myForm.m27,$scope.myForm.m28, $scope.myForm.m29,$scope.myForm.m30,$scope.myForm.m31],
				Repeatmonthly_EndDate : $scope.myForm.dt6
				
				};
				console.log(dataObject);
			}
			
		}])

//Directive that returns an element which adds buttons on click which show an alert on click
app.directive("addbuttonsbutton", function(){
	return {
		restrict: "E",
		template: "<div style='text-align:center;'><a class='btn btn-primary btn-circle' addbuttons ><i tooltip-placement='top' tooltip='Add Another Slot' tooltip-append-to-body='true' class='fa fa-plus fa-2x'> </i></a> </div><br>"
	}
});

//Directive for adding buttons on click that show an alert on click
app.directive("addbuttons", function($compile){
	return function(scope, element, attrs){
		element.bind("click", function(){
			scope.count++;
			angular.element(document.getElementById('space-for-buttons')).append($compile("<div><div class='panel-body' ><div class='row' ><div class='col-md-12'> <!-- profile panel --> <div class='panel panel-profile'> <div class='panel-heading text-center bg-default'> <br> <div class='row'> <p> Select Time Slot No "+scope.count+"  </p> <div class='col-md-6'> <p> From </p> <div data-ng-controller='TimepickerDemoCtrl'> <div  name='time3' style='display:inline-block;'> <input type='time' class='form-control' ng-model='myForm.mytimefrom"+scope.count+"' ng-required='true' > </div></div> </div> <div class='col-md-6'> <p> To </p> <div data-ng-controller='TimepickerDemoCtrl' > <div  name='time"+scope.count+"' style='display:inline-block;'> <input type='time' class='form-control' ng-model='myForm.mytimeto"+scope.count+"' ng-required='true' > </div> </div> </div> </div> <br> <br> <div class='row'> <div class='col-md-6'> <p> Average Time per Patients </p> <span class='ui-select' > <select required ng-model='myForm.selectedpatient"+scope.count+"'> <option> 10 Min </option> <option> 15 Min </option> <option> 20 Min </option> <option> 30 Min </option> <option> 60 Min </option> </select> </span> </div> <div class='col-md-6'> <p> Location </p> <span class='ui-select' > <select required ng-model='myForm.selectedlocation"+scope.count+"'> <option> Aundh </option> <option> Koregaon Park </option> </select> </span> </div> </div> </div> </div> ")
		(scope));
		});
	};
});

app.directive('loading', function () {
      return {
        restrict: 'E',
        replace:true,
        template: '<div style="margin:30px;" ><img src="images/loader.GIF" />LOADING...</div>',
        link: function (scope, element, attr) {
              scope.$watch('loading', function (val) {
                  if (val)
                      $(element).show();
                  else
                      $(element).hide();
              });
        }
      }
  })		
		
		
		
		
  