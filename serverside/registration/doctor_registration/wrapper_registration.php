<?php
/*
 * Created on Feb 24, 2015
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 session_start();
include_once('../../mysql_crud.php');
include_once('../../notifications/NotificationModuleFunctions.php');
include_once('../../PHPMailer/PHPMailerAutoload.php');
$data = file_get_contents("php://input");
$objData = json_decode($data);

$email=htmlspecialchars($objData->email);
$firstname=htmlspecialchars($objData->firstname);
$lastname=htmlspecialchars($objData->lastname);
$gender=htmlspecialchars($objData->gender);
$address=htmlspecialchars($objData->address);
$about=htmlspecialchars($objData->about);
$contact_no=htmlspecialchars($objData->contact_no);
$last_degree=htmlspecialchars($objData->last_degree);
$speciality=htmlspecialchars($objData->speciality);
$experience=htmlspecialchars($objData->experience);
$fees=htmlspecialchars($objData->fees);
$displayname="{$firstname} {$lastname}";
$ss_name="{$firstname}{$lastname}";

$lat=NULL;
$lng=NULL;
$url = "https://maps.googleapis.com/maps/api/geocode/xml?address=".$address."";
$xml = simplexml_load_file($url);
//print_r($xml);
$status = $xml->status;
	if ($xml and $status='OK') { //address has geocoded correctly, show results
	//echo ("The address can be geocoded, we found the following results:<br/>");
	$lat = $xml->result->geometry->location->lat;
	$lng = $xml->result->geometry->location->lng;
	}
	else $_SESSION['error'] = "The Address cannot be geocoded";
	
$subject="Your login credentials for healthserve";
$password=rand(10000,700000);
sendPassword($email,$subject,$displayname,$password);
$email2="nagarhscc@gmail.com";
//sendPassword($email2,$subject,$FirstName,$password);

$password=crypt($password);
$displayname="{$firstname} {$lastname}";
$ss_name="{$firstname}{$lastname}";
// Lets attempt to move the file from its temporary directory to its new home

$db= new Database();
		  $db->connect();
		  $db->insert('doctor_info',array(
					  'email'=> $email 
		  			  ,'fee'=>$fees
		              ,'speciality'=>$speciality
		              ,'FirstName'=>$firstname
					  ,'LastName'=>$lastname
					  /*,'DocImage'=>$target_file #Which is email address as of now
					  */,'contact'=>$contact_no
					  ,'gender'=>$gender
					  ,'address'=>$address
					  ,'lat'=>$lat
					  ,'lng'=>$lng
					  ,'DisplayName'=>$displayname
					  ,'ss_name'=>$ss_name
					  ,'aboutdoctor'=>$about
					  ,'degree'=>$last_degree
					  ,'experience'=>$experience
					  ,'password'=>$password));
					 
$res = $db->getResult();

?>
