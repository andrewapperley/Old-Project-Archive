<?php

$username = "Admin";
$password = "_upreH6C";

	if($_GET) {
		if($_GET['token']) {
			if($_GET['token'] == sha1($username.$password)) {
				echo( $_GET['callback'] . '(' . "{'token' : '".$_GET['token']."', 'status' : 'true'}" . ')');
				exit();
			} else {
				echo( $_GET['callback'] . '(' . "{'token' : '"."', 'status' : 'false'}" . ')');
				exit();
			}
		}
		if($_GET['u'] == $username && $_GET['p'] == $password ) {
			$token = sha1($username.$password);
			echo( $_GET['callback'] . '(' . "{'token' : '".$token."', 'status' : 'true'}" . ')');
			exit();
		} else {
			echo( $_GET['callback'] . '(' . "{'token' : '"."', 'status' : 'false'}" . ')');
			exit();
		}
	}
?>