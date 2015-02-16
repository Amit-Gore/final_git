<?php
/*
 * Created on Feb 9, 2015
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 include_once("dates_related_function.php");
 //echo getcwd() ;exit();
 //include_once("../../../mysql_crud.php");
 include_once("C:xampp/htdocs/angularFiles/final_git/serverside/mysql_crud.php");
 //echo date("d");exit();
 
  $doc_id=3;
  $doc_id_array=array(1,2);
  $TriggeringDate="2015-02-15";
  $dateArray=array("2015-02-15");
  
  $slots=array();
  
  
  $slots['slot1']['from']="09:30";
  $slots['slot1']['to']="12:45";
  $slots['slot1']['avgTimePerPatient']=10;
  $slots['slot1']['location']="singhagadaaaaaaaaaaaaaaaaaaaaaaaa";
  
  $slots['slot2']['from']="14:30";
  $slots['slot2']['to']="17:00";
  $slots['slot2']['avgTimePerPatient']=15;
  $slots['slot2']['location']="Aundh";
 
  $repeat=array();
  $repeat['type']="d";
  #$repeat['month_dayArray']=array(1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,1,1,0,1,0,0,1,1,0,1,0);
  
  //print_r($repeat['dayArray']);exit();
  $repeat['from']="2015-02-11";
  $repeat['to']="2015-02-28";
  #daywise_date_range($repeat['from'],$repeat['to'],$repeat['dayArray']);
  #print_r($repeat);exit();
 
  #storeSchedule($doc_id,$slots,$repeat);exit();
  #overwriteSchedule($doc_id,$slots,$TriggeringDate); 
  #fetchScheduleSingleDoc($doc_id);
  #fetchScheduleMultipleDoc($doc_id_array);
  availableSchedule($doc_id);
   
 //print_r(monthly_date_range($repeat['from'],$repeat['to'],$repeat['month_dayArray']));exit();
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 /*
  * Function Descripton:
  * This function will create the slots according to the time slots doctor has provided
  * After creating the slots it will store the slots into database
  * 
  * Precondition: 
  * Assuming that the doctor wants to repeat his schedule
  * 
  * Parameter Description:
  * $slots:is an array holding the detailed data for all the slots provided in the form
  * $repeat:is an array containing the detailed data about 'how doctor wanted the schedule to be repeated and 
  * 		what would be the duration for this',
  *         either it will be 'daily'or'weekly'or'monthly'
  *   
  * */
  
 function storeSchedule($doc_id,$slots,$repeat) // date won't be a parameter here
 {
 	    $db= new Database();
 	    $db->connect();
 		
 	    
 	    $database_storage=array();
 	    $slots_key=array_keys($slots);//we don't know how many slots doctor will add for particular 
 									  //day,so to retrieve the slot keys we have used this method
 		$numberofSlots=count($slots_key);
 	    
	 	    //Generate Slots from the form data
	 	    for($i=0;$i<$numberofSlots;$i++)
	 	    {
	 	    	
	 	    	#print_r($slots[$slots_key[$i]]);
	 	    	$to_exploded=explode(':',$slots[$slots_key[$i]]['to']);
	 	    	$from_exploded=explode(':',$slots[$slots_key[$i]]['from']);
	 	    	
	 	    	/*
	 	    	 * Usage reasoning: We need to store the start and end time in mins so that calculations
	 	    	 *                  get easy at the time of generating slots
	 	    	 * */
	 	    	$slots[$slots_key[$i]]['from_inMins']=$from_exploded[0]*60;
	 	    	$slots[$slots_key[$i]]['from_inMins']+=$from_exploded[1];
	 	    	
	 	    	$slots[$slots_key[$i]]['to_inMins']=$to_exploded[0]*60;
	 	    	$slots[$slots_key[$i]]['to_inMins']+=$to_exploded[1];
	 	    	/*ENDS
	 	    	 * */
	 	    	
	 	    	
	 	    	
	 	    	$hr_difference=$to_exploded[0]-$from_exploded[0];
	 	    	$min_difference=abs($to_exploded[1]-$from_exploded[1]);
	 	    	$total_minutes= $hr_difference*60+$min_difference;
	 	    	
	 	    	$numberofGeneratedSlots=floor($total_minutes/$slots[$slots_key[$i]]['avgTimePerPatient']);
	 	    	
	 	    	foreach (range(0,$numberofGeneratedSlots-1) as $number) {
	    			
	    			$slots[$slots_key[$i]]['sequentialSlots'][]=1;
					}
					$slots[$slots_key[$i]]['TotalSlots']=$numberofGeneratedSlots;
					$slots['numberofSuperSlots']=$numberofSlots; //Store the ids of slots in the database. Example ['2015/02/11']=>['slot1'],
																 //so we are stroing the number of such slots per day to reduce our time complexity
																 //for search function written in this file
					#print_r($slots[$slots_key[$i]]);exit();
	 	    	
	 	    }
	 	    //generation completes
 
 	if($repeat['type']=="d")
 	{
 		$dates=date_range($repeat['from'],$repeat['to']);
 		foreach ( $dates as $singleDate ) {
           
           $database_storage[$singleDate]=$slots;
          }
 		ksort($database_storage);   // sort it by date as a key(ksort is compatible with yyyy-mm-dd date format)
							 		//There's no need to remove the hyphens, ksort will do an alphanumeric comparison on the string keys, 
							 		//and the yyyy-mm-dd format works perfectly well as the lexical order is the same as the actual date order.
 		$database_storage=json_encode($database_storage);
 		$db->sql("UPDATE doctor_info SET schedule='$database_storage' WHERE doc_id=$doc_id");
 		$res=$db->getResult();
        $db->disconnect();
 		
 		
 	}
 	
 	if($repeat['type']=="w")
 	{
 		$dates=daywise_date_range($repeat['from'],$repeat['to'],$repeat['dayArray']);
 		foreach($dates as $singleDate){
 			$database_storage[$singleDate]=$slots;
 		}
 		ksort($database_storage);  // sort it by date as a key(ksort is compatible with yyyy-mm-dd date format)
							 		//There's no need to remove the hyphens, ksort will do an alphanumeric comparison on the string keys, 
							 		//and the yyyy-mm-dd format works perfectly well as the lexical order is the same as the actual date order.
 		$database_storage=json_encode($database_storage);
 		$db->sql("UPDATE doctor_info SET schedule='$database_storage' WHERE doc_id=$doc_id");
 		$res=$db->getResult();
        $db->disconnect();
 		
 	}
 	if($repeat['type']=="m")
 	{
 		$dates=monthly_date_range($repeat['from'],$repeat['to'],$repeat['month_dayArray']);
 		foreach($dates as $singleDate){
 			$database_storage[$singleDate]=$slots;
 		}
 		ksort($database_storage);	// sort it by date as a key(ksort is compatible with yyyy-mm-dd date format)
							 		//There's no need to remove the hyphens, ksort will do an alphanumeric comparison on the string keys, 
							 		//and the yyyy-mm-dd format works perfectly well as the lexical order is the same as the actual date order.
 		$database_storage=json_encode($database_storage);
 		#$db->update('doctor_info',array('schedule'=>$database_storage),'doc_id="'.$doc_id.'"');
 		$db->sql("UPDATE doctor_info SET schedule='$database_storage' WHERE doc_id=$doc_id");
 		$res=$db->getResult();
        $db->disconnect();
 	}

 }
 












 /*
  * Function Descripton:
  * 
  * This function will update particular day's schedule
  * Flow would be: Fetch the json text of schedule and find the date,
  * after that update that day's schedule
  * 
  * Precondition: 
  * This function is only applicable to action where doctor dont want any repeatation in schedule,
  * doctor wants to change particular date's schedule
  * 
  * Parameter Description:
    @doc_id: A doctor id
    @    
  * */ 
 function overwriteSchedule($doc_id,$slots,$TriggeringDate)
 {
 	$db= new Database();
 	    $db->connect();
 		
 	    
 	    $database_storage=array();
 	    $slots_key=array_keys($slots);//we don't know how many slots doctor will add for particular 
 									  //day,so to retrieve the slot keys we have used this method
 		$numberofSlots=count($slots_key);
 	    
	 	    //Generate Slots from the form data
	 	    for($i=0;$i<$numberofSlots;$i++)
	 	    {
	 	    	
	 	    	$to_exploded=explode(':',$slots[$slots_key[$i]]['to']);
	 	    	$from_exploded=explode(':',$slots[$slots_key[$i]]['from']);
	 	    	
	 	    	$hr_difference=$to_exploded[0]-$from_exploded[0];
	 	    	$min_difference=abs($to_exploded[1]-$from_exploded[1]);
	 	    	$total_minutes= $hr_difference*60+$min_difference;
	 	    	
	 	    	$numberofGeneratedSlots=floor($total_minutes/$slots[$slots_key[$i]]['avgTimePerPatient']);
	 	    	
	 	    	foreach (range(0,$numberofGeneratedSlots-1) as $number) {
	    			
	    			$slots[$slots_key[$i]]['sequentialSlots'][]=1;
					}
					$slots[$slots_key[$i]]['TotalSlots']=$numberofGeneratedSlots;
					$slots['numberofSuperSlots']=$numberofSlots; //Store the ids of slots in the database. Example ['2015/02/11']=>['slot1'],
																 //so we are stroing the number of such slots per day to reduce our time complexity
																 //for search function written in this file
					#print_r($slots[$slots_key[$i]]);exit();
	 	    	
	 	    }
	 	    //generation completes
	 	    
	 	     $db->select('doctor_info','schedule',NULL,'doc_id="'.$doc_id.'"');
	 	     $res=$db->getResult();
	 	     $input_schedule=$res[0]['schedule']; // got the schedule from database
	 	     
	 	     $input_schedule=json_decode($input_schedule,true);//convert it to associative array
	 	     #print_r($input_schedule);exit();
	 	     
	 	     	
	 	     	
	 	     	$input_schedule[$TriggeringDate]=$slots; //update the schedule 
	 	     	//print_r($input_schedule);exit();
	 	     	ksort($input_schedule); 
	 	     	
	 	     	
	 	        $db->sql("UPDATE doctor_info SET schedule='$input_schedule' WHERE doc_id=$doc_id");
		 		$res=$db->getResult();
		        $db->disconnect();
	 	    
	 	    
	 	    
 }
 
  /*
  * Fetch schedule of the doctor with given id
  * 
  * Returns an associative array of schedule
  * */
 function fetchScheduleSingleDoc($doc_id)
 {
 	$db= new Database();
 	$db->connect();
 	$db->select('doctor_info','schedule',NULL,'doc_id="'.$doc_id.'"');
	$res=$db->getResult();
	$input_schedule=$res[0]['schedule']; // got the schedule from database
	$input_schedule=json_decode($input_schedule,true);//convert it to associative array
	//print_r($input_schedule);exit();
	return $input_schedule;
 }
 
  /*
  * Fetch schedule of the doctor with given array of ids
  * 
  * Returns an associative array of doctor's schedule, indexing is being done by doc_id
  * */
 function fetchScheduleMultipleDoc($doc_id_array)
 {
 	$searchresultDoctorSchedule=array();
 	
 	foreach($doc_id_array as $id )
 	{
 		$searchresultDoctorSchedule[$id]=fetchScheduleSingleDoc($id);
 	}
 	//print_r($searchresultDoctorSchedule);
 	
    return $searchresultDoctorSchedule;
 }
 
 
 
 
  /*
  * Description: This function is supposed to return the slots
  * 
  * Presumptions: Assuming that the schedule data from database is sorted by date(as a key)
  * @doc_id : Doctor ID
  * @counter: Usage Reasoning::At search result page,if user clicks on "show next availability" we need to provide a counter to this function  
  * */
 function availableSchedule($doc_id,$window=3,$offset=0)
 {
 	date_default_timezone_set('Asia/Kolkata');
	$current_hour=date('H');
 	
 	$window_clone=$window;
 	$db=new Database();
 	$db->connect();
 	$db->select('doctor_info','schedule',NULL,'doc_id="'.$doc_id.'"');
	$res=$db->getResult();
	$input_schedule=$res[0]['schedule']; // got the schedule from database
	$input_schedule=json_decode($input_schedule,true);//convert it to associative array
	$Numberof_available_dates=count($input_schedule);
	$available_dates=array_keys($input_schedule);
	//print_r($input_schedule);
	$date_window=array();
	$iterator_date_window=array();
	
 	for($i=$offset;($i<$Numberof_available_dates) and $window_clone;$i++)  //check for next 
 	{
 	   /*echo "<br><br><br><br><br><br>";
 	   print_r($input_schedule[$available_dates[$i]]);*/
 	   if($available_dates[$i]<date("Y-m-d"))
 	   {
 	   	continue;
 	   }
 	   $date_window[$available_dates[$i]]=$input_schedule[$available_dates[$i]];
 	   $iterator_date_window[]=$available_dates[$i];
 	   
 	   $window_clone--;
 	   
 	}
 	#print_r($iterator_date_window);exit(); //iterator_date_window => Array ( [0] => 2015-02-11 [1] => 2015-02-12 [2] => 2015-02-13 )
 	#print_r($date_window[$iterator_date_window[0]]['numberofSuperSlots']);exit();//date_window contains all the slots data. Date would be an index for this array 
 	
 	$temp_index_fetcher=array();
 	
 	$AvailableSlotsForWindow=array();//date as an index to this arrays
 	
 	for($i=0;$i<$window;$i++)
 	{
 	  $temp_index_fetcher=array_keys($date_window[$iterator_date_window[$i]]);//$date_window[$iterator_date_window[$i]] contains dates for window of 3
 	  $numberofSuperSlots=$date_window[$iterator_date_window[$i]]['numberofSuperSlots'];
 	  //print_r($numberofSuperSlots);//$numberofSuperSlots contains the total number of slots doctor has defined for his particular day
 	  for($j=0;$j<$numberofSuperSlots;$j++)
 	  {
 	  	  #print_r($date_window[$iterator_date_window[$i]][$temp_index_fetcher[$j]]);
 	  	 /*print_r($date_window[$iterator_date_window[$i]][$temp_index_fetcher[$j]]['from']);
 	  	 echo"&nbsp &nbsp";
 	  	 print_r($date_window[$iterator_date_window[$i]][$temp_index_fetcher[$j]]['from_inMins']);
 	  	 echo"&nbsp &nbsp";
 	  	 print_r($date_window[$iterator_date_window[$i]][$temp_index_fetcher[$j]]['to']);
 	  	 echo"&nbsp &nbsp";
 	  	  print_r($date_window[$iterator_date_window[$i]][$temp_index_fetcher[$j]]['to_inMins']);
 	  	 echo"&nbsp &nbsp";
 	  	 print_r($date_window[$iterator_date_window[$i]][$temp_index_fetcher[$j]]['avgTimePerPatient']);
 	  	 print_r($date_window[$iterator_date_window[$i]][$temp_index_fetcher[$j]]['sequentialSlots']);
 	  	 print_r($date_window[$iterator_date_window[$i]][$temp_index_fetcher[$j]]['TotalSlots']);
 	  	 echo"&nbsp &nbsp";*/
 	  	 
 	  	 $totalnumberof_sequential_slots=$date_window[$iterator_date_window[$i]][$temp_index_fetcher[$j]]['TotalSlots'];
 	  	 for($k=0;$k<$totalnumberof_sequential_slots;$k++)
 	  	 {
 	  	 	if($date_window[$iterator_date_window[$i]][$temp_index_fetcher[$j]]['sequentialSlots'][$k])
 	  	 	{
 	  	 		/*usage reasoning: Only to reduce typing effort for the long variables
 	  	 		 * */
 	  	 		$from_time=$date_window[$iterator_date_window[$i]][$temp_index_fetcher[$j]]['from_inMins'];
 	  	 		$avgtime_per_patient=$date_window[$iterator_date_window[$i]][$temp_index_fetcher[$j]]['avgTimePerPatient'];
 	  	 		
 	  	 		
 	  	 		$SlotFromTime=$from_time+$k*$avgtime_per_patient; //$k start from 0
 	  	 		$SlotToTime=$SlotFromTime+$avgtime_per_patient;
 	  	 		
 	  	 		$SlotFromTimeHr=floor($SlotFromTime/60);
 	  	 		$SlotToTimeHr=floor($SlotToTime/60);
 	  	 		
 	  	 		/*
 	  	 		 * Usage reasoning: $current_hour represents the current hour of the day,so even if the slot is available
 	  	 		 * 					we need to check whether it pasts the current time or not
 	  	 		 * 
 	  	 		 * */
 	  	 		if($SlotToTimeHr<=$current_hour and $iterator_date_window[$i]== date("Y-m-d") ) // if it is to the past then dont add it to  available slot array
 	  	 		continue;
 	  	 		
 	  	 		
 	  	 		if(!$SlotToTimeHr||!$SlotFromTimeHr)
 	  	 		echo "ERROR:CHECK available_schedule function in scheduleFunctions.php";
 	  	
 	  	 		
 	  	 		$SlotFromTimeMin=$SlotFromTime%60;
 	  	 		$SlotToTimeMin=($SlotToTime)%60;
 	  	 		
 	  	 		
 	  	 		if(!$SlotToTimeMin)
 	  	 		$SlotToTimeMin="00";
 	  	 		if(!$SlotFromTimeMin)
 	  	 		$SlotFromTimeMin="00";
 	  	 		
 	  	 		$SlotFromTime=$SlotFromTimeHr.":".$SlotFromTimeMin;
 	  	 		$SlotToTime=$SlotToTimeHr.":".$SlotToTimeMin;
 	  	 		$TimeSlot=$SlotFromTime."-".$SlotToTime;
 	  	 		
 	  	 		$SlotDistinctionType=PartitionSlots($SlotFromTimeHr);
 	  	 		/*echo"<br>";
 	  	 		echo $TimeSlot;
 	  	 		echo"<br>";*/
 	  	 		#exit();
 	  	 		/*
 	  	 		 * usage reasoning:giving every slot a unique index for the ease at bookappointment procedure
 	  	 		 * */
 	  	 		$uniqueIndex=$temp_index_fetcher[$j].':'.$k;
 	  	 		
 	  	 		$AvailableSlotsForWindow[$iterator_date_window[$i]][$SlotDistinctionType][$uniqueIndex]=$TimeSlot;
 	  	 		
 	  	 		/*Usage Reasoning
 	  	 		 * "2015-02-15" date format change
 	  	 		 * "front end's requirement by prashant"
 	  	 		 * */
 	  	 		 $columndate=date("d M D",strtotime($iterator_date_window[$i]));
 	  	 		 $formatted_dates=explode(" ",$columndate);
				 $AvailableSlotsForWindow[$iterator_date_window[$i]]['date']=$formatted_dates[0];
				 $AvailableSlotsForWindow[$iterator_date_window[$i]]['month']=$formatted_dates[1];
				 $AvailableSlotsForWindow[$iterator_date_window[$i]]['day']=$formatted_dates[2];
 	  	 	}
 	  	 }
 	  	 
 	  	 
 	  }
 	  //print_r($AvailableSlotsForWindow[$iterator_date_window[$i]]); // prints slots for each date
 	  //echo"<br><br><br>";
 	  //exit();
 	}
 	//print_r($AvailableSlotsForWindow);//prints slots for one window
 	return $AvailableSlotsForWindow;
 }
 
 
 function PartitionSlots($hourtime)
 {
 	if($hourtime <=11)
 	$return="Morning";
 	if($hourtime>11 and $hourtime<=15)
 	$return="Afternoon";
 	if($hourtime>15 and $hourtime<=18)
 	$return="Evening";
 	if($hourtime>18 and $hourtime<=22)
 	$return="Night";
 	
 	return $return;
 	
 }
 
  /*
  * 
  * */
 function addLocation()
 {
 	
 }
 
  /*
  * 
  * */
 function fetchLocation()
 {
 	
 }
 
 
?>
