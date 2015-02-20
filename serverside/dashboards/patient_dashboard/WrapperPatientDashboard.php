<?php
/*
 * Created on Feb 20, 2015
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 session_start();
 include_once("../../mysql_crud.php");
 include_once("PatientDashboardEssentialFunctions.php");
 
 //print_r($_SESSION['patient']['patientID']);exit();
 $patientDashboardData=array();
 $patientDashboardData=fetchAppointmentData($_SESSION['patient']['patientID']); 
 $patientDashboardData=json_encode($patientDashboardData);
 print_r($patientDashboardData);
?>
