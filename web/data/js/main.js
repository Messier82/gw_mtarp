var regStatus = new Array();

function regStatus(field, status){
	regStatus[field] = status;
}

function regCheckLogin(){

$.ajax({
type: "POST",
processdata: false,
global: false,
url: "register.php?do=login&var="+$("#regLogin").val()+"",
success: function(data){
$("#regResLogin").html(data);
}
});

}

function regCheckPass(){

$.ajax({
type: "POST",
processdata: false,
global: false,
url: "register.php?do=pass&var="+$("#regPass").val()+"",
success: function(data){
$("#regResPass").html(data);
}
});

}

function regCheckPass2(){

$.ajax({
type: "POST",
processdata: false,
global: false,
url: "register.php?do=pass2&var="+$("#regPass").val()+"&var1="+$("#regPass2").val()+"",
success: function(data){
$("#regResPass2").html(data);
}
});

}

function regCheckEMail(){

$.ajax({
type: "POST",
processdata: false,
global: false,
url: "register.php?do=email&var="+$("#regEMail").val()+"",
success: function(data){
$("#regResEMail").html(data);
}
});

}

function regCheckNick(){

$.ajax({
type: "POST",
processdata: false,
global: false,
url: "register.php?do=nick&var="+$("#regNick").val()+"",
success: function(data){
$("#regResNick").html(data);
}
});

}

function regCheckName(){

$.ajax({
type: "POST",
processdata: false,
global: false,
url: "register.php?do=name&var="+$("#regName").val()+"",
success: function(data){
$("#regResName").html(data);
}
});

}

function regCheckSurname(){

$.ajax({
type: "POST",
processdata: false,
global: false,
url: "register.php?do=surname&var="+$("#regSurname").val()+"",
success: function(data){
$("#regResSurname").html(data);
}
});

}

function regSubmit(){

$.ajax({
type: "POST",
processdata: false,
global: false,
url: "register.php?do=submit&login="+$("#regLogin").val()+"&pass="+$("#regPass").val()+"&pass2="+$("#regPass2").val()+"&email="+$("#regEMail").val()+"&nick="+$("#regNick").val()+"&name="+$("#regName").val()+"&surname="+$("#regSurname").val()+"",
success: function(data){
$("#regSubmit").html(data);
}
});

}

function register(){

$.ajax({
type: "POST",
processdata: false,
global: false,
url: "register.php?do=register&login="+$("#regLogin").val()+"&pass="+$("#regPass").val()+"&email="+$("#regEMail").val()+"&nick="+$("#regNick").val()+"&name="+$("#regName").val()+"&surname="+$("#regSurname").val()+"&spawn_city="+$("#regSpawnCity").val()+"&gender="+$("#regGender").val()+"",
success: function(data){
$("#invis").html(data);
}
});

}

function registerSuccess(){

$.ajax({
type: "POST",
processdata: false,
global: false,
url: "register.php?do=success",
success: function(data){
$("#registerContent").html(data);
}
});

}

/* Basic*/
$(document).ready(function() {
	$(".various").fancybox({
		maxWidth	: 800,
		maxHeight	: 600,
		fitToView	: false,
		width		: '70%',
		height		: '70%',
		autoSize	: true,
		closeClick	: false,
		openEffect	: 'none',
		closeEffect	: 'none'
	});
});

function setCookie(c_name,value,exdays)
{
var exdate=new Date();
exdate.setDate(exdate.getDate() + exdays);
var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
document.cookie=c_name + "=" + c_value;
}

/*auth*/
function authSend(){

$.ajax({
type: "POST",
processdata: false,
global: false,
url: "login.php?do=login&login="+$("#authLogin").val()+"&password="+$("#authPassword").val()+"&remember="+$("#authRemember").val()+"",
success: function(data){
$("#invis").html(data);
}
});

}

function authProcess(){

$.ajax({
type: "POST",
processdata: false,
global: false,
url: "login.php?do=auth&login="+$("#authLogin").val()+"&password="+$("#authPassword").val()+"&remember="+$("#authRemember").val()+"",
success: function(data){
$("#authMain").html(data);
}
});

}

function logout(){

$.ajax({
type: "POST",
processdata: false,
global: false,
url: "login.php?do=logout",
success: function(data){
$("#invis").html(data);
}
});

}

