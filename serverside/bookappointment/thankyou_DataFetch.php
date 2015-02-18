<?php
session_start();
include_once('../mysql_crud.php');
$data = file_get_contents("php://input");
$objData = json_decode($data);

$app_id=htmlspecialchars($objData->app_id);
$doc_id=htmlspecialchars($objData->doc_id);
$patient_ID=$_SESSION['patient']['patientID'];
$db= new Database();
$db->connect();

// $db->sql("select appointment_info.AppointmentDate , appointment_info.AppointmentSlot, appointment_info.PatientName,appointment_info.Reason,doctor_info.DocImage,
          // doctor_info.DisplayName,doctor_info.address,doctor_info.area,doctor_info.lat,doctor_info.lng,doctor_info.speciality,doctor_info.fee,doctor_info.degree 
        // from appointment_info
		// LEFT JOIN doctor_info ON appointment_info.DoctorId = doctor_info.doc_id
		// where appointment_info.AppointmentId =".$app_id."");
$db->select('appointment_info','appointment_info.AppointmentDate , appointment_info.AppointmentSlot, appointment_info.PatientName,appointment_info.Reason,
             doctor_info.DocImage,doctor_info.DisplayName,doctor_info.address,doctor_info.area,doctor_info.lat,doctor_info.lng,doctor_info.speciality,doctor_info.fee,doctor_info.degree 
        ','doctor_info ON appointment_info.DoctorId = doctor_info.doc_id','appointment_info.AppointmentId ="'.$app_id.'"');
$res_app=$db->getResult();
$appointmentData=json_encode($res_app[0]);
print_r($appointmentData);
?>