<?php
/*Getting data from config file*/
$configFile = file('./includes/config.txt') or die("Can't open config file");
/*Arranging data from config file*/
$mysqlHost = trim($configFile[0]);
$mysqlUser = trim($configFile[1]);
$mysqlPass = trim($configFile[2]);
$mysqlDB = trim($configFile[3]);
$siteTitle = trim($configFile[4]);
/*Creating connection with MySQL*/
$mysqlConnection = mysql_connect($mysqlHost,$mysqlUser,$mysqlPass) or die("Cannot connect to MySQL");
mysql_select_db($mysqlDB,$mysqlConnection);
/*Functions*/

function head($title){
	global $siteTitle;
	define('page_title',$title." - ".$siteTitle);
	include_once("head.php");
}

function foot() {
	include_once("foot.php");
}

function str_rand($length = 8, $seeds = 'alphanum')
{
    // Possible seeds
    $seedings['alpha'] = 'abcdefghijklmnopqrstuvwqyz';
    $seedings['numeric'] = '0123456789';
    $seedings['alphanum'] = 'abcdefghijklmnopqrstuvwqyz0123456789';
    $seedings['hexidec'] = '0123456789abcdef';
    
    // Choose seed
    if (isset($seedings[$seeds]))
    {
        $seeds = $seedings[$seeds];
    }
    
    // Seed generator
    list($usec, $sec) = explode(' ', microtime());
    $seed = (float) $sec + ((float) $usec * 100000);
    mt_srand($seed);
    
    // Generate
    $str = '';
    $seeds_count = strlen($seeds);
    
    for ($i = 0; $length > $i; $i++)
    {
        $str .= $seeds{mt_rand(0, $seeds_count - 1)};
    }
    
    return $str;
}

function getIp()
{
    $client  = @$_SERVER['HTTP_CLIENT_IP'];
    $forward = @$_SERVER['HTTP_X_FORWARDED_FOR'];
    $remote  = $_SERVER['REMOTE_ADDR'];

    if(filter_var($client, FILTER_VALIDATE_IP))
    {
        $ip = $client;
    }
    elseif(filter_var($forward, FILTER_VALIDATE_IP))
    {
        $ip = $forward;
    }
    else
    {
        $ip = $remote;
    }

    return $ip;
}

function cookie($name,$value,$exdays){
	if(isset($name) and isset($value) and isset($exdays) and $name!="" and $value!="" and $exdays!=""){
		?>
		<script>setCookie(<?=$name?>,<?=$value?>,<?=$exdays?>);</script>
		<?php
	}
}

function isLogged(){
	if(isset($_COOKIE['auth'])){
	$id = $_COOKIE['auth'];
	$ip = getIp();
	$find = mysql_query("SELECT * FROM site_sessions WHERE id = '$id' and ip = '$ip'");
	if(mysql_num_rows($find)!=0){$data = mysql_fetch_array($find); $return = $data['gid'];}else{$return = false;}
	}else{
	$return = false;
	}
	return $return;
}

function getUserDataByID($gid){
	$get = mysql_query("SELECT * FROM users WHERE gid = '$gid'");
	return mysql_fetch_array($get);
}

function accessDenied() {
	?>
	<script>
	$.ajax({
	type: "POST",
	processdata: false,
	global: false,
	url: "index.php?do=access",
	success: function(data){
	$("#pageContent").html(data);
	}
	});
	</script>
	<?php
}

?>