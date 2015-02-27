<?php
/*
 * Created on Feb 9, 2015
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
  /**
 * Creating date collection between two dates
 */
function date_range($first, $last, $step = '+1 day', $output_format = 'Y-m-d' ) {

    $dates = array();
    $current = strtotime($first);
    $last = strtotime($last);

    while( $current <= $last ) {

        $dates[] = date($output_format, $current);
        $current = strtotime($step, $current);
    }

    return $dates;
}
 
  
 /**
 * Creating date collection between two dates and the day of every date-collection should be in provided array:$dayBool
 */
function daywise_date_range($first, $last,$dayBool,$step = '+1 day',$output_format = 'Y-m-d' ) {

    $days=array("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday");
    $checkedDays=array();
    for($i=0;$i<7;$i++)
    {
      if($dayBool[$i])
      {
      	array_push($checkedDays,$days[$i]);
      }	
    }
    $dates = array();
    $current = strtotime($first);
    $last = strtotime($last);

    while( $current <= $last ) {

        if(in_array(date('l',$current),$checkedDays))
        $dates[] = date($output_format, $current);
        $current = strtotime($step, $current);
    }
    return $dates;
}


function monthly_date_range($first,$last,$MonthDayBool,$step = '+1 day',$output_format = 'Y-m-d') {
	
	$checkedMonthDay=array();
	for($i=0;$i<31;$i++)
	{
		if($MonthDayBool[$i])
		{
			array_push($checkedMonthDay,$i+1);
		}
	}
	$dates = array();
    $current = strtotime($first);
    $last = strtotime($last);

    while( $current <= $last ) {

        if(in_array(date('j',$current),$checkedMonthDay))
        $dates[] = date($output_format, $current);
        $current = strtotime($step, $current);
    }
    return $dates;
	
}

$monthweekday_array=array(1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0);

#print_r($monthweekday_array);

function monthly_weekday_date_range($first,$last,$monthweekday_array,$step = '+1 day',$output_format= 'Y-m-d')
{
	$day_name=array();
	$day_name[0]="Monday";
	$day_name[1]="Tuesday";
	$day_name[2]="Wednesday";
	$day_name[3]="Thursday";
	$day_name[4]="Friday";
	$day_name[5]="Saturday";
	$day_name[6]="Sunday";
	
	$counting=array();
	$counting[1]="first";
	$counting[2]="second";
	$counting[3]="third";
	$counting[4]="fourth";
	
	$requiredInputFormat=array();
	$requiredInputFormat[1]=array();
	$requiredInputFormat[2]=array();
	$requiredInputFormat[3]=array();
	$requiredInputFormat[4]=array();
	for($i=0;$i<28;$i++)
			{
				if($monthweekday_array[$i])
				{
					array_push($requiredInputFormat[ceil(($i+1)/7)],$day_name[$i%7]);
					//$requiredInputFormat[ceil(($i+1)/7)][]=$day_name[$i%7];//index defined as "first week","second week"
				}
			}
	//print_r($requiredInputFormat);exit();
	$dates = array();
    $current = strtotime($first);
    $last = strtotime($last);

    while( $current <= $last ) {
        
        $currentdayofmonth=date('j',$current); //fetch current monthday of month example: 29 or 31 or 13 etc
        $current_w_dayofmonth=date('l',$current);//fetch weekday of current date example : Monday or Tuesday : it should match the $day_name array defined above
        if(ceil($currentdayofmonth/7)<5)
        { //we are only providing 4 weeks in the form to reduce the complexity of algorithm,i.e no day will have more than 4 occurences in a month
	        if(in_array($current_w_dayofmonth,$requiredInputFormat[ceil($currentdayofmonth/7)]))
	        {
	        	$dates[] = date($output_format, $current);
	        }    
        }
        $current = strtotime($step, $current); //increase current date by one
    }
    //print_r($dates);exit();
    return $dates;
			
}

/*function hop_from_current_date($hop_by=1)
{
	
	
}*/

 
?>
