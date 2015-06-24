<?php
// @Author: Ujjal Sutrra Dhar <self@ujjal.net>
// 6th May, 2015
// Interfacing with database

class dbhandler{
	public $connection;
	protected $host;
	protected $dbname;
	protected $dbuser;
	protected $dbpass;
    
	function dbhandler($h, $n, $u, $p){
        $this->host =  $h;
        $this->dbname = $n;
        $this->dbuser = $u;
        $this->dbpass = $p;
	}

	function connect(){
		$conn = mysqli_connect($this->host, $this->dbuser, $this->dbpass, $this->dbname) or die('not connecting');;
		return $conn;
    }

    function insertDeviceData($deviceData, $conn){
        $query =  "INSERT INTO devices (username, unique_id, os_type) VALUES ('".$deviceData["device_name"]."', '".$deviceData["token"]."', '".$deviceData["type"]."')";
    	$res = mysqli_query($conn, $query);
        $device_id = mysqli_insert_id($conn);
        $this->prefereanceData($device_id, $deviceData, $conn);
    }

    function prefereanceData($device_id, $deviceData, $conn){
    	$res = mysqli_query($conn, "INSERT INTO device_preference (device_id, pref_id, pref_value)VALUES ('".$device_id."', 1, 1)");
        $device_id = mysqli_insert_id($conn);
    }

    function getDeviceInfoById($id, $conn){
    	$query =  "SELECT * FROM devices as d Left Join device_preference as dp ON d.id = dp.device_id Where d.id = ".$id;
    	$result = mysqli_query($conn, $query);
         
         
    	if ($obj = mysqli_fetch_object($result))
        {
           return $obj;
        }
        return false;
    }

    function getAllDevices($conn){
        $query =  "SELECT * FROM devices as d Left Join device_preference as dp ON d.id = dp.device_id";
        $result = mysqli_query($conn, $query);
         
        $tokens = array();
         
        while ($obj = mysqli_fetch_object($result))
        {
           $tokens[] = $obj;
        }
        return $tokens;
    }

    function close($conn){
    	$conn->close();
    }
}
?>