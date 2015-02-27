app.controller('ScheduleForm', function($scope, $http, $window) {
    $scope.count = 0;
    $scope.schedule_form_url = "serverside/dashboards/doctor_dashboard/schedule_related/store_schedule.php";
    $scope.validate_slot_time_url="serverside/dashboards/doctor_dashboard/schedule_related/validate_slot_time.php";
    //$scope.scheduleForm.repeatType;
    $scope.validation_bool=1;
   
    $scope.submit = function() {
        
    	var type=$scope.myForm.type;
        // var Weekly_CheckBoxes = {;$scope.myForm.sunday,};
        var dataObject = {
            slots: {
                slot1: {

                    from: $scope.myForm.mytime1,
                    to: $scope.myForm.mytime2,
                    avgTimePerPatient: $scope.myForm.selected1,
                    location: $scope.myForm.selected2
                },

                slot2: {

                    from: $scope.myForm.mytimefrom1,
                    to: $scope.myForm.mytimeto1,
                    avgTimePerPatient: $scope.myForm.selectedpatient1,
                    location: $scope.myForm.selectedlocation1,

                },

                slot3: {

                    from: $scope.myForm.mytimefrom2,
                    to: $scope.myForm.mytimeto2,
                    avgTimePerPatient: $scope.myForm.selectedpatient2,
                    location: $scope.myForm.selectedlocation2,

                },

                slot4: {

                    from: $scope.myForm.mytimefrom3,
                    to: $scope.myForm.mytimeto3,
                    avgTimePerPatient: $scope.myForm.selectedpatient3,
                    location: $scope.myForm.selectedlocation3,

                },

                slot5: {

                    from: $scope.myForm.mytimefrom4,
                    to: $scope.myForm.mytimeto4,
                    avgTimePerPatient: $scope.myForm.selectedpatient4,
                    location: $scope.myForm.selectedlocation4,

                },

                slot6: {

                    from: $scope.myForm.mytimefrom5,
                    to: $scope.myForm.mytimeto5,
                    avgTimePerPatient: $scope.myForm.selectedpatient5,
                    location: $scope.myForm.selectedlocation5,

                },

                slot7: {

                    from: $scope.myForm.mytimefrom6,
                    to: $scope.myForm.mytimeto6,
                    avgTimePerPatient: $scope.myForm.selectedpatient6,
                    location: $scope.myForm.selectedlocation6,

                },

                slot8: {

                    from: $scope.myForm.mytimefrom7,
                    to: $scope.myForm.mytimeto7,
                    avgTimePerPatient: $scope.myForm.selectedpatient7,
                    location: $scope.myForm.selectedlocation7,

                },

                slot9: {

                    from: $scope.myForm.mytimefrom8,
                    to: $scope.myForm.mytimeto8,
                    avgTimePerPatient: $scope.myForm.selectedpatient8,
                    location: $scope.myForm.selectedlocation8,

                },

                slot10: {

                    from: $scope.myForm.mytimefrom9,
                    to: $scope.myForm.mytimeto9,
                    avgTimePerPatient: $scope.myForm.selectedpatient9,
                    location: $scope.myForm.selectedlocation9,

                }
            },
            TriggerringDate: $scope.myForm.Sch_date,
            repeat: [
				{
				//type:$scope.scheduleForm.repeatType,
                //type: 'w',
                from_d: $scope.scheduleForm.dt1,
                to_d: $scope.scheduleForm.dt2,
                from_w: $scope.scheduleForm.dt3,
                to_w: $scope.scheduleForm.dt4,
                from_m: $scope.scheduleForm.dt5,
                to_m: $scope.scheduleForm.dt6,
                w_days : [$scope.scheduleForm.sunday,$scope.scheduleForm.monday,$scope.scheduleForm.tuesday,$scope.scheduleForm.wednesday,$scope.scheduleForm.thursday,$scope.scheduleForm.friday,$scope.scheduleForm.satureday],
				m_dates : [$scope.scheduleForm.m1,$scope.scheduleForm.m2,$scope.scheduleForm.m3,$scope.scheduleForm.m4,$scope.scheduleForm.m5,$scope.scheduleForm.m6,$scope.scheduleForm.m7, $scope.scheduleForm.m8,$scope.scheduleForm.m9,$scope.scheduleForm.m10,$scope.scheduleForm.m11,$scope.scheduleForm.m12,$scope.scheduleForm.m13,$scope.scheduleForm.m14, $scope.scheduleForm.m15,$scope.scheduleForm.m16,$scope.scheduleForm.m17,$scope.scheduleForm.m18,$scope.scheduleForm.m19,$scope.scheduleForm.m20,$scope.scheduleForm.m21,  $scope.scheduleForm.m22,$scope.scheduleForm.m23,$scope.scheduleForm.m24,$scope.scheduleForm.m25,$scope.scheduleForm.m26,$scope.scheduleForm.m27,$scope.scheduleForm.m28, $scope.scheduleForm.m29,$scope.scheduleForm.m30,$scope.scheduleForm.m31],
				m_days : [$scope.scheduleForm.mo1,$scope.scheduleForm.t1,$scope.scheduleForm.w1,$scope.scheduleForm.th1,$scope.scheduleForm.f1,$scope.scheduleForm.s1,$scope.scheduleForm.sun1, $scope.scheduleForm.mo2,$scope.scheduleForm.t2,$scope.scheduleForm.w2,$scope.scheduleForm.th2,$scope.scheduleForm.f2,$scope.scheduleForm.s2,$scope.scheduleForm.sun2, $scope.scheduleForm.mo3,$scope.scheduleForm.t3,$scope.scheduleForm.w3,$scope.scheduleForm.th3,$scope.scheduleForm.f3,$scope.scheduleForm.s3,$scope.scheduleForm.sun3,  $scope.scheduleForm.mo4,$scope.scheduleForm.t4,$scope.scheduleForm.w4,$scope.scheduleForm.th4,$scope.scheduleForm.f4,$scope.scheduleForm.s4,$scope.scheduleForm.sun4]
                
				
				}
            ]

        };
        console.log(dataObject);

        $http.post($scope.schedule_form_url, dataObject, {})
            .success(function(dataFromServer, status, headers, config) {

                console.log(dataFromServer);
            })

        .error(function(data, status, headers, config) {
            alert("Submitting form failed!");
        });
    	
    	
    }
    
    $scope.validateTimings=function(){
        var dataObject={
    	from1:$scope.myForm.mytime1,
    	to1:$scope.myForm.mytime2,
    	from2:$scope.myForm.mytimefrom1,
    	to2:$scope.myForm.mytimeto1,
		from3:$scope.myForm.mytimefrom2,
		to3:$scope.myForm.mytimeto2,
		from4:$scope.myForm.mytimefrom3,
		to4:$scope.myForm.mytimeto3,
		from5:$scope.myForm.mytimefrom4,
		to5:$scope.myForm.mytimeto4,
		from6:$scope.myForm.mytimefrom5,
		to6:$scope.myForm.mytimeto5,
		from7:$scope.myForm.mytimefrom6,
		to7:$scope.myForm.mytimeto6,
		from8:$scope.myForm.mytimefrom7,
		to8:$scope.myForm.mytimeto7,
		from9:$scope.myForm.mytimefrom8,
		to9:$scope.myForm.mytimeto8,
		from10:$scope.myForm.mytimefrom9,
		to10:$scope.myForm.mytimeto9
        };
    	console.log(dataObject);
    	
    	
    	 $http.post($scope.validate_slot_time_url, dataObject, {})
         .success(function(dataFromServer, status, headers, config) {

             console.log(dataFromServer);
             if(dataFromServer==1)
            	 {
            	 $scope.validation_bool=1;
            	 $scope.validation="Your time slots are overlaping, please check out";
            	 return false;
            	 }
             else
            	 {
            	 $scope.validation_bool=0;
            	 return true;
            	 }
         })

	     .error(function(data, status, headers, config) {
	         alert("Submitting form failed!");
	     });
    };
    
    $scope.validateTimings_before_submit=function(){
        var dataObject={
    	from1:$scope.myForm.mytime1,
    	to1:$scope.myForm.mytime2,
    	from2:$scope.myForm.mytimefrom1,
    	to2:$scope.myForm.mytimeto1,
		from3:$scope.myForm.mytimefrom2,
		to3:$scope.myForm.mytimeto2,
		from4:$scope.myForm.mytimefrom3,
		to4:$scope.myForm.mytimeto3,
		from5:$scope.myForm.mytimefrom4,
		to5:$scope.myForm.mytimeto4,
		from6:$scope.myForm.mytimefrom5,
		to6:$scope.myForm.mytimeto5,
		from7:$scope.myForm.mytimefrom6,
		to7:$scope.myForm.mytimeto6,
		from8:$scope.myForm.mytimefrom7,
		to8:$scope.myForm.mytimeto7,
		from9:$scope.myForm.mytimefrom8,
		to9:$scope.myForm.mytimeto8,
		from10:$scope.myForm.mytimefrom9,
		to10:$scope.myForm.mytimeto9
        };
    	console.log(dataObject);
    	
    	
    	 $http.post($scope.validate_slot_time_url, dataObject, {})
         .success(function(dataFromServer, status, headers, config) {

             console.log(dataFromServer);
             if(dataFromServer==1)
            	 {
            	 $scope.validation_bool=1;
            	 $scope.validation="Your time slots are overlaping, please check out";
            	 alert("Time Slots overlapping,please click on preview before submit");
            	 }
             else
            	 {
            	 $scope.validation_bool=0;
            	 $scope.submit();
            	 }
         })

	     .error(function(data, status, headers, config) {
	         alert("Submitting form failed!");
	     });
    };
    
    
	
	 $scope.master123 = {};
	
	$scope.alertMe_daily = function() {
        setTimeout(function() {
            $window.alert('You\'ve selected the daily tab! Your rest data will be deleted');
        });
        //$scope.scheduleForm.repeatType="d";
		
    };
	
	$scope.alertMe_weekly = function() {
        $window.alert('You\'ve selected the weekly tab! Your rest data will be deleted');
        //$scope.scheduleForm.repeatType="w";
	};
	
	$scope.alertMe_monthly = function() {
        setTimeout(function() {
            $window.alert('You\'ve selected the Monthly tab! Your rest data will be deleted');
        });
        //$scope.scheduleForm.repeatType="m";
    };
	$scope.reset = function() {
        $scope.scheduleForm = angular.copy($scope.master123);
    };
	//$scope.reset();

})