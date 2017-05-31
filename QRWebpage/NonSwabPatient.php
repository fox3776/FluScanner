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
date_default_timezone_set('Australia/Victoria');
$patientNo = $_POST['patientNo']; //Patient Number
$gender = $_POST['gender']; //Patient's gender
$dob = date('d-M-Y', strtotime($_POST['dob']));; //Patient's date of birth
session_start();
$_SESSION["patientNo"] = $_POST['patientNo']; //Patient Number
$_SESSION["gender"] = $_POST['gender']; //Patient's gender
$_SESSION["dob"] = date('d-M-Y', strtotime($_POST['dob']));; //Patient's date of birth


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


</div>

<div class="clear"></div>
<input name="SendNoSwab" type="submit" value="Send">
</form>


</div>
</div>
</body>
</html>