<?php
/*
 * Created on Feb 20, 2015
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
  session_start();
 include_once("../../mysql_crud.php");
 include_once("../../PHPMailer/PHPMailerAutoload.php");
 include_once("../../notifications/NotificationModuleFunctions.php");
 include_once("../../dashboards/patient_dashboard/PatientDashboardEssentialFunctions.php");
 
 $data = file_get_contents("php://input");
 $objData = json_decode($data);
 $app_id=$objData->app_id;
 cancelAppointment($app_id);
 
?>
