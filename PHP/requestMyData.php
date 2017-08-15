<?php 

	$requestUserJsonData = file_get_contents('php://input');
	$requestUserData = json_decode($requestUserJsonData,true);

	$my_uuid = $requestUserData["uuid"];


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
		$stmt = $pdo -> prepare('UPDATE se_dummy SET login_count = login_count + 1,updated_at = now() where uuid = :uuid');
		$stmt->bindValue(':uuid',$my_uuid,PDO::PARAM_STR);
		$stmt->execute();
	}catch(Exception $e){
		echo $e->getMessage();
		exit();
	}

	try{
		$stmt = $pdo -> prepare('SELECT * FROM se_dummy where uuid = :uuid');
		$stmt->bindValue(':uuid',$my_uuid,PDO::PARAM_STR);
		$stmt->execute();
		$userDataArray = array();


		while($row = $stmt -> fetch(PDO::FETCH_ASSOC)){
			// echo $row['uuid'];
			$userDataArray = array(
				'uuid' => $row['uuid'],
				'name' => $row['username'],
				'birth' => $row['birth'],
				'encounterd' => json_decode($row['encounterd']),
				'liked' => json_decode($row['liked']),
				'matched' => json_decode($row['matched']),
				'introduction' => $row['self_introduction'],
				'message' => $row['message'],
				'skill' => json_decode($row['skill']),
				'my_goodpoint' => $row['my_goodpoint'],
				'my_badpoint' => $row['my_badpoint'],
				'interesting' => json_decode($row['interesting']),
				'education' => json_decode($row['education']),
				'belonging' => json_decode($row['belonging_group'])
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