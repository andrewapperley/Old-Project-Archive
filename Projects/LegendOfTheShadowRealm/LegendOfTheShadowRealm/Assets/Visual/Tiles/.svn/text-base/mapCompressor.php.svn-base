<?php
if (!empty ( $_POST['text'])){
		
		$map =  base64_encode( gzcompress($_POST['text']) );
		$newMapFile = "CtestMap.tmx";
		$fh = fopen($newMapFile, 'w') or die("can't open file");
		fwrite($fh, $map);
		fclose($fh);
		
	}
?>


<!DOCTYPE html>
<html>
<body>

<h1>Map Compression Tool</h1>



<form action="mapCompressor.php" method="POST">
<p>Paste the map file here</p>
<textarea name="text" id="text" rows="4" cols="50"></textarea>
<input type="submit" value="Submit"/>
</form>

</body>
</html>