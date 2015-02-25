<?php
error_reporting(E_ALL);
ini_set('display-errors','on');
//include_once($_SERVER['DOCUMENT_ROOT'].'/angularFiles/Angularjs-Healthserve.in/serverside/mysql_crud.php');
//include_once('NotificationModuleFunctions.php');
//include_once('github_otp.php');

/* session_start();
$_SESSION['userID']=3; // for temporary use. Testing purpose
 */
	
function OTPgenerate_HMAC()
{
$key='12345678901234567890';
$window=60;
$length=5;

$result = HOTP::generateByTime($key, $window);
$string=$result->toHotp($length);
return $string;
 
}
function OTPgenerate()
{
  $str='';
  for($i=7;$i>0;$i--){
    $str = $str.chr(rand(97,122)); 

    /*  The above line concatenates one character at a time for
        seven iterations within the ASCII range mentioned.
        So, we get a seven characters random OTP comprising of
        all small alphabets. 
    */
	}
  return $str;
}


function new_api_OTPsend($mobilenumber)
{

  #echo $mobilenumber;
  $string=OTPgenerate();
  /*$r = new HttpRequest('http://apivm.valuemobo.com/SMS/SMS_ApiKey.asmx/SMS_APIKeyNUC?apiKey=KsRsJ0x7Zwjys1E&cellNoList="8149426686"&msgText=HiAmitGore&senderId=HSCCLN', HttpRequest::METH_GET);
  try {
    $r->send();
    
	 } catch (HttpException $ex) {
     echo $ex;
     }*/
  $ch = curl_init("http://apivm.valuemobo.com/SMS/SMS_ApiKey.asmx/SMS_APIKeyNUC?apiKey=KsRsJ0x7Zwjys1E&cellNoList=".$mobilenumber."&msgText=Your+OTP+is%3A".$string."&senderId=HSCCLN");
  curl_exec($ch);
  curl_close($ch);
  return $string;
}
function OTPsend($mobilenumber)
{

  #echo $mobilenumber;
  $string=OTPgenerate();
  //echo $string;
   SMSNotify_OTP($mobilenumber,$string);
  return $string;
}

function OTPcheck($inputOTP,$mobilenumber)
{
   #echo $mobilenumber;
   $db= new Database();
   $db->connect();
   $db->select('userregistration','OTP',NULL,'contactNumber='.$mobilenumber.'');
   $res=$db->getResult();
   #print_r($res);
	   if(crypt($inputOTP,$res[0]['OTP'])==$res[0]['OTP']) 
	   { 
	     $db->update('userregistration',array('OTPverified'=>1),'contactNumber="'.$mobilenumber.'"');
		 return true;
	   }
   else return false;
   
}
