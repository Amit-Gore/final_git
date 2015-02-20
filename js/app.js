
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
	.when("/new_user_doctor", {
		templateUrl: "webpage/login/Doctor_registration.html", 
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
		
		
		
		app.controller("DashboardCtrl", ["$scope","$http","$route", function($scope,$http,$route) {
			$scope.session_check_url= 'serverside/login/doctor/doctor_login_status.php';
			$scope.fetch_dashboard_info_url='serverside/dashboards/doctor_dashboard/dashboard_home_related/wrapperfile.php';
			$scope.approve_url='serverside/dashboards/doctor_dashboard/dashboard_home_related/approveAppointment.php';
			$scope.reject_url='serverside/dashboards/doctor_dashboard/dashboard_home_related/rejectAppointment.php';
			
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
			
			/*Author:Amit Gore
			 * Usage Reasoning: On doctor dashboard,
			 * 					doctor either confirms the appointment or reject the appointment
			 * */
			$scope.approveAppointment=function(id){
				var dataObject = {
						app_id : id
					};
				$http.post($scope.approve_url,dataObject,{})
				.success(function(dataFromServer, status, headers, config) {
					  //console.log(dataFromServer);
					  $route.reload();
			       })
			    
			    .error(function(data, status, headers, config) {
			          alert("failed to fetch data");
			       });
				
				
			     }//approveAppointment function ends
			
			
			
			
			/*Author:Amit Gore
			 * Usage Reasoning: On doctor dashboard,
			 * 					doctor either confirms the appointment or reject the appointment
			 * */
			$scope.rejectAppointment=function(id){
				var dataObject = {
						app_id : id
					};
				$http.post($scope.reject_url,dataObject,{})
				.success(function(dataFromServer, status, headers, config) {
					  console.log(dataFromServer);
					  $route.reload();
			       })
			    
			    .error(function(data, status, headers, config) {
			          alert("failed to fetch data");
			       });
				
				
			     }//rejectAppointment function ends
			
			
			
		}])	
			
			
			
		
		/************************************************************PRASHANT DASHBOARD CONTROLLERS (04 FEB 2015 )***********************************************************************/
		/************************************************************PRASHANT DASHBOARD CONTROLLERS (17 FEB 2015 )***********************************************************************/
		
			app.controller("Patient_DashboardCtrl",["$scope","$http","$route", function($scope,$http,$route){
				
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
		app.controller("patient_DashboardCtrl", ["$scope","$http","$route", function($scope,$http,$route) {
			$scope.session_check_url= 'serverside/login/login_status.php';
			$scope.cancel_url='serverside/dashboards/patient_dashboard/CancelAppointmentByPatient.php';
			$scope.fetch_dashboard_info_url='serverside/dashboards/patient_dashboard/WrapperPatientDashboard.php';
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
			 * Usage Reasoning: At patient dashboard,by calling this function dashboard gets the data to show
			 * */
			$scope.init=function(){
				var dataObject = {
					patient_id : $scope.user_session.patientID
				};
				$http.post($scope.fetch_dashboard_info_url,dataObject,{})
				.success(function(dataFromServer, status, headers, config) {
					  //window.location.replace('#/mobile_verification');
			          //console.log(dataFromServer);
			          $scope.dashboard_data=dataFromServer;
			          //console.log($scope.dashboard_data);
			       })
			    
			    .error(function(data, status, headers, config) {
			          alert("failed to fetch data");
			       });
				
				
			     }//init function ends
			
			
			/*Author:Amit Gore
			 * Usage Reasoning: On patient dashboard,
			 * 					patient might cancell the appointment
			 * */
			$scope.cancelAppointment=function(id){
				var dataObject = {
						app_id : id
					};
				$http.post($scope.cancel_url,dataObject,{})
				.success(function(dataFromServer, status, headers, config) {
					  console.log(dataFromServer);
					  $route.reload();
			       })
			    
			    .error(function(data, status, headers, config) {
			          alert("failed to fetch data");
			       });
				
				
			     }//rejectAppointment function ends
			
			
			
		}])	
		
		
		
		
		
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
			   var slots = 
				{
				slot1 : {
				from: $scope.myForm.mytime1,
				to: $scope.myForm.mytime2,
				avgTimePerPatient: $scope.myForm.selected1,
				location: $scope.myForm.selected2
				},
				
				slot2:{
				
				from: $scope.myForm.mytimefrom1,
				to: $scope.myForm.mytimeto1,
				avgTimePerPatient: $scope.myForm.selectedpatient1,
				location: $scope.myForm.selectedlocation1,
				
				},
				
				slot3:{
				
				from: $scope.myForm.mytimefrom2,
				to: $scope.myForm.mytimeto2,
				avgTimePerPatient: $scope.myForm.selectedpatient2,
				location: $scope.myForm.selectedlocation2,
				
				},
				
				slot4:{
				
				from: $scope.myForm.mytimefrom3,
				to: $scope.myForm.mytimeto3,
				avgTimePerPatient: $scope.myForm.selectedpatient3,
				location: $scope.myForm.selectedlocation3,
				
				},
				
				slot5:{
				
				from: $scope.myForm.mytimefrom4,
				to: $scope.myForm.mytimeto4,
				avgTimePerPatient: $scope.myForm.selectedpatient4,
				location: $scope.myForm.selectedlocation4,
				
				},
				
				slot6:{
				
				from: $scope.myForm.mytimefrom5,
				to: $scope.myForm.mytimeto5,
				avgTimePerPatient: $scope.myForm.selectedpatient5,
				location: $scope.myForm.selectedlocation5,
				
				},
				
				slot7:{
				
				from: $scope.myForm.mytimefrom6,
				to: $scope.myForm.mytimeto6,
				avgTimePerPatient: $scope.myForm.selectedpatient6,
				location: $scope.myForm.selectedlocation6,
				
				},
				
				slot8:{
				
				from: $scope.myForm.mytimefrom7,
				to: $scope.myForm.mytimeto7,
				avgTimePerPatient: $scope.myForm.selectedpatient7,
				location: $scope.myForm.selectedlocation7,
				
				},
				
				slot9:{
				
				from: $scope.myForm.mytimefrom8,
				to: $scope.myForm.mytimeto8,
				avgTimePerPatient: $scope.myForm.selectedpatient8,
				location: $scope.myForm.selectedlocation8,
				
				},
				
				slot10:{
				
				from: $scope.myForm.mytimefrom9,
				to: $scope.myForm.mytimeto9,
				avgTimePerPatient: $scope.myForm.selectedpatient9,
				location: $scope.myForm.selectedlocation9,
				
				}
				
				};
				console.log(slots);
				
				 var dataObject = {
				// Sch_date : $scope.myForm.Sch_date,
				
				slots1 : slots,	
				
				
				// slot_StartTime2: $scope.myForm.mytime3,
				// slot_EndTime2: $scope.myForm.mytime4,
				// slot_AvgPatientTime2: $scope.myForm.selected3,
				// slot_Location2: $scope.myForm.selected4,
				
				// slot_StartTime3: $scope.myForm.mytime5,
				// slot_EndTime3: $scope.myForm.mytime6,
				// slot_AvgPatientTime3: $scope.myForm.selected5,
				// slot_Location3: $scope.myForm.selected6,
				
				 RepeatDaily_StartDate : $scope.myForm.dt1,
				 RepeatDaily_EndDate : $scope.myForm.dt2,
				
				 RepeatWeekly_StartDate : $scope.myForm.dt3,
				 RepeatWeekly_Days : [$scope.myForm.sunday,$scope.myForm.monday,$scope.myForm.tuesday,$scope.myForm.wednesday,$scope.myForm.thursday,$scope.myForm.friday,$scope.myForm.satureday],
				 RepeatWeekly_EndDate : $scope.myForm.dt4,
				
				 Repeatmonthly_StartDate : $scope.myForm.dt5,
				 Repeatmonthly_Dates : [$scope.myForm.m1,$scope.myForm.m2,$scope.myForm.m3,$scope.myForm.m4,$scope.myForm.m5,$scope.myForm.m6,$scope.myForm.m7, $scope.myForm.m8,$scope.myForm.m9,$scope.myForm.m10,$scope.myForm.m11,$scope.myForm.m12,$scope.myForm.m13,$scope.myForm.m14, $scope.myForm.m15,$scope.myForm.m16,$scope.myForm.m17,$scope.myForm.m18,$scope.myForm.m19,$scope.myForm.m20,$scope.myForm.m21,  $scope.myForm.m22,$scope.myForm.m23,$scope.myForm.m24,$scope.myForm.m25,$scope.myForm.m26,$scope.myForm.m27,$scope.myForm.m28, $scope.myForm.m29,$scope.myForm.m30,$scope.myForm.m31],
				
				 Repeatmonthly_Days : [$scope.myForm.mo1,$scope.myForm.t1,$scope.myForm.w1,$scope.myForm.th1,$scope.myForm.f1,$scope.myForm.s1,$scope.myForm.sun1, $scope.myForm.mo2,$scope.myForm.t2,$scope.myForm.w2,$scope.myForm.th2,$scope.myForm.f2,$scope.myForm.s2,$scope.myForm.sun2, $scope.myForm.mo3,$scope.myForm.t3,$scope.myForm.w3,$scope.myForm.th3,$scope.myForm.f3,$scope.myForm.s3,$scope.myForm.sun3,  $scope.myForm.mo4,$scope.myForm.t4,$scope.myForm.w4,$scope.myForm.th4,$scope.myForm.f4,$scope.myForm.s4,$scope.myForm.sun4],
				
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
			angular.element(document.getElementById('space-for-buttons')).append($compile("<div><div class='panel-body' ><div class='row' ><div class='col-md-12'> <!-- profile panel --> <div class='panel panel-profile'> <div class='panel-heading text-center bg-default'> <br> <div class='row'> <p> Select Time Slot No "+scope.count+"  </p> <div class='col-md-6'> <p> From </p> <div data-ng-controller='TimepickerDemoCtrl'> <div  name='time3' style='display:inline-block;'> <input type='time' class='form-control' ng-model='myForm.mytimefrom"+scope.count+"' ng-required='true' > </div></div> </div> <div class='col-md-6'> <p> To </p> <div data-ng-controller='TimepickerDemoCtrl' > <div  name='time"+scope.count+"' style='display:inline-block;'> <input type='time' class='form-control' ng-model='myForm.mytimeto"+scope.count+"' ng-required='true' > </div> </div> </div> </div> <br> <br> <div class='row'> <div class='col-md-6'> <p> Average Time per Patients </p> <span class='ui-select' > <select class='form-control' required ng-model='myForm.selectedpatient"+scope.count+"'> <option> 10 Min </option> <option> 15 Min </option> <option> 20 Min </option> <option> 30 Min </option> <option> 60 Min </option> </select> </span> </div> <div class='col-md-6'> <p> Location </p> <span class='ui-select' > <select class='form-control' required ng-model='myForm.selectedlocation"+scope.count+"'> <option> Aundh </option> <option> Koregaon Park </option> </select> </span> </div> </div> </div> </div> ")
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
		



app.controller("doctor_registration",["$scope",function($scope){


	$scope.submitForm = function(){
	
	var doctor_data = {
	
		email : $scope.doctor_reg.email,
		firstname : $scope.doctor_reg.fname,
		lastname : $scope.doctor_reg.lname,
		gender : $scope.doctor_reg.gender,
		address : $scope.doctor_reg.address,
		about : $scope.doctor_reg.about,
		photo : $scope.doctor_reg.photo,
		contact_no : $scope.doctor_reg.contact,
		last_degree : $scope.doctor_reg.degree,
		speciality : $scope.doctor_reg.speciality,
		experience : $scope.doctor_reg.experience,
		fees : $scope.doctor_reg.fees
		
	
	};
	
	console.log(doctor_data);
		}

}]);		
		
		
  