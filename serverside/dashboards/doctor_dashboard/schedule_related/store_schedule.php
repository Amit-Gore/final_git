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
#print_r($objData);exit();
#print_r($objData->repeat->type);
$slots=array();
$repeat=array();
$repeat=$objData['repeat'];
print_r($repeat);
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
