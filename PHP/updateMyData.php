<?php 

	$requestUserJsonData = file_get_contents('php://input');
	$requestUserData = json_decode($requestUserJsonData,true);

	$my_uuid = $requestUserData["uuid"];
	$my_selfintroduction = $requestUserData["introduction"];
	$my_skill = $requestUserData["skill"];
	$my_skill = json_encode($my_skill);
	$my_goodpoint = $requestUserData["my_goodpoint"];
	$my_badpoint = $requestUserData["my_badpoint"];
	$my_belonging = $requestUserData["belonging_group"];
	$my_belonging = json_encode($my_belonging);
	$my_interesting = $requestUserData["interesting"];
	$my_interesting = json_encode($my_interesting);
	$my_education = $requestUserData["education"];
	$my_education = json_encode($my_education);


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

	// $my_uuid = "hoge";
	try{
		// $stmt = $pdo -> prepare('SELECT * FROM se_dummy where uuid = :uuid');
		$stmt = $pdo -> prepare('UPDATE se_dummy SET self_introduction = :my_selfintroduction, my_goodpoint = :my_goodpoint,education = :my_education,belonging_group = :my_belonging, interesting = :my_interesting,my_badpoint = :my_badpoint ,skill = :my_skill where uuid = :uuid');
		$stmt->bindValue(':uuid',$my_uuid,PDO::PARAM_STR);
		$stmt->bindValue(':my_selfintroduction',$my_selfintroduction,PDO::PARAM_STR);
		$stmt->bindValue(':my_goodpoint',$my_goodpoint,PDO::PARAM_STR);
		$stmt->bindValue(':my_badpoint',$my_badpoint,PDO::PARAM_STR);
		$stmt->bindValue(':my_interesting',$my_interesting,PDO::PARAM_STR);
		$stmt->bindValue(':my_education',$my_education,PDO::PARAM_STR);
		$stmt->bindValue(':my_belonging',$my_belonging,PDO::PARAM_STR);
		$stmt->bindValue(':my_skill',$my_skill,PDO::PARAM_STR);
		// $stmt->bindValue(':my_interesting',$my_interesting,PDO::PARAM_STR);
		$stmt->execute();
		
		echo "success!!";

	}catch(Exception $e){
		echo $e->getMessage();
		exit();
	}
 ?>