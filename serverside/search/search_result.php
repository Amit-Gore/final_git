<?php          
error_reporting(0);
ini_set('display-errors','on');
include_once("DoctorSearchModuleFunctions.php");
include_once("../mysql_crud.php");


# The request is a JSON request.
# We must read the input.
# $_POST or $_GET will not work!

$data = file_get_contents("php://input");
$objData = json_decode($data);
//print_r($objData);exit();
//$objData->data="jagtap";
if(isset($objData->speciality)or isset($objData->area) )
{
	if(isset($objData->speciality))
	$objData->speciality=htmlspecialchars($objData->speciality);
	if(isset($objData->area))
	$objData->area=htmlspecialchars($objData->area);
	
	$resultArray=SearchBySpecialityAndArea2($objData->speciality,$objData->area,0,100);
	$resultArray=json_encode($resultArray);
    print_r($resultArray);
	exit();
}
if(isset($objData->data))
$objData->data=htmlspecialchars($objData->data);

$resultArray=SearchByName2($objData->data,0,100);
$resultArray=json_encode($resultArray);
print_r($resultArray);



?>