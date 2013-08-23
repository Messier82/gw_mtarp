<?php
include_once("/includes/functions.php");
if(!isset($_GET['do'])){
head("Регистрация");
if(!isLogged()){
?>

<script>
regSubmit();
</script>

<div id="registerContent">

<span style="font-size: 14px;"><B>Регистрация</b></span>
<div class="material_top">Основная информация</div>
<div class="material_content">

<table cellspacing="0" cellpadding="0" width="100%" style="font-size: 11px;">
<tr><td width="25%" style="padding-bottom: 12px;padding-left: 15px;border-bottom: 1px solid #bcbcbc;">Логин</td><td style="border-bottom: 1px solid #bcbcbc;height: 40px;"><input type="text" id="regLogin" class="inputText" onblur="regCheckLogin();regSubmit();" /><span id="regResLogin"></span><br /><span style="color:#666666; font-size: 9px;">Для входа на сайт и сервер.</span></td></tr>
<tr><td width="25%" style="padding-bottom: 12px;padding-left: 15px;border-bottom: 1px solid #bcbcbc;">Пароль</td><td style="border-bottom: 1px solid #bcbcbc;height: 40px;"><input type="password" id="regPass" class="inputText" onblur="regCheckPass();regSubmit();" /><span id="regResPass"></span><br /><span style="color:#666666; font-size: 9px;">Для входа на сайт и сервер.</span></td></tr>
<tr><td width="25%" style="padding-bottom: 12px;padding-left: 15px;border-bottom: 1px solid #bcbcbc;">Повторите пароль</td><td style="border-bottom: 1px solid #bcbcbc;height: 40px;"><input type="password" id="regPass2" class="inputText" onblur="regCheckPass2();regSubmit();" /><span id="regResPass2"></span><br /><span style="color:#666666; font-size: 9px;">Понятно для чего.</span></td></tr>
<tr><td width="25%" style="padding-bottom: 12px;padding-left: 15px;border-bottom: 1px solid #bcbcbc;">E-Mail</td><td style="border-bottom: 1px solid #bcbcbc;height: 40px;"><input type="text" id="regEMail" class="inputText" onblur="regCheckEMail();regSubmit();" /><span id="regResEMail"></span><br /><span style="color:#666666; font-size: 9px;">Если вдруг забудете пароль.</span></td></tr>
<tr><td width="25%" style="padding-bottom: 12px;padding-left: 15px;">Ник</td><td style="height: 40px;"><input type="text" id="regNick" class="inputText" onblur="regCheckNick();regSubmit();" /><span id="regResNick"></span><br /><span style="color:#666666; font-size: 9px;">Для того, что бы отличить вас среди других пользователей.</span></td></tr>
</table>

</div>



<div class="material_top" style="margin-top: 5px;">Информация о персонаже</div>
<div class="material_content">

<table cellspacing="0" cellpadding="0" width="100%" style="font-size: 11px;">
<tr><td width="25%" style="padding-bottom: 12px;padding-left: 15px;border-bottom: 1px solid #bcbcbc;">Имя</td><td style="border-bottom: 1px solid #bcbcbc;height: 40px;"><input type="text" id="regName" class="inputText" onblur="regCheckName();regSubmit();" /><span id="regResName"></span><br /><span style="color:#666666; font-size: 9px;">Имя вашего персонажа.</span></td></tr>
<tr><td width="25%" style="padding-bottom: 12px;padding-left: 15px;border-bottom: 1px solid #bcbcbc;">Фамилия</td><td style="border-bottom: 1px solid #bcbcbc;height: 40px;"><input type="text" id="regSurname" class="inputText" onblur="regCheckSurname();regSubmit();" /><span id="regResSurname"></span><br /><span style="color:#666666; font-size: 9px;">Фамилия вашего персонажа.</span></td></tr>
<tr><td width="25%" style="padding-bottom: 12px;padding-left: 15px;border-bottom: 1px solid #bcbcbc;">Родной город</td><td style="height: 40px;border-bottom: 1px solid #bcbcbc;"><select id="regSpawnCity" onblur="regCheckSpawnCity();"><option value="1">Los Santos</option><option value="2">San Fierro</option></select><br /><span style="color:#666666; font-size: 9px;">Место вашего появления в начале игры.</span></td></tr>
<tr><td width="25%" style="padding-bottom: 12px;padding-left: 15px;">Пол</td><td style="height: 40px;"><select id="regGender" onblur="regCheckGender();"><option value="man">Мужской</option><option value="woman">Женский</option></select><br /><span style="color:#666666; font-size: 9px;">Пол вашего персонажа.</span></td></tr>
</table>

</div>

<div id="regSubmit" style="margin-left: 230px;margin-top: 10px;"></div>
</div>

<?php
}else{
	accessDenied();
}
foot();
}

if(isset($_GET['do']) and $_GET['do'] == "login"){
	if(strlen($_GET['var'])!=0){
		$login1=true;
	}else{
		$login1=false;
		?>
		<script>
		document.getElementById('regLogin').style.border = "1px solid #9b9b9b";
		</script>
		<?php
	}
	if(!preg_match('/[а-я\,\.]/ui', $_GET['var'])){
		$login2=true;
	}elseif($login1!=false){
		$login2=false;
		?>
		Логин не может состоять из русских символов.
		<script>
		document.getElementById('regLogin').style.border = "1px solid red";
		document.getElementById('regResLogin').style.color = "red";
		</script>
		<?php
	}
	if(strlen($_GET['var']) > 3 and strlen($_GET['var']) < 16){
		$login3=true;
	}elseif($login2!=false and $login1!=false){
		$login3=false
		?>
		Длинна должна быть от 4 до 15 символов!
		<script>
		document.getElementById('regLogin').style.border = "1px solid red";
		document.getElementById('regResLogin').style.color = "red";
		</script>
		<?php
	}
	$check = mysql_query("SELECT login FROM users WHERE login = '".mysql_real_escape_string($_GET['var'])."'");
	if(mysql_num_rows($check)==0){
		$login4=true;
	}elseif($login3!=false){
		$login4=false;
		?>
		Этот логин уже занят!
		<script>
		document.getElementById('regLogin').style.border = "1px solid red";
		document.getElementById('regResLogin').style.color = "red";
		</script>
		<?php
	}
	if($login1 and $login2 and $login3 and $login4){
		?>
		<script>
		document.getElementById('regLogin').style.border = "1px solid green";
		</script>
		<?php
	}
}

if(isset($_GET['do']) and $_GET['do'] == "pass"){
	if(strlen($_GET['var'])!=0){
		$pass1 = true;
	}else{
		$pass1 = false;
		?>
		<script>
		document.getElementById('regPass').style.border = "1px solid #9b9b9b";
		</script>
		<?php
	}
	if(!preg_match('/[а-я\,\.]/ui', $_GET['var'])){
		$pass2 = true;
	}elseif($pass1 != false){
		$pass2 = false;
		?>
		Пароль не может состоять из русских символов.
		<script>
		document.getElementById('regPass').style.border = "1px solid red";
		document.getElementById('regResPass').style.color = "red";
		</script>
		<?php
	}
	if(strlen($_GET['var']) > 5 and strlen($_GET['var']) < 21){
		$pass3 = true;
	}elseif($pass1 != false and $pass2!= false){
		$pass3 = false;
		?>
		Длинна должна быть от 6 до 20 символов!
		<script>
		document.getElementById('regPass').style.border = "1px solid red";
		document.getElementById('regResPass').style.color = "red";
		</script>
		<?php
	}
	if($pass1==true and $pass2==true and $pass3==true){
		?>
		<script>
		document.getElementById('regPass').style.border = "1px solid green";
		</script>
		<?php
	}
}

if(isset($_GET['do']) and $_GET['do'] == "pass2"){
	if(strlen($_GET['var'])!=0 and strlen($_GET['var1'])!=0){
		$pass21 = true;
	}else{
		$pass21 = false;
		?>
		<script>
		document.getElementById('regPass2').style.border = "1px solid #9b9b9b";
		</script>
		<?php
	}
	if($_GET['var']==$_GET['var1']){
		$pass22 = true;
	}elseif($pass21!=false){
		$pass22 = false;
		?>
		Пароли должны совпадать!
		<script>
		document.getElementById('regPass2').style.border = "1px solid red";
		document.getElementById('regResPass2').style.color = "red";
		</script>
		<?php
	}
	if($pass21==true and $pass22==true){
		?>
		<script>
		document.getElementById('regPass2').style.border = "1px solid green";
		</script>
		<?php
	}
}

if(isset($_GET['do']) and $_GET['do'] == "email"){
	$email2=false;
	if(strlen($_GET['var'])!=0){
		$email1 = true;
	}else{
		$email1 = false;
		?>
		<script>
		document.getElementById('regEMail').style.border = "1px solid #9b9b9b";
		</script>
		<?php
	}
	if(preg_match("/^[\ a-z0-9._-]+@[a-z0-9.-]+\.[a-z]{2,6}$/i",$_GET['var'])){
		$email2 = true;
	}elseif($email1 != false){
		$email2 = false;
		?>
		Введите корректный E-Mail!
		<script>
		document.getElementById('regEMail').style.border = "1px solid red";
		document.getElementById('regResEMail').style.color = "red";
		</script>
		<?php
	}
	$check = mysql_query("SELECT email FROM users WHERE email = '".mysql_real_escape_string($_GET['var'])."'");
	if(mysql_num_rows($check)==0){
		$email3 = true;
	}elseif($email2!=false){
		$email3 = false;
		?>
		Этот E-Mail уже занят!
		<script>
		document.getElementById('regEMail').style.border = "1px solid red";
		document.getElementById('regResEMail').style.color = "red";
		</script>
		<?php
	}
	if($email1 == true and $email2 == true and $email3 == true){
		?>
		<script>
		document.getElementById('regEMail').style.border = "1px solid green";
		</script>
		<?php
	}
}

if(isset($_GET['do']) and $_GET['do'] == "nick"){
	if(strlen($_GET['var'])!=0){
		$nick1=true;
	}else{
		$nick1=false;
		?>
		<script>
		document.getElementById('regNick').style.border = "1px solid #9b9b9b";
		</script>
		<?php
	}
	if(!preg_match('/[а-я\,\.]/ui', $_GET['var'])){
		$nick2=true;
	}elseif($nick1!=false){
		$nick2=false;
		?>
		Ник не может состоять из русских символов.
		<script>
		document.getElementById('regNick').style.border = "1px solid red";
		document.getElementById('regResNick').style.color = "red";
		</script>
		<?php
	}
	if(strlen($_GET['var']) > 3 and strlen($_GET['var']) < 16){
		$nick3=true;
	}elseif($nick2!=false and $nick1!=false){
		$nick3=false
		?>
		Длинна должна быть от 4 до 15 символов!
		<script>
		document.getElementById('regNick').style.border = "1px solid red";
		document.getElementById('regResNick').style.color = "red";
		</script>
		<?php
	}
	$check = mysql_query("SELECT nick FROM users WHERE nick = '".mysql_real_escape_string($_GET['var'])."'");
	if(mysql_num_rows($check)==0){
		$nick4=true;
	}elseif($nick3!=false){
		$nick4=false;
		?>
		Этот ник уже занят!
		<script>
		document.getElementById('regNick').style.border = "1px solid red";
		document.getElementById('regResNick').style.color = "red";
		</script>
		<?php
	}
	if($nick1 and $nick2 and $nick3 and $nick4){
		?>
		<script>
		document.getElementById('regNick').style.border = "1px solid green";
		</script>
		<?php
	}
}

if(isset($_GET['do']) and $_GET['do'] == "name"){
	if(strlen($_GET['var'])!=0){
		$name1 = true;
	}else{
		$name1 = false;
		?>
		<script>
		document.getElementById('regName').style.border = "1px solid #9b9b9b";
		</script>
		<?php
	}
	if(!preg_match('/[а-я\,\.]/ui', $_GET['var'])){
		$name2 = true;
	}elseif($name1 != false){
		$name2 = false;
		?>
		Имя не может состоять из русских символов.
		<script>
		document.getElementById('regName').style.border = "1px solid red";
		document.getElementById('regResName').style.color = "red";
		</script>
		<?php
	}
	if(strlen($_GET['var']) > 1 and strlen($_GET['var']) < 21){
		$name3 = true;
	}elseif($name1 != false and $name2!= false){
		$name3 = false;
		?>
		Длинна должна быть от 2 до 20 символов!
		<script>
		document.getElementById('regName').style.border = "1px solid red";
		document.getElementById('regResName').style.color = "red";
		</script>
		<?php
	}
	if($name1==true and $name2==true and $name3==true){
		?>
		<script>
		document.getElementById('regName').style.border = "1px solid green";
		</script>
		<?php
	}
}

if(isset($_GET['do']) and $_GET['do'] == "surname"){
	if(strlen($_GET['var'])!=0){
		$surname1 = true;
	}else{
		$surname1 = false;
		?>
		<script>
		document.getElementById('regSurname').style.border = "1px solid #9b9b9b";
		</script>
		<?php
	}
	if(!preg_match('/[а-я\,\.]/ui', $_GET['var'])){
		$surname2 = true;
	}elseif($surname1 != false){
		$surname2 = false;
		?>
		Имя не может состоять из русских символов.
		<script>
		document.getElementById('regSurname').style.border = "1px solid red";
		document.getElementById('regResSurname').style.color = "red";
		</script>
		<?php
	}
	if(strlen($_GET['var']) > 1 and strlen($_GET['var']) < 21){
		$surname3 = true;
	}elseif($surname1 != false and $surname2!= false){
		$surname3 = false;
		?>
		Длинна должна быть от 2 до 20 символов!
		<script>
		document.getElementById('regSurname').style.border = "1px solid red";
		document.getElementById('regResSurname').style.color = "red";
		</script>
		<?php
	}
	if($surname1==true and $surname2==true and $surname3==true){
		?>
		<script>
		document.getElementById('regSurname').style.border = "1px solid green";
		</script>
		<?php
	}
}

if(isset($_GET['do']) and $_GET['do'] == "submit"){
	/*Login*/
	if(strlen($_GET['login'])!=0 and $_GET['login']!="undefined"){$login1=true;}else{$login1=false;}
	if(!preg_match('/[а-я\,\.]/ui', $_GET['login'])){$login2=true;}elseif($login1!=false){$login2=false;}
	if(strlen($_GET['login']) > 3 and strlen($_GET['login']) < 16){$login3=true;}elseif($login2!=false and $login1!=false){$login3=false;}
	$checkLogin = mysql_query("SELECT login FROM users WHERE login = '".mysql_real_escape_string($_GET['login'])."'");
	if(mysql_num_rows($checkLogin)==0){$login4=true;}elseif($login3!=false){$login4=false;}
	if($login1 and $login2 and $login3 and $login4){$loginCh = true;}else{ $loginCh = false; }
	/*Pass*/
	if(strlen($_GET['pass'])!=0 and $_GET['pass']!="undefined"){$pass1 = true;}else{$pass1 = false;}
	if(!preg_match('/[а-я\,\.]/ui', $_GET['pass'])){$pass2 = true;}elseif($pass1 != false){$pass2 = false;}
	if(strlen($_GET['pass']) > 5 and strlen($_GET['pass']) < 21){$pass3 = true;}elseif($pass1 != false and $pass2!= false){$pass3 = false;}
	if($pass1==true and $pass2==true and $pass3==true){$passCh = true;}else{$passCh=false;}
	/*Pass2*/
	if(strlen($_GET['pass'])!=0 and strlen($_GET['pass2'])!=0 and $_GET['pass']!="undefined" and $_GET['pass2']!="undefined"){$pass21 = true;}else{$pass21 = false;}
	if($_GET['pass']==$_GET['pass2']){$pass22 = true;}elseif($pass21!=false){$pass22 = false;}
	if($pass21==true and $pass22==true){$pass2Ch = true;}else{$pass2Ch = false;}
	/*EMail*/
	$email2=false;
	if(strlen($_GET['email'])!=0 and $_GET['email']!="undefined"){$email1 = true;}else{$email1 = false;}
	if(preg_match("/^[\ a-z0-9._-]+@[a-z0-9.-]+\.[a-z]{1,6}$/i",$_GET['email'])){$email2 = true;}elseif($email1 != false){$email2 = false;}
	$checkEmail = mysql_query("SELECT email FROM users WHERE email = '".mysql_real_escape_string($_GET['email'])."'");
	if(mysql_num_rows($checkEmail)==0){$email3 = true;}elseif($email2!=false){$email3 = false;}
	if($email1 == true and $email2 == true and $email3 == true){$emailCh = true;}else{$emailCh = false;}
	/*Nick*/
	if(strlen($_GET['nick'])!=0){$nick1=true;}else{$nick1=false;}
	if(!preg_match('/[а-я\,\.]/ui', $_GET['nick'])){$nick2=true;}elseif($nick1!=false){$nick2=false;}
	if(strlen($_GET['nick']) > 3 and strlen($_GET['nick']) < 16){$nick3=true;}elseif($nick2!=false and $nick1!=false){$nick3=false;}
	$check = mysql_query("SELECT nick FROM users WHERE nick = '".mysql_real_escape_string($_GET['nick'])."'");
	if(mysql_num_rows($check)==0){$nick4=true;}elseif($nick3!=false){$nick4=false;}
	if($nick1 and $nick2 and $nick3 and $nick4){$nickCh = true;}else{$nickCh = false;}
	/*Name*/
	if(strlen($_GET['name'])!=0){$name1 = true;}else{$name1 = false;}
	if(!preg_match('/[а-я\,\.]/ui', $_GET['name'])){$name2 = true;}elseif($name1 != false){$name2 = false;}
	if(strlen($_GET['name']) > 1 and strlen($_GET['name']) < 21){$name3 = true;}elseif($name1 != false and $name2!= false){$name3 = false;}
	if($name1==true and $name2==true and $name3==true){$nameCh = true;}else{$nameCh = false;}
	/*Surname*/
	if(strlen($_GET['surname'])!=0){$surname1 = true;}else{$surname1 = false;}
	if(!preg_match('/[а-я\,\.]/ui', $_GET['surname'])){$surname2 = true;}elseif($surname1 != false){$surname2 = false;}
	if(strlen($_GET['surname']) > 1 and strlen($_GET['surname']) < 21){$surname3 = true;}elseif($surname1 != false and $surname2!= false){$surname3 = false;}
	if($surname1==true and $surname2==true and $surname3==true){$surnameCh = true;}else{$surnameCh = false;}
	/*Output*/
	if($loginCh==true and $passCh==true and $pass2Ch==true and $emailCh==true and $nickCh==true and $nameCh==true and $surnameCh==true){
		echo "<input type='submit' class='buttonActive' value='Регистрация' onclick='register();' />";
	}else{
		echo "<input type='submit' class='buttonInactive' value='Регистрация' />";
	}
}

if(isset($_GET['do']) and $_GET['do'] == "register"){
	$time = time();
	$query1 = mysql_query("INSERT INTO users (login,pass,email,reg_date,last_activity,nick,group)VALUES('".$_GET['login']."','".md5($_GET['pass'])."','".$_GET['email']."','".$time."','".$time."','".$_GET['nick']."','1')") or die(mysql_error());
	$query2 = mysql_query("INSERT INTO characters (name,surname,spawn_city,owner_user,gender)VALUES('".$_GET['name']."','".$_GET['surname']."','".$_GET['spawn_city']."','".mysql_insert_id($mysqlConnection)."','".$_GET['gender']."')") or die(mysql_error());
	echo "<script>registerSuccess();</script>";
}

if(isset($_GET['do']) and $_GET['do'] == "success"){
	echo '<div class="material_content"><div class="solidGreen">Ваша учетная запись была зарегестрирована!<br />Спасибо за регистрацию! Теперь вы можете зайти на сайт и сервер. Удачной игры!</div></div>';
}
?>