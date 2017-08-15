<?php 

	$requestUserJsonData = file_get_contents('php://input');
	$requestUserData = json_decode($requestUserJsonData,true);

	$my_uuid = $requestUserData["uuid"];
	$my_encounterd = $requestUserData["encounterd"];
	$my_encounterd = json_encode($my_encounterd);
	$my_liked = $requestUserData["liked"];
	$my_liked = json_encode($my_liked);
	$my_matched = $requestUserData["matched"];
	$my_matched = json_encode($my_matched);

	// echo $my_encounterd;
	// exit();

	try{
		$user = "root";
		$passward = "dreamcometrue";
		$db_name = "example_db";
		$host = "localhost:3306";
		$dsn = "mysql:host={$host};dbname={$db_name};charset=utf8";
		$pdo = new PDO($dsn,$user,$passward,array(
		        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
		        PDO::ATTR_EMULATE_PREPARES => false,
		    ));
	}catch(Exception $e){
		echo "Error";
		echo $e->getMessage();
		exit();
	}

	try{
		$stmt = $pdo -> prepare('UPDATE se_dummy SET encounterd = :encounterd,liked = :liked,matched = :matched where uuid = :uuid');
		$stmt->bindValue(':uuid',$my_uuid,PDO::PARAM_STR);
		$stmt->bindValue(':encounterd',$my_encounterd,PDO::PARAM_STR);
		$stmt->bindValue(':liked',$my_liked,PDO::PARAM_STR);
		$stmt->bindValue(':matched',$my_matched,PDO::PARAM_STR);
		$stmt->execute();
	}catch(Exception $e){
		echo $e->getMessage();
		exit();
	}
	
 ?>