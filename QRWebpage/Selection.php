<!DOCTYPE html>
<html>
<head>
    <title>Welcome <?php
    session_start();
    $firstname = $_SESSION["firstname"];
    $lastname = $_SESSION["lastname"];
    echo $firstname.".".$lastname;
    ?></title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
    <!-- Custom Theme files -->
    <link href="css/loginstyle.css" rel="stylesheet" type="text/css" media="all" />
    <!-- //Custom Theme files -->
    <!-- font-awesome icons -->
    <link href="css/font-awesome.css" rel="stylesheet">
    <!-- //font-awesome icons -->
    <!-- web font -->
    <link href="//fonts.googleapis.com/css?family=Roboto:100,100i,300,300i,400,400i,500,500i,700,700i,900,900i" rel="stylesheet">
    <!-- //web font -->
    <!-- jS -->
    <script src="js/jquery.min.js"></script>
    <script src="js/script.js"></script>

</head>
<body>
    <div class="main-agile">
        <h1>Welcome back, <?php
        $firstname = $_SESSION["firstname"];
        $lastname = $_SESSION["lastname"];
        echo $firstname.".".$lastname;
        ?></h1>
        <div id="w3ls_form" class="signin-form">
            <form id="signin" action="HandleSelection.php" method="post">
                <h3>Please select your option</h3>
                <br>
                <input type="submit" name= "GenerateCode" value="Generate Code">
                <br>
                <input type="submit" name= "SwabPatient" value="Patient With Swab">
                <br>
                <br>
                <input type="submit" name= "NonSwabPatient" value="Non-Swab Patient">

            </form>
        </div>
    </div>
</body>
</html>