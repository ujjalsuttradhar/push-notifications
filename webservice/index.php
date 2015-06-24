<?php
// @Author: Ujjal Sutrra Dhar <self@ujjal.net>
// 6th May, 2015
// Service to provide push notification to both iOS and Android devices
error_reporting(E_ALL); 
ini_set('display_errors',1);

//Include database handler class
include 'classes/db.php';

//Connect Database
$db = new dbhandler('localhost', 'push_notification', 'root', 'ujjal123!');
$conn = $db->connect();

if(!$conn)
  echo "Connection Error \n";
else 
  echo "Successfully Connected to Database. \n";
 

if(isset($_GET["action_type"]))
{    
	if($_GET["action_type"] == "deviceInfo")
	{
	   $deviceData = $_REQUEST;
	   $db->insertDeviceData($deviceData, $conn);
	   echo "Success\n";
	}
	else if($_GET["action_type"] == "sendpush")
	{
          $deviceID = $_POST['device_id'];
          $deviceInfo = $db->getDeviceInfoById($deviceID, $conn);
 
    // Put your alert message here:
    $message = 'High Temperature in Refrigerator!!!';

 	  if($deviceInfo->os_type == 'iOS'){
          include 'classes/send_push_service_ios.php';
          sendPushToiOSDevice($deviceInfo->unique_id, $message);
      	}
      else {
          include 'classes/send_push_service_android.php';
          sendPushToAndroidDevice($deviceInfo->unique_id, $message);
      }
    }
 exit;    
}


show_device_list($db, $conn);

function show_device_list($db, $conn){
   $tokens = $db->getAllDevices($conn);
   include 'push_form.php';
}


$db->close($conn);
?>