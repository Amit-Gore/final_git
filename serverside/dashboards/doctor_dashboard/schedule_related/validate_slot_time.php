<?php
/*
 * Created on Feb 25, 2015
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 $data = file_get_contents("php://input");
$objData = json_decode($data,true);
$numberofSlots=count($objData)/2;
$from_mins=array();
$to_mins=array();

#print_r(strtotime($objData['from1']));exit();
for($i=1;$i<=$numberofSlots;$i++)
{
	$exploded=explode(":",$objData['from'.$i]);
    $from_mins[$i-1]= $exploded[0]*60+$exploded[1];
    
    $exploded=explode(":",$objData['to'.$i]);
    $to_mins[$i-1]= $exploded[0]*60+$exploded[1];
    
    
}
//$from_mins is a 0 indexed array containing from-time slots in minutes format

if(isOverlap($from_mins,$to_mins,$numberofSlots))
{
  print_r("1");	
}
else
{
	print_r("0");
}


function isOverlap($from_mins,$to_mins,$numberofSlots)
{
for($i=0;$i<$numberofSlots;$i++)
{
	
	 for($j=$i+1;$j<$numberofSlots;$j++)
	 {
	 	if($from_mins[$i] < $to_mins[$j] and $from_mins[$j] < $to_mins[$i])
	 	 {
	 	 	return 1;
	 	 }
	 }
}
return 0;
}
?>
