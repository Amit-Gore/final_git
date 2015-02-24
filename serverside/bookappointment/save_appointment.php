<?php
/*
 * Created on Feb 2, 2015
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
session_start();
include_once('../mysql_crud.php');
include_once('C:xampp/htdocs/final_git/serverside/dashboards/doctor_dashboard/schedule_related/scheduleFunctions.php');
$data = file_get_contents("php://input");
$objData = json_decode($data);

$patientname=htmlspecialchars($objData->patientname);
$Reason=htmlspecialchars($objData->Reason);
$app_date=htmlspecialchars($objData->app_date);
$app_slot=htmlspecialchars($objData->slot);
$app_slot_id=htmlspecialchars($objData->slot_id);
$doc_id=htmlspecialchars($objData->doc_id); 
$patient_ID=$_SESSION['patient']['patientID'];
$app_ID=bookAppointment($patient_ID,$doc_id,$patientname,$Reason,$app_date,$app_slot_id,$app_slot);

return $app_ID;

?>
