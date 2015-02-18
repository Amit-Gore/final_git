<?php
//include_once('mysql_crud.php');

function InsertSchedule($doc_id,$DayId,$AvailableSlots)
{
	 //echo"Inside Insert Schedule";
	 if($doc_id)
 	 {
 	 $db=new Database();
     $db->insert('doctor_schedule',array($DayId=>$AvailableSlots,'DoctorId'=>$doc_id));
		  $res=$db->getResult();
 	 return true;
 	 }
 	 return false;
	
}



function UpdateSchedule($doc_id,$DayId,$AppCount,$AvailableSlots)
{
 	 if($doc_id)
 	 {
 	 $db=new Database();
     $db->update('doctor_schedule',array($DayId=>$AvailableSlots,'AppCount'=>$AppCount),'DoctorId='.$doc_id.'');
		  $res=$db->getResult();
 	 return true;
 	 }
 	 return false;
}


function FetchDoctorData($doc_id)
{
 $db=new Database();
		 $db->select('doctor_info','enquired,booked,cancelled',NULL,
					 'doc_id='.$doc_id.'',NULL);
            $res= $db->getResult();
			//print_r($res);
			return $res[0];
}

function UpdateAppointmentStatistics($updateString,$doc_id)
{ 
$db = new Database();
$db->connect();
$db->sql('UPDATE doctor_info 
    SET '.$updateString.' = '.$updateString.' + 1
    WHERE  doc_id = '.$doc_id.'');
$res = $db->getResult();
 return $res;
 
}

function FetchAppointmentsForConfirmation($doc_id)
{
	$db=new Database();
		 $db->select('appointment_info','AppointmentId,PatientId,AppointmentDate,AppointmentSlot,Reason,PatientName',NULL,
					 'DoctorId='.$doc_id.' AND (AppointmentDate >= CURDATE()) AND AppointmentStatus=1',NULL);
            $res = $db->getResult();
			//print_r($res);
			return $res;
}

function TodayFetchConfirmedAppointments($doc_id)
{
	$db=new Database();
		 $db->select('appointment_info','AppointmentId,PatientName,PatientId,AppointmentDate,AppointmentSlot,Reason',NULL,
					 'DoctorId='.$doc_id.' AND AppointmentDate =CURDATE() AND AppointmentStatus=2',NULL);
            $res = $db->getResult();
			//print_r($res);
			return $res;
}

function HistoryFetchAppointments($doc_id)
{
	$db=new Database();
		 $db->select('appointment_info','AppointmentId,PatientId,AppointmentDate,AppointmentSlot,Reason',NULL,
					 'DoctorId='.$doc_id.' AND  AppointmentStatus=5',NULL);
            $res = $db->getResult();
			//print_r($res);
			return $res;
}
//UpdateAppointmentStatistics('booked',3);
//TodayFetchConfirmedAppointments(3);
