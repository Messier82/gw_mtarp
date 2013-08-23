<?php
include_once("/includes/functions.php");
if(!isset($_GET['do'])){
head("Главная");
echo getIp();
var_dump(isLogged());
foot();
}else{

if($_GET['do']=='access'){
	?>
	<div class="alert alert-error">
	<h4 class="alert-heading">Внимание!</h4>
	У Вас нет доступа к этой странице.
	</div>
	<?php
}

}
?>