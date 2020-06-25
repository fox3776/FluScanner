<!DOCTYPE HTML>
<html>
<head>
<title></title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="Medical Appointment Form template Responsive, Login form web template,Flat Pricing tables,Flat Drop downs Sign up Web Templates,
 Flat Web Templates, Login sign up Responsive web template, SmartPhone Compatible web template, free web designs for Nokia, Samsung, LG, SonyEricsson, Motorola web design">
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<!-- Custom Theme files -->
<link href="css/wickedpicker.css" rel="stylesheet" type="text/css" media="all" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<!--fonts-->
<link href="//fonts.googleapis.com/css?family=Roboto:300,400,500,700" rel="stylesheet">
<link href="//fonts.googleapis.com/css?family=Droid+Sans:400,700" rel="stylesheet">
<!--//fonts-->
</head>
<body>
<!--background-->
<h1> Data Collection Form </h1>
    <div class="bg-agile">
    <div class="book-appointment">
    <h2>Date Collection Form</h2>
            <form action="#" method="post">
            <div class="left-agileits-w3layouts same">
            <div class="gaps">
                <p>Patient Number:</p>
                    <input type="text" name="patientNo"  placeholder="" required=""/>
            </div>
                <div class="gaps">
                <p>Flu vaccine in previous year:</p>
                <p>

                <input type="radio" name="prevaccine" value="True">YES
                <input type="radio" name="prevaccine" value="False">NO
                <input type="radio" name="prevaccine" value="Unsure">Unsure
                <input type="radio" name="prevaccine" value="Never Vaccinated">Never Vaccinated
                </p>
                <br>
                <br>

                </div>

                <div class="gaps">
                <p>Recorded as ILI patient:</p>
                <p>

                    <input type="radio" name="recorded" value="True">YES
                    &nbsp&nbsp&nbsp&nbsp
                    <input type="radio" name="recorded" value="False">NO</p>
                <br>
                <br>
            </div>

                <div class="gaps">
                <p>Health Care Worker:</p>
                <p>
                    <input type="radio" name="healthworker" value="True">YES
                    &nbsp&nbsp&nbsp&nbsp
                    <input type="radio" name="healthworker" value="False">NO
                    <br>
                    <br>
                    <br>
                    </p>
            </div>

                <div class="gaps">
                <p>Co-morbidity recommended for flu vaccination:</p>
                    <p>

                    <input type="radio" name="comorbidity" value="True" onClick="showtext(true);">YES
                    &nbsp&nbsp&nbsp&nbsp
                    <input type="radio" name="comorbidity" value="False" onClick="showtext(false);">NO
                    </p>
                <br>
                <br>
                </div>




            </div>
            <div class="right-agileinfo same">
            <div class="gaps">
            <p>Seasonal flu vaccination this year:</p>

                <p><input type="radio" name="seasonal"  value="True">YES
                &nbsp&nbsp&nbsp&nbsp
                <input type="radio" name="seasonal"  value="False">NO</p>
                <br>
                <br>
            </div>
            <div class="gaps">
                <p>Date of vaccination:</p>
                        <input type="date" name="dateofvac" placeholder="" required />
            </div>

            <div class="gaps">
                <p>Date of onset:</p>
                        <input type="date" name="dateofonset" placeholder="" required/>
                </div>


            <div class="gaps">
                <p>Fever:</p>
                <p>
                    <input type="radio" name="fever" value="True">YES
                    &nbsp&nbsp&nbsp&nbsp
                    <input type="radio" name="fever" value="False">NO
                    </p>
                    <br>
                    <br>

            </div>
            <div class="gaps">
                <p>Measured:&nbsp&nbsp&nbsp(&#176C)</p>
                <p>
              <input type="text" name="measured">
                </p>
            </div>
            </div>
            <div class="gaps">
                <p>Special:</p>
                    <input type="text" name="specify" id="specify" style="display:none">
            </div>
            <div class="clear"></div>
                <p><button type="button" onClick="ShowHits()">Submit</button></p>
<!--                          <input type="submit" value="Make an appointment">-->
            </form>
        </div>
   </div>
   <!--copyright-->

            <div class="copy w3ls">
               <p>&copy; 2017. Medical Appointment Form . All Rights Reserved  | Design by <a href="http://w3layouts.com/" target="_blank">W3layouts</a> </p>
            </div>

        <!--//copyright-->

        <script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
        <script type="text/javascript" src="js/wickedpicker.js"></script>
            <script type="text/javascript">
                $('.timepicker').wickedpicker({twentyFour: false});
            </script>

        <!-- Calendar -->

                <link rel="stylesheet" href="css/jquery-ui.css" />
                <script src="js/jquery-ui.js"></script>
                  <script>
                          $(function() {
                            $( "#datepicker,#datepicker1,#datepicker2,#datepicker3" ).datepicker();
                          });
                  </script>

            <!-- //Calendar -->

</body>
</html>