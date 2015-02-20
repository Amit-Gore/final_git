<?php
/*
 * Created on Feb 13, 2015
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 include_once("../../../mysql_crud.php");
 
 $data = file_get_contents("php://input");
 $objData = json_decode($data);
 $doc_id=$objData->doc_id;
 include_once("DoctorDashboardEssentialFunctions.php");
 $doctorData=FetchDoctorData($doc_id);//contains appointment statistics
 $AppointmentsForConfirmation=FetchAppointmentsForConfirmation($doc_id);//contains AppointmentId,PatientId,AppointmentDate,AppointmentSlot,Reason,PatientName
 $todayAppointments=TodayFetchConfirmedAppointments($doc_id);//contains AppointmentId,PatientId,AppointmentDate,AppointmentSlot,Reason
 $allAppointments=FetchAllAppointmentData($doc_id);
 
 $doctorDashboardData=array();
 $doctorDashboardData['statistics']=$doctorData;
 $doctorDashboardData['ForConfirmation']=$AppointmentsForConfirmation;
 $doctorDashboardData['todayAppointments']=$todayAppointments;
 $doctorDashboardData['AllAppointments']=$allAppointments;
 $doctorDashboardData=json_encode($doctorDashboardData);
 print_r($doctorDashboardData);
 
?>
