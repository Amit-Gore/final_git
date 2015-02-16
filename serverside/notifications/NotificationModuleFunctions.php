<?php
//include_once('mysql_crud.php');

function sendPassword($to,$subject,$FirstName,$password)
{
    //echo $to;exit();
 
	include_once 'PHPMailer/PHPMailerAutoload.php';
 
    $mail = new PHPMailer();
 
    $mail->isSMTP();
	$mail->SMTPDebug = 0;
    $mail->Debugoutput = 'html';
    $mail->Host = 'smtp.gmail.com';
    $mail->Port = 587;
    $mail->SMTPSecure = 'tls';
    $mail->SMTPAuth = true;
    $mail->Username = "healthserve.digital@gmail.com";
 
    $mail->Password = "Anurag@123";
 
    $mail->setFrom('healthserve.digital@gmail.com', 'HealthServe');
 
    //$mail->addReplyTo('replyto@example.com', 'First Last');
 
    $to=htmlspecialchars($to);
	$subject=htmlspecialchars($subject);
	//$password=rand(10000,700000);
	//$hash = md5( rand(0,1000) );
	$mail->addAddress("$to" , '');
    $mail->Subject = $subject;
	$message = '
 
Hello Dr. '.$FirstName.'
Following would be your login credentials:<br>
 
------------------------<br>
Username: '.$to.'<br>
Password: '.$password.'<br>
------------------------<br>
Thank you for being listed on HealthServe. 
 
';
    $mail->msgHTML($message, dirname(__FILE__));
 
    //$mail->AltBody = 'AltBody';
    if (!$mail->send()) {
        
		echo "Mailer Error: " . $mail->ErrorInfo;
		return false;
    } else {
        return true;
		//header('Location:hs_static.html',true);
    }
}


function StatusChangeVerification($to,$doctor,$time,$appdate,$subject,$status)
{
    //echo $to;exit();
    //include_once("../PHPMailer/PHPMailerAutoload.php");
 
    $mail = new PHPMailer();
 
    $mail->isSMTP();
	$mail->SMTPDebug = 0;
    $mail->Debugoutput = 'html';
    $mail->Host = 'smtp.gmail.com';
    $mail->Port = 587;
    $mail->SMTPSecure = 'tls';
    $mail->SMTPAuth = true;
    $mail->Username = "healthserve.digital@gmail.com";
 
    $mail->Password = "Anurag@123";
 
    $mail->setFrom('healthserve.digital@gmail.com', 'HealthServe');
 
    //$mail->addReplyTo('replyto@example.com', 'First Last');
 
    $to=htmlspecialchars($to);
	$subject=htmlspecialchars($subject);
	//$password=rand(10000,700000);
	//$hash = md5( rand(0,1000) );
	$mail->addAddress("$to" , '');
    $mail->Subject = $subject;
	$message = '
Hi, 
Following are the appointment details:<br>
 
------------------------<br>
Doctor Name: '.$doctor.'<br>
Date: '.$appdate.'<br>
Time: '.$time.'<br>
Status: '.$status.'<br>
------------------------<br>

 
';
    $mail->msgHTML($message, dirname(__FILE__));
 
    //$mail->AltBody = 'AltBody';
    if (!$mail->send()) {
        
		echo "Mailer Error: " . $mail->ErrorInfo;
		return false;
    } else {
        return true;
		//header('Location:hs_static.html',true);
    }
}

function SMSNotify_AppointmentStatus($number,$apptime,$appdate,$Doctor,$Status)
{
#echo $number.$apptime.$appdate.$Doctor.$Status;
$request =""; //initialise the request variable
$param['method']= "sendMessage";
$param['send_to'] = $number;
//$hash=$password;
//$param[login]=$hash;
$param['msg'] = "Hi,following are the updates for your appointment: 
Doctor:$Doctor, Appointment Date:$appdate,Time:$apptime,STATUS:$Status";
$param['userid'] = "2000126936";
$param['password'] = "healthserve";
$param['v'] = "1.1";
$param['msg_type'] = "TEXT"; //Can be "FLASHâ€�/"UNICOD E_TEXT"/â€�BINARYâ€�
$param['auth_scheme'] = "PLAIN";
//Have to URL encode the values 114986
foreach($param as $key=>$val) {
$request.= $key."=".urlencode($val);
//we have to urlencode the values
$request.= "&";
//append the ampersand (&) sign after each parameter/value pair
}
$request = substr($request, 0, strlen($request)-1);
//remove final (&) sign from the request
$url =
"http://enterprise.smsgupshup.com/GatewayAPI/rest?"
.$request;
#echo $request;
$ch = curl_init($url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$curl_scraped_page = curl_exec($ch);
curl_close($ch);
//echo $curl_scraped_page; 
}














function SMSNotify($number)
{
$request =""; //initialise the request variable
$param[method]= "sendMessage";
$param[send_to] = $number;
$param[msg] = "Hi Again! 15 mins left for your test. Pls submit a zip file of your code & CV to codetest@healthserve.in";
$param[userid] = "2000126936";
$param[password] = "healthserve";
$param[v] = "1.1";
$param[msg_type] = "TEXT"; //Can be "FLASHâ€�/"UNICOD E_TEXT"/â€�BINARYâ€�
$param[auth_scheme] = "PLAIN";
//Have to URL encode the values 114986
foreach($param as $key=>$val) {
$request.= $key."=".urlencode($val);
//we have to urlencode the values
$request.= "&";
//append the ampersand (&) sign after each parameter/value pair
}
$request = substr($request, 0, strlen($request)-1);
//remove final (&) sign from the request
$url =
"http://enterprise.smsgupshup.com/GatewayAPI/rest?"
.$request;
echo $request;
$ch = curl_init($url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$curl_scraped_page = curl_exec($ch);
curl_close($ch);
echo $curl_scraped_page; 
}


function SMSNotify_registration($number,$password)
{
$request =""; //initialise the request variable
$param['method']= "sendMessage";
$param['send_to'] = $number;
$hash=$password;
//$param[login]=$hash;
$param['msg'] = "Hey Good Luck! You have been registered for the UI/UX test @HealthServe.Your login credentials: 
password:$hash";
$param['userid'] = "2000126936";
$param['password'] = "healthserve";
$param['v'] = "1.1";
$param['msg_type'] = "TEXT"; //Can be "FLASHâ€�/"UNICOD E_TEXT"/â€�BINARYâ€�
$param['auth_scheme'] = "PLAIN";
//Have to URL encode the values 114986
foreach($param as $key=>$val) {
$request.= $key."=".urlencode($val);
//we have to urlencode the values
$request.= "&";
//append the ampersand (&) sign after each parameter/value pair
}
$request = substr($request, 0, strlen($request)-1);
//remove final (&) sign from the request
$url =
"http://enterprise.smsgupshup.com/GatewayAPI/rest?"
.$request;
echo $request;
$ch = curl_init($url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$curl_scraped_page = curl_exec($ch);
curl_close($ch);
//echo $curl_scraped_page; 
}

function SMSNotify_OTP($number,$otp)
{
$request =""; //initialise the request variable
$param['method']= "sendMessage";
$param['send_to'] = $number;
$hash=$otp;
//$param[login]=$hash;
$param['msg'] = "Welcome to Heathserve ! Please input the given OTP within 5 mins .Your OTP :$hash";
$param['userid'] = "2000126936";
$param['password'] = "healthserve";
$param['v'] = "1.1";
$param['msg_type'] = "TEXT"; //Can be "FLASHâ€�/"UNICOD E_TEXT"/â€�BINARYâ€�
$param['auth_scheme'] = "PLAIN";
//Have to URL encode the values 114986
foreach($param as $key=>$val) {
$request.= $key."=".urlencode($val);
//we have to urlencode the values
$request.= "&";
//append the ampersand (&) sign after each parameter/value pair
}
$request = substr($request, 0, strlen($request)-1);
//remove final (&) sign from the request
$url =
"http://enterprise.smsgupshup.com/GatewayAPI/rest?"
.$request;
echo $request;
$ch = curl_init($url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$curl_scraped_page = curl_exec($ch);
curl_close($ch);
//echo $curl_scraped_page; 
}



function SMSNotify_logout($number)
{
$request =""; //initialise the request variable
$param[method]= "sendMessage";
$param[send_to] = $number;
$param[msg] = "Dear Candidate,Pls submit a zip file of your code & CV to codetest@healthserve.in
We will definitely get back to you soon!";
$param[userid] = "2000126936";
$param[password] = "healthserve";
$param[v] = "1.1";
$param[msg_type] = "TEXT"; //Can be "FLASHâ€�/"UNICOD E_TEXT"/â€�BINARYâ€�
$param[auth_scheme] = "PLAIN";
//Have to URL encode the values 114986
foreach($param as $key=>$val) {
$request.= $key."=".urlencode($val);
//we have to urlencode the values
$request.= "&";
//append the ampersand (&) sign after each parameter/value pair
}
$request = substr($request, 0, strlen($request)-1);
//remove final (&) sign from the request
$url =
"http://enterprise.smsgupshup.com/GatewayAPI/rest?"
.$request;
echo $request;
$ch = curl_init($url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$curl_scraped_page = curl_exec($ch);
curl_close($ch);
echo $curl_scraped_page; 
}


?>