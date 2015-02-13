<?php
/*
 * Created on Jan 23, 2015
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
$data = file_get_contents("php://input");
$objData = json_decode($data);
$doc_id=$objData->data;
error_reporting(E_ALL);
ini_set('display-errors','on');
include_once("../dashboards/doctor_dashboard/schedule_related/scheduleFunctions.php");
include_once("../mysql_crud.php");
$php_to_json=availableSchedule($doc_id,3,0);
print_r(json_encode($php_to_json));		

	 ?>
