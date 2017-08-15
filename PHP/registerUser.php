<?php 

	$requestUserJsonData = file_get_contents('php://input');
	$requestUserData = json_decode($requestUserJsonData,true);

	$my_uuid = $requestUserData["uuid"];
	$my_name = $requestUserData["name"];
	$my_birth = $requestUserData["birth"];
	$my_status = $requestUserData["status"];
	$my_education = $requestUserData["education"];
	// $my_education = json_encode($my_education);
	// $my_selfintroduction = $requestUserData["self_introduction"];
	// $my_skill = $requestUserData["skill"];
	// $my_skill = json_encode($my_skill);
	// $my_goodpoint = $requestUserData["my_goodpoint"];
	// $my_badpoint = $requestUserData["my_badpoint"];
	// $my_belonging = $requestUserData["belonging_group"];
	// $my_belonging = json_encode($my_belonging);
	// $my_interesting = $requestUserData["interesting"];
	// $my_interesting = json_encode($my_interesting);
	
	//imgfileの保存
	//decode-----------------------------------------------------------
	$my_imgfile = $requestUserData["profileImage"];
	$my_imgfile = str_replace('data:image/png;base64,','',$my_imgfile);
	$my_imgfile = str_replace(' ', '+', $my_imgfile);
	$fileData = base64_decode($my_imgfile);

	$target_dir = "./img/{$my_uuid}";
	if(!file_exists($target_dir)){
	mkdir($target_dir, 0777, true);
	}

	$fileName  = 'userimg.png';
	$target_dir = "./img/{$my_uuid}/{$fileName}";
	//Save Image data in server-----------------------------------------------------------
	file_put_contents($target_dir, $fileData);


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
		$stmt = $pdo -> prepare('INSERT INTO se_dummy(uuid,username,birth,education,status,created_at,updated_at)values(:uuid,:username,:birth,json_array(:schoolName,:faculty,:graduationYear),:status,now(),now())');
		$stmt->bindValue(':uuid',$my_uuid,PDO::PARAM_STR);
		$stmt->bindValue(':username',$my_name,PDO::PARAM_STR);
		$stmt->bindValue(':birth',$my_birth,PDO::PARAM_STR);
		$stmt->bindValue(':status',$my_status,PDO::PARAM_INT);
		$stmt->bindValue(':schoolName',$my_education[0],PDO::PARAM_STR);
		$stmt->bindValue(':faculty',$my_education[1],PDO::PARAM_STR);
		$stmt->bindValue(':graduationYear',$my_education[2],PDO::PARAM_STR);
		$stmt->execute();
		
		echo $my_education[0];
		// echo var_dump($my_education);

	}catch(Exception $e){
		echo $e->getMessage();
		exit();
	}
 ?>