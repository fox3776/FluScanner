function showtext(show){
if(show){
document.getElementById("specify").style.display = "";
}else{
document.getElementById("specify").style.display = "none";
}
}
function setpid(){
    // document.getElementById("patientNo").value = "yyy";
var pid = window.location.href.split("?")[1];
document.getElementById("patientNo").value = pid;
}
function readonly(writable,name){

    if (writable) {
        document.getElementById(name).readOnly = false;
    }
    else{
     document.getElementById(name).readOnly = true;
     document.getElementById(name).value = "";
    }
}
function ShowHits(){
   if (QRCode.seasonal.value == "") {
    alert("Please fill 'Seasonal flu vaccination this year'!");
   }
   else if (QRCode.gender.value == "") {
    alert("Please fill 'Gender'!");
   }
   else if (QRCode.dob.value == "") {
    alert("Please fill 'Date of birth'!");
   }
   else if (QRCode.dateofvac.value == "") {
     alert("Please fill 'Date of vaccination'!");
   }
   else if (QRCode.prevaccine.value == "") {
     alert("Please fill 'Flu vaccine in previous year'!");
   }
   else if (QRCode.dateofonset.value == "") {
     alert("Please fill 'Date of onset'!");
   }
   else if (QRCode.recorded.value == "") {
     alert("Please fill 'Recorded as ILI patient'!");
   }
   // else if (QRCode.comorbidity.value == "") {
   //   alert("Please fill 'Co-morbidity recommended for flu vaccination'!");
   // }
   else if (QRCode.healthworker.value == "") {
     alert("Please fill 'Health Care Worker'!");
   }
   else if (QRCode.fever.value == "") {
     alert("Please fill 'Fever'!");
   }
   else if (QRCode.patientNo.value == "") {
     alert("Please fill 'Patient Number'!");
   }
   // else if (QRCode.measured.value == "") {
   //   alert("Please fill 'Measured'!");
   // }
   else QRCode.submit();

}

function ShowHits1(){
   if (QRCode.gender.value == "") {
    alert("Please fill 'Gender'!");
   }
   else if (QRCode.dob.value == "") {
    alert("Please fill 'Date of birth'!");
   }
   else if (QRCode.patientNo.value == "") {
     alert("Please fill 'Patient Number'!");
   }
   // else if (QRCode.measured.value == "") {
   //   alert("Please fill 'Measured'!");
   // }
   else QRCode.submit();

}

//