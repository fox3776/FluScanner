<?php
if($_POST){
    if(isset($_POST['SwabPatient'])){
        DataCollection();
    }
    elseif(isset($_POST['NonSwabPatient'])){
        NonSwabPatient();
    }elseif(isset($_POST['GenerateCode'])){
        GenerateCode();
    }
    elseif(isset($_POST['Send'])){
        updateInfo();
    }
    elseif(isset($_POST['SendNoSwab'])){
        updateNoSwab();
    }
}
function updateInfo(){
session_start();
$apiKey = $_SESSION["apiKey"];
$seasonal = $_SESSION["seasonal"];
$prevaccine = $_SESSION["prevaccine"];
$dateofvac = $_SESSION["dateofvac"];
$dateofonset = $_SESSION["dateofonset"];
$recorded = $_SESSION["recorded"];
$healthworker = $_SESSION["healthworker"];
$fever = $_SESSION["fever"];
$patientNo = $_SESSION["patientNo"];
$measured = $_SESSION["measured"];
$gender = $_SESSION["gender"];
$dob = $_SESSION["dob"];
if ($measured!=null) {
    $url = 'http://192.168.1.123/task/v1/index.php/swab';
    // $url = 'http://10.12.22.117/task/v1/index.php/swabPatient';
$data = array('patient_id' => $patientNo, 'dob' => $dob,'gender' => $gender, 'seasonal' => $seasonal, 'prevaccine' => $prevaccine, 'dateofvac' => $dateofvac, 'recorded' => $recorded, 'dateofonset' => $dateofonset, 'healthworker' => $healthworker, 'fever' => $fever, 'measured' => $measured);

// use key 'http' even if you send the request to https://...
$options = array(
    'http' => array(
        'header'  =>"Content-type: application/x-www-form-urlencoded\r\n"."Authorization: ".$apiKey."\r\n",
        'method'  => 'POST',
        'content' => http_build_query($data)
        )
    );
$context  = stream_context_create($options);
$result = file_get_contents($url, false, $context);
if ($result === FALSE) { /* Handle error */ }
$content = json_decode($result,true);
$message = $content["message"];
echo "<script> alert('".$message."');parent.location.href='http://192.168.1.102:8000/Users/taohanyao/Documents/workspace/react/Selection.php'; </script>";
}else{
    $url = 'http://192.168.1.123/task/v1/index.php/swabNoFever';
    // $url = 'http://10.12.22.117/task/v1/index.php/swabNoFever';
$data = array('patient_id' => $patientNo, 'dob' => $dob,'gender' => $gender, 'seasonal' => $seasonal, 'prevaccine' => $prevaccine, 'dateofvac' => $dateofvac, 'recorded' => $recorded, 'dateofonset' => $dateofonset, 'healthworker' => $healthworker, 'fever' => $fever);

// use key 'http' even if you send the request to https://...
$options = array(
    'http' => array(
        'header'  =>"Content-type: application/x-www-form-urlencoded\r\n"."Authorization: ".$apiKey."\r\n",
        'method'  => 'POST',
        'content' => http_build_query($data)
        )
    );
$context  = stream_context_create($options);
$result = file_get_contents($url, false, $context);
if ($result === FALSE) { /* Handle error */ }
$content = json_decode($result,true);
$message = $content["message"];
echo "<script> alert('".$message."');parent.location.href='http://192.168.1.102:8000/Users/taohanyao/Documents/workspace/react/Selection.php'; </script>";
}
}

function updateNoSwab(){
session_start();
$apiKey = $_SESSION["apiKey"];
$patientNo = $_SESSION["patientNo"];
$gender = $_SESSION["gender"];
$dob = $_SESSION["dob"];
$url = 'http://192.168.1.123/task/v1/index.php/patientNoFlu';
$data = array('patient_id' => $patientNo, 'dob' => $dob,'gender' => $gender);
$options = array(
    'http' => array(
        'header'  =>"Content-type: application/x-www-form-urlencoded\r\n"."Authorization: ".$apiKey."\r\n",
        'method'  => 'POST',
        'content' => http_build_query($data)
        )
    );
$context  = stream_context_create($options);
$result = file_get_contents($url, false, $context);
if ($result === FALSE) { /* Handle error */ }
$content = json_decode($result,true);
$message = $content["message"];
echo $message;
echo "<script> alert('".$message."');parent.location.href='http://192.168.1.102:8000/Users/taohanyao/Documents/workspace/react/Selection.php'; </script>";
}

function DataCollection()
{
    session_start();
    $apiKey = $_SESSION["apiKey"];
    $url = 'http://192.168.1.123/task/v1/index.php/newID';
    $options = array(
    'http' => array(
        'header'  =>"Content-type: application/x-www-form-urlencoded\r\n"."Authorization: ".$apiKey."\r\n",
        'method'  => 'GET',
        // 'content' =>
        )
    );
$context  = stream_context_create($options);
$result = file_get_contents($url, false, $context);
if ($result === FALSE) { /* Handle error */ }
$content = json_decode($result,true);
$id = $content["id"];
   header("Location: http://192.168.1.102:8000/Users/taohanyao/Documents/workspace/react/QRcodeBuild.html?".$id);
}
function NonSwabPatient()
{
    session_start();
    $apiKey = $_SESSION["apiKey"];
    $url = 'http://192.168.1.123/task/v1/index.php/newID';
    $options = array(
    'http' => array(
        'header'  =>"Content-type: application/x-www-form-urlencoded\r\n"."Authorization: ".$apiKey."\r\n",
        'method'  => 'GET',
        // 'content' =>
        )
    );
$context  = stream_context_create($options);
$result = file_get_contents($url, false, $context);
if ($result === FALSE) { /* Handle error */ }
$content = json_decode($result,true);
$id = $content["id"];
   header("Location: http://192.168.1.102:8000/Users/taohanyao/Documents/workspace/react/NonSwabPatient.html?".$id);
}

function GenerateCode()
{
    session_start();
    $apiKey = $_SESSION["apiKey"];
    $url = 'http://192.168.1.123/task/v1/index.php/code';
    // $url = 'http://10.12.22.117/task/v1/index.php/code';
    // $data = "array()";

// use key 'http' even if you send the request to https://...
    $options = array(
        'http' => array(
            'header'  => "Content-type: application/x-www-form-urlencoded\r\n"."Authorization: ".$apiKey."\r\n",
            'method'  => 'POST',
            'content' => ''
            )
        );
    $context  = stream_context_create($options);
    $result = file_get_contents($url, false, $context);
    if ($result === FALSE) { /* Handle error */ }
    $content = json_decode($result,true);
    $code = $content["code"];
    $error = $content["error"];

    echo "<script> alert('Your Activation Code is: ".$code."');parent.location.href='http://192.168.1.102:8000/Users/taohanyao/Documents/workspace/react/Selection.php'; </script>";
}

?>


