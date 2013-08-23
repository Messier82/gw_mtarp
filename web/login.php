<?php
include_once("/includes/functions.php");
if(!isset($_GET['do'])){
?>

<style>
.authMain {
	width: 300px;
	overflow: hidden;
}

.authTopOuter {
	height: 35px;
	background: #535353;
	line-height: 35px;
	border: 1px solid #262626;
	padding-bottom:1px;
}

.authTopInner {
	border-bottom: 1px solid #636363;
	padding: 0 10px;
	color: #bdbdbd;
	font-size: 15px;
	text-shadow: -1px 0 #2f2f2f, 0 1px #2f2f2f, 1px 0 #2f2f2f, 0 -1px #2f2f2f;
}

.authLoginOuter {
	height: 25px;
	background: #cecece;
	line-height: 25px;
	border: 1px solid #a3a3a3;
	border-top: none;
	padding-bottom: 1px;
}

.authLoginInner {
	border-bottom: 1px solid #dbdbdb;
	padding: 0 3px;
	padding-top: 3px;
}

.authInputText {
	height: 19px;
	padding: 0 3px;
	background: #dedede;
	border: 1px solid #c5c5c5;
	line-height: 19px;
	margin-bottom: 1px;
	width: 284px;
	color: #6a6a6a;
	font-size: 10px;
}

.authRememberZone {
	float:left;
	height: 14x;
	background: #dfdfdf;
	border: 1px solid #a3a3a3;
	color: #5a5a5a;
	padding: 0 3px;
	border-top: none;
	width: auto;
	padding-top: 3px;
}

.authSend {
	display: block;
	float: right;
	height: 25px;
	border: 1px solid #52764a;
	border-top: none;
	line-height: 25px;
	padding: 0 7px;
	color: #072f00;
	cursor: pointer;
	background: #8ece89;
}

.authSend:hover {
	background: #5fb558;
	border-color: #23461b;
}
</style>

<div class="authMain" id="authMain">
<div class="authTopOuter"><div class="authTopInner">Авторизация</div></div>
<div class="authLoginOuter"><div class="authLoginInner"><input id="authLogin" type="text" class="authInputText" value="Логин" onfocus="if (this.value == 'Логин') this.value=''" onblur="if (this.value == '') this.value='Логин'" /></div></div>
<div class="authLoginOuter"><div class="authLoginInner"><input id="authPassword" type="password" class="authInputText" value="Пароль" onfocus="if (this.value == 'Пароль') this.value=''" onblur="if (this.value == '') this.value='Пароль'" /></div></div>
<div class="authRememberZone"><div style="float:left;"><input id="authRemember" type="checkbox" /></label></div><div style="float:left; margin-bottom: 2px;margin-left: 4px;">Запомнить?</div></div>
<input type="submit" class="authSend" value="Войти" onclick="authSend();" />
</div>

<?php
}
if(isset($_GET['do']) and $_GET['do'] == "login"){
	if(strlen($_GET['login'])!=0 and strlen($_GET['password'])!=0 and $_GET['login'] != "undefined" and $_GET['password'] != "undefined"){
		$find = mysql_query("SELECT * FROM users WHERE login = '".$_GET['login']."'");
		if(mysql_num_rows($find)==1){
			$pass = mysql_fetch_array($find);
			if($pass['pass'] == md5($_GET['password'])){
				?><script>authProcess();</script><?php
			}else{
				?><script>document.getElementById('authPassword').style.borderColor = "red";	</script><?php
			}
		}else{
			?><script>document.getElementById('authLogin').style.borderColor = "red";	</script><?php
		}
	}else{
		?><script>document.getElementById('authLogin').style.borderColor = "#c5c5c5";document.getElementById('authPassword').style.borderColor = "#c5c5c5";	</script><?php
	}
}

if(isset($_GET['do']) and $_GET['do'] == "auth"){
	$find = mysql_query("SELECT * FROM users WHERE login = '".$_GET['login']."'");
	$data = mysql_fetch_array($find);
	$randid = str_rand(15,"alphanum");
	$checkid = mysql_query("SELECT * FROM site_sessions WHERE id = '$randid'");
	if(mysql_num_rows($checkid) > 0){$randid = str_rand(15,"alphanum");}else{$randid = $randid;}
	$query = mysql_query("INSERT INTO site_sessions (gid, id, ip) VALUES ('".$data['gid']."','$randid','".getIp()."')");
	if($_GET['remember']){$expire=9999999999999999;}else{$expire=1;}
	setcookie("auth",$randid,$expire);
	?><Script>window.location = document.URL;</script><?php
}

if(isset($_GET['do']) and $_GET['do'] == "logout"){
	mysql_query("DELETE FROM site_sessions WHERE gid = '".isLogged()."'");
	?><Script>window.location = document.URL;</script><?php
}
?>