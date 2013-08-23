<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><?=page_title?></title>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <link rel="stylesheet" href="/data/css/style.css" type="text/css" media="screen" />
  <script type="text/javascript" src="/data/js/jquery.js"></script>
  <script type="text/javascript" src="/data/fancybox/lib/jquery.mousewheel-3.0.6.pack.js"></script>
	<link rel="stylesheet" href="/data/fancybox/source/jquery.fancybox.css?v=2.1.4" type="text/css" media="screen" />
	<script type="text/javascript" src="/data/fancybox/source/jquery.fancybox.pack.js?v=2.1.4"></script>
  <script type="text/javascript" src="/data/js/main.js"></script>

</head>
<body>

<div class="ajaxBusy"><?php include_once('ajax_activity.html') ?></div>

<div id="invis"></div>
<div class="wrapper" align="center">
<div class="logo">
</div>

<div class="containerOuter">
<div class="container">
<div class="menu">
<div class="main">
<a href="/">Главная</a>
</div>
<?php if(!isLogged()){ ?>
<div class="right">
<div class="register"><a href="/register.php">Регистрация</a></div>
<a class="various fancybox.ajax" href="/login.php">Вход</a>
</div>
<?php } else { ?>
<div class="right"><a onclick="logout();" style="cursor: pointer;">Выход</a></div>
<div class="menuRight">
<?php $userdata = getUserDataByID(isLogged());
echo $userdata['nick'];
?>
</div>
<?php } ?>
</div>

<div class="lSidebar">

<h3>Название окна</h3>
Содержимое окна

</div>

<div class="content" id='pageContent'>