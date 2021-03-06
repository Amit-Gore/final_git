<?php
/*
 * Created on Feb 20, 2015
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 
 
function fetchAppointmentData($patientID)
{
$db=new Database();
$db->select('appointment_info','di.FirstName AS DocFname,di.LastName AS DocLname,di.fee AS DocFee,di.DocImage AS DocImage,appointment_info.AppointmentDate,appointment_info.AppointmentId,appointment_info.AppointmentSlot,
             appointment_info.AppointmentStatus,appointment_info.Reason,dc.clinic_name,dc.clinic_address,dc.clinic_contact',
			 'doctor_info di ON appointment_info.DoctorId = di.doc_id LEFT JOIN doctor_clinic dc ON appointment_info.DoctorId = dc.doctor_id ',
			 'appointment_info.PatientId="'.$patientID.'" AND appointment_info.AppointmentDate >= CURDATE() AND (appointment_info.AppointmentStatus=2 OR appointment_info.AppointmentStatus=1) ORDER BY appointment_info.AppointmentDate ASC ',
			 NULL
			);
$res=$db->getResult();
return $res;
}

function cancelAppointment($app_id)
{
	$subject='Your Appointment has been CANCELLED by you.';
		  $Status="Cancelled by you";
		  
		  $db= new Database();
 		  $db->connect();
		  $db->select('appointment_info',' * ',NULL,'AppointmentId='.$app_id.'');
		  $appData=$db->getResult();
		  $db->select('userregistration','user_email,contactNumber',NULL,'userID='.$appData[0]['PatientId'].'');
		  $patientData=$db->getResult();
		  $db->update('appointment_info',array('AppointmentStatus' => "4"),'AppointmentId = "'.$app_id.'"');
		 
          //UpdateAppointmentStatistics('rejected',$doc_id);
          $doc_id=$appData[0]['DoctorId'];
          UpdateAppointmentStatistics('cancelled',$appData[0]['DoctorId']);		 
		  $db->select('doctor_info','DisplayName',NULL,'doc_id='.$doc_id.'');
		  $doctorData=$db->getResult();
		  //print_r($doctorData);exit();
		  if(isset($patientData[0]['user_email'])==true){
		  StatusChangeVerification($patientData[0]['user_email'],$doctorData[0]['DisplayName'],$appData[0]['AppointmentSlot'],$appData[0]['AppointmentDate'],$subject,"Cancelled by the Doctor");
		  } 
		 
		 //StatusChangeVerification($result[0]['user_email'],$doctor_schedule_displayname[0]['DisplayName'],$slot,$app_date,$subject,"Waiting for Doctor Confirmation");
		  newapi_SMSNotify_AppointmentStatus($patientData[0]['contactNumber'],$appData[0]['AppointmentSlot'],$appData[0]['AppointmentDate'],$doctorData[0]['DisplayName'],$Status);
		 
}
?>
