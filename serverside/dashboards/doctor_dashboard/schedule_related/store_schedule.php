<?php
/*
 * Created on Feb 9, 2015
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
  session_start();
include_once('../../../mysql_crud.php');
include_once('scheduleFunctions.php');
$data = file_get_contents("php://input");
$objData = json_decode($data,true);
$repeat=array();

/*if(isset($objData['repeat'][0]['from_m']))print_r("month wise is available");
if(isset($objData['repeat'][0]['from_d']))print_r("weekvise is available");
print_r($objData['repeat'][0]['from_w']);exit();*/

	if(isset($objData['repeat'][0]['from_w']))
	{
		$repeat['type']="w";
		$repeat['dayArray']=$objData['repeat'][0]['w_days'];
		$repeat['from']=$objData['repeat'][0]['from_w'];
		$repeat['to']=$objData['repeat'][0]['to_w'];
	
	}
	if(isset($objData['repeat'][0]['from_d']))
	{
		$repeat['type']="d";
		$repeat['from']=$objData['repeat'][0]['from_d'];
		$repeat['to']=$objData['repeat'][0]['to_d'];
	}

	if(isset($objData['repeat'][0]['from_m']))
	{
		$is_datewise=false;
		for($i=0;$i<31;$i++)
		{
			if(isset($objData['repeat'][0]['m_dates'][$i]))
			$is_datewise=true;
		}
		
		
		if($is_datewise) {
			$repeat['type']="m";
			$repeat['month_dayArray']=$objData['repeat'][0]['m_dates'];
		}
		else {
			$repeat['type']="mwd";
			$repeat['month_dayArray']=$objData['repeat'][0]['m_days'];
		}
		
		$repeat['from']=$objData['repeat'][0]['from_m'];
		$repeat['to']=$objData['repeat'][0]['to_m'];
		
		
	}

  //print_r($repeat);


#print_r($objData->repeat->type);
$slots=array();

if(isset($objData['slots']['slot1']['to']))
$slots['slot1']=$objData['slots']['slot1'];

if(isset($objData['slots']['slot2']['to']))
$slots['slot2']=$objData['slots']['slot2'];

if(isset($objData['slots']['slot3']['to']))
$slots['slot3']=$objData['slots']['slot3'];

if(isset($objData['slots']['slot4']['to']))
$slots['slot4']=$objData['slots']['slot4'];

if(isset($objData['slots']['slot5']['to']))
$slots['slot5']=$objData['slots']['slot5'];

if(isset($objData['slots']['slot6']['to']))
$slots['slot6']=$objData['slots']['slot6'];

if(isset($objData['slots']['slot7']['to']))
$slots['slot7']=$objData['slots']['slot7'];

if(isset($objData['slots']['slot8']['to']))
$slots['slot8']=$objData['slots']['slot8'];

if(isset($objData['slots']['slot9']['to']))
$slots['slot9']=$objData['slots']['slot9'];

if(isset($objData['slots']['slot10']['to']))
$slots['slot10']=$objData['slots']['slot10'];

//print_r($slots);exit();

storeSchedule($_SESSION['doctor']['doc_id'],$slots,$repeat);


 
?>
