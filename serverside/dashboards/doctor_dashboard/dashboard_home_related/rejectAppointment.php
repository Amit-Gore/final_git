<?php
/*
 * Created on Feb 20, 2015
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 session_start();
 include_once("../../../mysql_crud.php");
 include_once("../../../PHPMailer/PHPMailerAutoload.php");
 include_once("../../../notifications/NotificationModuleFunctions.php");
 include_once("DoctorDashboardEssentialFunctions.php");
 
 $data = file_get_contents("php://input");
 $objData = json_decode($data);
 $app_id=$objData->app_id;
 $doc_name=$_SESSION['doctor']['DFirstName'].' '.$_SESSION['doctor']['DLastName'];
 $doc_id=$_SESSION['doctor']['doc_id'];
 $subject='Your Appointment has been CANCELLED by the doctor.';
		  $Status="Cancelled by Doctor";
		  
		  $db= new Database();
 		  $db->connect();
		  $db->select('appointment_info',' * ',NULL,'AppointmentId='.$app_id.'');
		  $appData=$db->getResult();
		  $db->select('userregistration','user_email,contactNumber',NULL,'userID='.$appData[0]['PatientId'].'');
		  $patientData=$db->getResult();
		  $db->update('appointment_info',array('AppointmentStatus' => "3"),'AppointmentId = "'.$app_id.'"');
		 
          UpdateAppointmentStatistics('rejected',$doc_id);
          //UpdateAppointmentStatistics('cancelled',$doc_id);		 
		  
		  
		  if(isset($patientData[0]['user_email'])==true){
		  StatusChangeVerification($patientData[0]['user_email'],$doc_name,$appData[0]['AppointmentSlot'],$appData[0]['AppointmentDate'],$subject,"Cancelled by the Doctor");
		  } 
		  
		  SMSNotify_AppointmentStatus($patientData[0]['contactNumber'],$SlotTiming[$appData[0]['AppointmentSlot']],$appData[0]['AppointmentDate'],$doc_name,$Status);
		 
?>
