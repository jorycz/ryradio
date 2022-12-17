<html>
<head>
<title>RyRadio</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>

<?php

require 'process.php';
require 'radioVolume.php';

function setVolume($v)
{
	if (empty($v))
		$v=80;
	$testfile = fopen('/var/www/html/rr/config/_volume', 'wa+');   
	fwrite ($testfile, $v);

	$device = fopen('/var/www/html/rr/config/_device', 'r');
	$name = fgets($device);

	fclose($testfile);
	fclose($device);

	$v = preg_replace('/\s/', '', $v);
	$process = new Process('amixer set '.$name.' '.$v.'%');
	$process = new Process();

	global $currentVolume;
	$currentVolume=$v;
}

function startRadio($sta)
{
	require 'radioStations.php';

	if (empty($sta) && strlen($sta) == 0)
	{
        $testfile = fopen('/var/www/html/rr/config/_stationLast', 'r');
        $sta = fgets($testfile);
        fclose($testfile);
	}
	else
	{
		if ($sta<666)
		{
			$testfile = fopen('/var/www/html/rr/config/_stationLast', 'wa+');   
			fwrite ($testfile, $sta);
			fclose($testfile);
		}
	}
	$testfile = fopen('/var/www/html/rr/config/_station', 'wa+');   
	fwrite ($testfile, $sta);
	fclose($testfile);

	$sta = preg_replace('/\s/', '', $sta);
	$k=array_keys($db)[$sta];
	$u=array_values($db)[$sta];

	$testfile = fopen('/var/www/html/rr/config/_volume', 'r');
	fclose($testfile);

  // $process = new Process('killall mpg123 ; mpg123 --timeout 10 -@'.$u);
  $process = new Process('killall mpg123 ; mpg123 --timeout 10 --no-resync --mix -@'.$u);
	$process = new Process();

	global $currentName;
	$currentName=$k;
	global $currentUrl;
	$currentUrl=$u;
}

function check_vol_and_station_pamars()
{
if (isset($_GET['vol']))
{
        setVolume(htmlspecialchars($_GET["vol"]));
} else {
        $testfile = fopen('/var/www/html/rr/config/_volume', 'r');
        $v = fgets($testfile);
        fclose($testfile);
        setVolume($v);
}

if (isset($_GET['station']))
{
        startRadio(htmlspecialchars($_GET["station"]));
} else {
        $testfile = fopen('/var/www/html/rr/config/_station', 'r');
        $s = fgets($testfile);
        fclose($testfile);
        startRadio($s);
}
}

?>

<body class=wrap>

<?php
check_vol_and_station_pamars();

echo "<div class='status'>";
echo "<span class='statusRecord'><b>" . $currentName . "</b></span>";
echo "<span class='statusVolume'> Volume " . $currentVolume . "</span>";
echo "</div>";

echo "<div class='url'>";
echo "<span class='urlRecord'> " . $currentUrl . "</span>";
echo "</div>";


echo "<div class='volumeButtons'>";
$iv=0;
foreach($volume as $key => $value) {
	echo "<a class='volumeButton' href='index.php?vol=".$value."'><b>".$value."</b></a>";
        $iv+=1;
}
unset($iv);
echo "</div>";

echo "<div class='stations'>";
$i=0;
foreach($db as $key => $value) {
	echo "<a class='station' href='index.php?station=" . $i . "'><b>" . $key . "</b></a>";
	$i+=1;
}
unset($i);
echo "<a class='stationOff' href='index.php?station=666'><b>OFF</b></a>";
echo "</div>";
?>

</body>

</html>

