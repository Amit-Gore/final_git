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

$monthweekday_array=array();
$monthweekday_array['first']=array(0,0,0,0,0,0,0);
$monthweekday_array['second']=array(0,0,0,0,0,0,0);
$monthweekday_array['third']=array(1,0,0,0,0,0,0);
$monthweekday_array['fourth']=array(0,0,0,0,0,0,0);
#print_r($monthweekday_array);

function monthly_weekday_date_range($first,$last,$monthweekday_array,$output_format= 'Y-m-d')
{
	
	$third_monday = new DateTime('third monday of this month');
	

	// if date has passed, get next month's third monday
	if ($third_monday < new DateTime()) {
	    $third_monday->modify('third monday of next month');
	}
	
	echo $third_monday->format('l F d, Y');
	
}

/*function hop_from_current_date($hop_by=1)
{
	
	
}*/

 
?>
