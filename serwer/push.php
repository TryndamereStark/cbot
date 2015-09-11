<?php

$user = "mpMMEAMyEDdxzUpRGAtIC3EzBvc91olP"; //$_GET['user'];
$title = $_GET['title'];
$message = $_GET['message'];
$appName = "ClashBot - ";

curl_setopt_array($ch = curl_init(), array(
	CURLOPT_URL => "https://api.pushover.net/1/messages.json",
	CURLOPT_POSTFIELDS => array(
		"token" => "mpMMEAMyEDdxzUpRGAtIC3EzBvc91olP",
		"user" => $user,
		"title" => $appName.$title,
		"message" => $message,
		"sound" => $sound
	),
	CURLOPT_SAFE_UPLOAD => true,
));
curl_exec($ch);
curl_close($ch);

curl --header 'Authorization: Bearer <your_access_token_here>' -X POST https://api.pushbullet.com/v2/pushes --header 'Content-Type: application/json' --data-binary '{"type": "note", "title": "Note Title", "body": "Note Body"}'
