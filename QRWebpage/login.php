<?php
$email = $_POST['UserName'];
$password = $_POST['Password'];
$url = 'http://192.168.1.123/task/v1/index.php/login';
// $url = 'http://10.12.22.117/task/v1/index.php/login';
$data = array('email' => $email, 'password' => $password);

// use key 'http' even if you send the request to https://...
$options = array(
    'http' => array(
        'header'  => "Content-type: application/x-www-form-urlencoded\r\n",
        'method'  => 'POST',
        'content' => http_build_query($data)
        )
    );
$context  = stream_context_create($options);
$result = file_get_contents($url, false, $context);
if ($result === FALSE) { /* Handle error */ }

    $content = json_decode($result,true);
$apiKey = $content["apiKey"];
$error = $content["error"];
$firstname = $content["firstname"];
$lastname = $content["lastname"];
session_start();
$_SESSION["apiKey"] = $apiKey;
$_SESSION["firstname"] = $firstname;
$_SESSION["lastname"] = $lastname;


if ($error) {
    header("Location: http://192.168.1.102:8000/Users/taohanyao/Documents/workspace/react/login.html");
}
else{
    header("Location: http://192.168.1.102:8000/Users/taohanyao/Documents/workspace/react/Selection.php");
}

exit;
?>



