<?php

function sendPushToiOSDevice($deviceToken, $message)
{

$deviceToken = str_replace(' ', '', $deviceToken);
$deviceToken = str_replace('<', '', $deviceToken);
$deviceToken = str_replace('>', '', $deviceToken);	
// Put your private key's passphrase here:
$passphrase = 'pushios';

$ctx = stream_context_create();
stream_context_set_option($ctx, 'ssl', 'local_cert', 'PushIOS.pem');
stream_context_set_option($ctx, 'ssl', 'passphrase', $passphrase);

// Open a connection to the APNS server
$fp = stream_socket_client(
	'ssl://gateway.sandbox.push.apple.com:2195', $err,
	$errstr, 60, STREAM_CLIENT_CONNECT|STREAM_CLIENT_PERSISTENT, $ctx);

if (!$fp)
	exit("Failed to connect: $err $errstr" . PHP_EOL);

echo 'Connected to APNS' . PHP_EOL;

// Create the payload body
$payload['location_id'] = "3489";
$body['aps'] = array(
	'alert' => $message,
	'sound' => 'default',
	'badge'=> 6
	);
$payload['aps'] = $body['aps'];

// Encode the payload as JSON
$payload = json_encode($payload);

// Build the binary notification
$msg = chr(0) . pack('n', 32) . pack('H*', $deviceToken) . pack('n', strlen($payload)) . $payload;

// Send it to the server
$result = fwrite($fp, $msg, strlen($msg));

if (!$result)
	echo 'Message not delivered' . PHP_EOL;
else
	echo 'Message successfully delivered' . PHP_EOL;

// Close the connection to the server
fclose($fp);
}