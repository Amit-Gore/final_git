<?php
error_reporting(E_ALL);
ini_set('display-errors','on');
//recent changes : mysql_escape_string implemented

//include_once('mysql_crud.php');

//$crud=new Database();
/*
Appointment Booking Module:
This module contains functions which basically 
*/

   
   //'". mysql_escape_string($name) ."',
   function StoreToAppointmentInfo($DocId,$PatientId,$AppointmentDate,$AppointmentSlot,$slotID,$Reason,$AppointmentStatus,$p_name)
   {
	 //echo $Reason;exit();
	 #if(CheckSlotAvailability($DocId,$AppointmentDate,$AppointmentSlot,$AppointmentSubSlot))
	 #{
		  $db= new Database();
		  $db->connect();
		  $db->insert('appointment_info',array('DoctorId'=> $DocId ,'PatientId'=>$PatientId
		              ,'AppointmentDate'=>$AppointmentDate
		              ,'AppointmentSlot'=>$AppointmentSlot
					  ,'slotID'=>$slotID
					  ,'Reason'=>$Reason
					  ,'PatientName'=>$p_name
					  ,'AppointmentStatus'=>$AppointmentStatus));
					 
		  $res = $db->getResult();
		   #print_r($res);exit();
		  $db->disconnect();
		  return $res;
	      //extendible: If appointment has been booked,run the mail script to patient
		  //And notify the Doctor
	 #}
   }
   
   function CancelAppointment($AppointmentId)
   {
      $db= new Database();
	  //$db->connect();
	  $db->delete('appointment_info','AppointmentId="'.mysql_escape_string($AppointmentId).'"');
	  $res = $db->getResult();
	  //$db->disconnect();
      //print_r($res);
	  return $res;
	  
   }
   
   
   function ChangeAppointmentSchedule($IsRescheduleByDoc,$AppointmentId,$AppointmentDate,$AppointmentSlot,$AppointmentSubSlot)
   {
	
		  $db= new Database();
		  //$db->connect();
		  $db->select('appointment_info','DoctorId,PatientId,Reason,AppointmentStatus',NULL,'AppointmentId="'.$AppointmentId.'"');
		  $res=$db->getResult();
		  //var_dump($res);
		print_r($res[0]['AppointmentStatus']);
		if($res[0]['AppointmentStatus']=="completed"
		   ||$res[0]['AppointmentStatus']=="rejected"
		   ||$res[0]['AppointmentStatus']=="cancelled")
		 {
		   echo"Makes no sense!";
		   //$db->disconnect();
		   return false;
		 }
				
		if($res[0]['AppointmentStatus']=="confirmed"||$res[0]['AppointmentStatus']=="WaitingForPatient")
		{
			echo"Confirmed/WaitingForPatient Block ";
			if($IsRescheduleByDoc==true AND $res[0]['AppointmentStatus']=="confirmed")// Doctor is re-scheduling the confirmed appointment
					{
					   
					   BookAppointment($res[0]['DoctorId'],$res[0]['PatientId'],$AppointmentDate,$AppointmentSlot,$AppointmentSubSlot,$res[0]['Reason'],'WaitingForPatient');
					   CancelAppointment($AppointmentId);
					   //$db->disconnect();
					   return true;
					   /*NotifyPatient(); 
						and after the patient's response,change the appointment 
						status accordingly via calling ChangeAppointmentStatus()function*/
					}
			else if ($IsRescheduleByDoc==true AND $res[0]['AppointmentStatus']=="WaitingForPatient")
					{
					   BookAppointment($res[0]['DoctorId'],$res[0]['PatientId'],$AppointmentDate,$AppointmentSlot,$AppointmentSubSlot,$res[0]['Reason'],'WaitingForPatient');
					   CancelAppointment($AppointmentId);
					   //$db->disconnect();
					   return true;
					   /*Don't need to notify patient as status is already 'WaitingForPatient'*/
					}
		    else  //Patient is re-scheduling the confirmed Appointment
					{
					   
					   BookAppointment($res[0]['DoctorId'],$res[0]['PatientId'],$AppointmentDate,$AppointmentSlot,$AppointmentSubSlot,$res[0]['Reason'],'WaitingForDoctor');
					   CancelAppointment($AppointmentId);
					   //$db->disconnect();
					   return true;
					   /*NotifyDoctor(); 
						and after the Doctor's response,change the appointment 
						status accordingly via calling ChangeAppointmentStatus()function*/	
					}							
		}
		
		if($res[0]['AppointmentStatus']=="WaitingForDoctor")
		{
		   echo"WaitingForDoctor block ";
		   BookAppointment($res[0]['DoctorId'],$res[0]['PatientId'],$AppointmentDate,$AppointmentSlot,$AppointmentSubSlot,$res[0]['Reason'],'WaitingForDoctor');
		   CancelAppointment($AppointmentId);
		   //$db->disconnect();
		   return true;
		}
	
	}
   
   function ChangeAppointmentStatus($AppointmentId,$AppointmentStatus)
   {
		  $db= new Database();
		  //$db->connect();
		  /*Mistake for upate command ...check out !*/
		  $db->update('appointment_info',array('AppointmentStatus'=>'". mysql_escape_string($AppointmentStatus)."','AppointmentId="'.$AppointmentId.'"'));
		  $res=$db->getResult();
		  if($res[0]){//$db->disconnect();
						return true;}
		  else {//$db->disconnect();
					return false;}
   }
  
   
   

?>