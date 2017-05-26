<?php 

	$requestUserJsonData = file_get_contents('php://input');
	$requestUserData = json_decode($requestUserJsonData,true);

	$my_uuid = $requestUserData["uuid"];


	try{
		$user = "root";
		$passward = "dreamcometrue";
		$db_name = "prototypedb";
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
		$stmt = $pdo -> prepare('SELECT * FROM pt_jobhuntertb01 where uuid = :uuid');
		$stmt->bindValue(':uuid',$my_uuid,PDO::PARAM_STR);
		$stmt->execute();
		// $userDataArray = array();


		while($row = $stmt -> fetch(PDO::FETCH_ASSOC)){
			// echo $row['uuid'];
			$userDataArray = array(
				'uuid' => $row['uuid'],
				'username' => $row['username'],
				'encounterd' => json_decode($row['encounterd']),
				'liked' => json_decode($row['liked']),
				'matched' => json_decode($row['matched'])
				);
		}
		// $userDataArray["encounterd"] = json_decode($userDataArray["encounterd"]);
		header('Content-type: application/json');
		echo json_encode($userDataArray);

	}catch(Exception $e){
		echo $e->getMessage();
		exit();
	}
 ?>