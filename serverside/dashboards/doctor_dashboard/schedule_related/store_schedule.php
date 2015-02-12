<?php
/*
 * Created on Feb 9, 2015
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
  session_start();
include_once('../../mysql_crud.php');
$data = file_get_contents("php://input");
$objData = json_decode($data);

 
?>
