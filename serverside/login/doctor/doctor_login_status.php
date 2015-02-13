<?php
/*
 * Created on Feb 13, 2015
 *
 * To change the template for this generated file go to
 * Window - Preferences - PHPeclipse - PHP - Code Templates
 */
 session_start();
 $user=array();
 if(isset($_SESSION['doctor']))
 {
    	 
    	 $user=array();
		       $user['DFirstName']=$_SESSION['doctor']['DFirstName'];
		 	   $user['DLastName']=$_SESSION['doctor']['DLastName'];
		 	   $user['doctorID']=$_SESSION['doctor']['doc_id'];
		 	   $user['doctorImage']=$_SESSION['doctor']['DocImage'];
		 	   print_r(json_encode($user));
 }
 else{
 	
 	return false;
 }
?>
