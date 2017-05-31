<?php
$email = $_POST['Email'];
$password = $_POST['Password'];
$firstname = $_POST['firstname'];
$lastname = $_POST['lastname'];
$username = $_POST['UserName'];

$url = 'http://192.168.1.123/task/v1/index.php/register';
$data = array('firstname' => $firstname, 'lastname' => $lastname,'username' => $username, 'email' => $email, 'password' => $password);

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
$message = $content["message"];

echo "<script> alert('".$message."');parent.location.href='http://192.168.1.102:8000/Users/taohanyao/Documents/workspace/react/login.html'; </script>";
?>