<html>
<head>
    <title>QRCodeBuild</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <!-- Custom Theme files -->
    <link href="css/wickedpicker.css" rel="stylesheet" type="text/css" media="all" />
    <link href="css/generatestyle.css" rel="stylesheet" type="text/css" />
    <!--fonts-->
    <link href="//fonts.googleapis.com/css?family=Roboto:300,400,500,700" rel="stylesheet">
    <link href="//fonts.googleapis.com/css?family=Droid+Sans:400,700" rel="stylesheet">
    <script src="InputCheck.js"></script>
    <!--//fonts-->
</head>
<body>
    <?php
    include('phpqrcode/qrlib.php');
    $errorCorrectionLevel = 'H';
    $matrixPointSize = 10;
    date_default_timezone_set('Australia/Victoria');
$seasonal = $_POST['seasonal']; //Seasonal flu vaccination this year
$prevaccine = $_POST['prevaccine']; //Flu vaccine in previous year
$dateofvac = date('d-M-Y', strtotime($_POST['dateofvac'])); //Date of vaccination
$dateofonset = date('d-M-Y', strtotime($_POST['dateofonset'])); //Date of onset
$recorded = $_POST['recorded']; //Recorded as ILI patient
// $comorbidity = $_POST['comorbidity']; //Co-morbidity recommended for flu vaccination
// $specify = $_POST['specify']; //Specify of Co-morbidity
$healthworker = $_POST['healthworker']; //Health Care Worker
$fever = $_POST['fever'];
$patientNo = $_POST['patientNo']; //Patient Number
$measured = $_POST['measured']; //Patient's temperature
$gender = $_POST['gender']; //Patient's gender
$dob = date('d-M-Y', strtotime($_POST['dob']));; //Patient's date of birth
session_start();
$_SESSION["seasonal"] = $_POST['seasonal']; //Seasonal flu vaccination this year
$_SESSION["prevaccine"] = $_POST['prevaccine']; //Flu vaccine in previous year
$_SESSION["dateofvac"] = date('d-M-Y', strtotime($_POST['dateofvac'])); //Date of vaccination
$_SESSION["dateofonset"] = date('d-M-Y', strtotime($_POST['dateofonset'])); //Date of onset
$_SESSION["recorded"] = $_POST['recorded']; //Recorded as ILI patient
// $comorbidity = $_POST['comorbidity']; //Co-morbidity recommended for flu vaccination
// $specify = $_POST['specify']; //Specify of Co-morbidity
$_SESSION["healthworker"] = $_POST['healthworker']; //Health Care Worker
$_SESSION["fever"] = $_POST['fever'];
$_SESSION["patientNo"] = $_POST['patientNo']; //Patient Number
$_SESSION["measured"] = $_POST['measured']; //Patient's temperature
$_SESSION["gender"] = $_POST['gender']; //Patient's gender
$_SESSION["dob"] = date('d-M-Y', strtotime($_POST['dob']));; //Patient's date of birth


QRcode::png($patientNo, $patientNo.'_'.'qrcode.png', $errorCorrectionLevel, $matrixPointSize, 2);
// echo '<img src="'.$tempDir.$patientNo.'qrcode.png" />';
$logo = 'logo.png';
$QR = $patientNo.'_'.'qrcode.png';
if ($logo !== FALSE) {
    $QR = imagecreatefromstring(file_get_contents($QR));
    $logo = imagecreatefromstring(file_get_contents($logo));
    $QR_width = imagesx($QR);//二维码图片宽度
    $QR_height = imagesy($QR);//二维码图片高度
    $logo_width = imagesx($logo);//logo图片宽度
    $logo_height = imagesy($logo);//logo图片高度
    $logo_qr_width = $QR_width / 5;
    $scale = $logo_width/$logo_qr_width;
    $logo_qr_height = $logo_height/$scale;
    $from_width = ($QR_width - $logo_qr_width) / 2;
    //重新组合图片并调整大小
    imagecopyresampled($QR, $logo, $from_width, $from_width, 0, 0, $logo_qr_width,
        $logo_qr_height, $logo_width, $logo_height);
}
//输出图片
imagepng($QR, 'QRcode/'.$patientNo.'_'.'qrcodelogo.png');


?>
<!--background-->
<h1> Date Collection Form </h1>
<div class="bg-agile">
    <div class="book-appointment">
        <h2>Date Collection Form</h2>
        <form action="HandleSelection.php" method="post" name = "QRCode">
            <div class="left-agileits-w3layouts same">
                <div class="gaps">
                    <p>Patient Number:</p>
                    <p>
                        <?php if (!is_null($patientNo))
                        echo $patientNo;
                        else
                          echo "nothing was selected."; ?>
                  </p>
                  <br>

              </div>
              <div class="gaps">
                <p>Gender:</p>
                <p>
                    <?php if (!is_null($gender))
                    echo $gender;
                    else
                      echo "nothing was selected."; ?>
              </p>
              <br>
          </div>
          <div class="gaps">
            <p>Flu vaccine in previous year:</p>
            <p>
                <?php if (!is_null($prevaccine))
                echo $prevaccine;
                else
                  echo "nothing was selected."; ?>
          </p>
          <br>

      </div>

      <div class="gaps">
        <p>Recorded as ILI patient:</p>
        <p>

            <?php if (!is_null($recorded))
            echo $recorded;
            else
              echo "nothing was selected."; ?></p>
          <br>
      </div>
      <div class="gaps">
    <p>Fever:</p>
    <p>
        <?php if (!is_null($fever))
        echo $fever;
        else
          echo "nothing was selected."; ?>
  </p>
  <br>

</div>
<div class="gaps">
    <p>Measured:&nbsp&nbsp&nbsp(&#176C)</p>
    <p>
      <?php if (!is_null($patientNo))
      echo $patientNo."&#176C";
      else
          echo "nothing was selected.";
      ?>
  </p>
  <br>
</div>



<!--   <div class="gaps">
    <p>Co-morbidity recommended for flu vaccination:</p>
    <p>
        <?php if (!is_null($comorbidity))
        echo $comorbidity;
        else
          echo "nothing was selected."; ?>
  </p>
  <br>
</div>
<div class="gaps">
    <p>Special:</p>
    <p>
        <?php if (!is_null($specify))
        echo $specify;
        else
          echo "nothing was selected."; ?>
      <?php
        session_start();
        echo $_SESSION['apiKey'];
        ?>
  </p>
  <br>
</div> -->



</div>
<div class="right-agileinfo same">
    <div class="gaps">
        <p>Date of birth:</p>
        <p>
            <?php if (!is_null($dob))
            echo $dob;
            else
              echo "nothing was selected."; ?>
      </p>
      <br>
  </div>
  <div class="gaps">
    <p>Seasonal flu vaccination this year:</p>

    <p><?php if (!is_null($seasonal))
    echo $seasonal;
    else
      echo "nothing was selected."; ?></p>
  <br>
</div>
<div class="gaps">
    <p>Date of vaccination:</p>
    <p>
        <?php if (!is_null($dateofvac))
        echo $dateofvac;
        else
          echo "nothing was selected.";
      ?>
  </p>
  <br>
</div>

<div class="gaps">
    <p>Date of onset:</p>
    <p>
        <?php if (!is_null($dateofonset))
        echo $dateofonset;
        else
          echo "nothing was selected.";
      ?>  </p>
      <br>

  </div>

  <div class="gaps">
        <p>Health Care Worker:</p>
        <p>
            <?php if (!is_null($healthworker))
            echo $healthworker;
            else
              echo "nothing was selected."; ?>
      </p>
      <br>
  </div>




<div class="gaps">
    <p>
        <img src=<?php echo 'QRcode/'.$patientNo.'_'.'qrcodelogo.png' ?> width="148" height="148" alt="Sorry! Some error happened!"/>
    </p>
    <br>
</div>
</div>

<div class="clear"></div>
<input name="Send" type="submit" value="Send">
</form>


</div>
</div>
</body>
</html>