<!-- ユーザーのスワイプアクション結果を受け取る -->



<?php

	$requestUserJsonData = file_get_contents('php://input');
	$requestUserData = json_decode($requestUserJsonData,true);

	$my_id = $requestUserData["uuid"]; //String
	$encounterd = $requestUserData["encounterd"]; //array
	$liked = $requestUserData["liked"]; //array

	//Connect Database
	try{
		$user = "root";
		$passward = "**************";
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

	//Update user data
	//自分のデータと相手のデータ
	try{
			$encounterd = json_encode($encounterd);
			$liked = json_encode($liked);
			$sql = 'update pt_jobhuntertb01 set encounterd = :encounterd, liked = :liked where uuid = :myuuid';
			$stmt = $pdo->prepare($sql);
			$stmt->bindValue(':myuuid',$my_id,PDO::PARAM_STR);
			$stmt->bindValue(':encounterd',$encounterd,PDO::PARAM_STR);
			$stmt->bindValue(':liked',$liked,PDO::PARAM_STR);
			$stmt->execute();

	}catch(Exception $e){
		echo "Error";

		echo $e->getMessage();
		exit();
	}

 ?>