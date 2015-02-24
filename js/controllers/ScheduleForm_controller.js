app.controller('ScheduleForm', function($scope, $http, $window) {
    $scope.count = 0;
    $scope.schedule_form_url = "serverside/dashboards/doctor_dashboard/schedule_related/store_schedule.php";

   
    $scope.submit = function() {

        console.log("inside form");
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
				{//type:$scope.myForm.repeatType,
                type: 'd',
                from: $scope.scheduleForm.dt1,
                to: $scope.scheduleForm.dt2
				},
				{//type:$scope.scheduleForm.repeatType,
                type: 'w',
				days : [$scope.scheduleForm.sunday,$scope.scheduleForm.monday,$scope.scheduleForm.tuesday,$scope.scheduleForm.wednesday,$scope.scheduleForm.thursday,$scope.scheduleForm.friday,$scope.scheduleForm.satureday],
                from: $scope.scheduleForm.dt3,
                to: $scope.scheduleForm.dt4
				},
				{//type:$scope.scheduleForm.repeatType,
                type: 'm',
				m_dates : [$scope.scheduleForm.m1,$scope.scheduleForm.m2,$scope.scheduleForm.m3,$scope.scheduleForm.m4,$scope.scheduleForm.m5,$scope.scheduleForm.m6,$scope.scheduleForm.m7, $scope.scheduleForm.m8,$scope.scheduleForm.m9,$scope.scheduleForm.m10,$scope.scheduleForm.m11,$scope.scheduleForm.m12,$scope.scheduleForm.m13,$scope.scheduleForm.m14, $scope.scheduleForm.m15,$scope.scheduleForm.m16,$scope.scheduleForm.m17,$scope.scheduleForm.m18,$scope.scheduleForm.m19,$scope.scheduleForm.m20,$scope.scheduleForm.m21,  $scope.scheduleForm.m22,$scope.scheduleForm.m23,$scope.scheduleForm.m24,$scope.scheduleForm.m25,$scope.scheduleForm.m26,$scope.scheduleForm.m27,$scope.scheduleForm.m28, $scope.scheduleForm.m29,$scope.scheduleForm.m30,$scope.scheduleForm.m31],
				m_days : [$scope.scheduleForm.mo1,$scope.scheduleForm.t1,$scope.scheduleForm.w1,$scope.scheduleForm.th1,$scope.scheduleForm.f1,$scope.scheduleForm.s1,$scope.scheduleForm.sun1, $scope.scheduleForm.mo2,$scope.scheduleForm.t2,$scope.scheduleForm.w2,$scope.scheduleForm.th2,$scope.scheduleForm.f2,$scope.scheduleForm.s2,$scope.scheduleForm.sun2, $scope.scheduleForm.mo3,$scope.scheduleForm.t3,$scope.scheduleForm.w3,$scope.scheduleForm.th3,$scope.scheduleForm.f3,$scope.scheduleForm.s3,$scope.scheduleForm.sun3,  $scope.scheduleForm.mo4,$scope.scheduleForm.t4,$scope.scheduleForm.w4,$scope.scheduleForm.th4,$scope.scheduleForm.f4,$scope.scheduleForm.s4,$scope.scheduleForm.sun4],
                from: $scope.scheduleForm.dt5,
                to: $scope.scheduleForm.dt6
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

        /* var dataObject2 = {
				// Sch_date : $scope.myForm.Sch_date,
				
				//slots1 : slots,	
				
				
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
				 console.log(dataObject2);*/
    }
	
	 $scope.master123 = {};
	
	$scope.alertMe_daily = function() {
        setTimeout(function() {
            $window.alert('You\'ve selected the daily tab! Your rest data will be deleted');
        });
		
		
    };
	
	$scope.alertMe_weekly = function() {
        $window.alert('You\'ve selected the weekly tab! Your rest data will be deleted');
    
	};
	
	$scope.alertMe_monthly = function() {
        setTimeout(function() {
            $window.alert('You\'ve selected the Monthly tab! Your rest data will be deleted');
        });
    };
	$scope.reset = function() {
        $scope.scheduleForm = angular.copy($scope.master123);
    };
	$scope.reset();

})