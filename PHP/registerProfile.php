<?php 

	//Get Data from Front-----------------------------------------------------------
	$requestUserJsonData = file_get_contents('php://input');
	$requestUserData = json_decode($requestUserJsonData,true);

	//set data-----------------------------------------------------------
	$my_uuid = $requestUserData["uid"];
	$my_imgfile = $requestUserData["profileImage"];
	$my_username = $requestUserData["userName"];
	$my_email = $requestUserData["email"];


	//get img png decode-----------------------------------------------------------
	$my_imgfile = str_replace('data:image/png;base64,','',$my_imgfile);
	$my_imgfile = str_replace(' ', '+', $my_imgfile);
	$fileData = base64_decode($my_imgfile);

	$target_dir = "./img/{$my_uuid}";
	if(!file_exists($target_dir)){
	mkdir($target_dir, 0777, true);
	}

	$fileName  = 'profile.png';
	$target_dir = "./img/{$my_uuid}/{$fileName}";
	//Save Image data in server-----------------------------------------------------------
	file_put_contents($target_dir, $fileData);

	//DB Connection-----------------------------------------------------------
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

	//Insert-----------------------------------------------------------
	try{
		$stmt = $pdo -> prepare("INSERT INTO `pt_jobhuntertb01`(`uuid`, `username`, `email`, `registertime`) VALUES (:uuid,:username,:email,NOW())");
		$stmt->bindValue(':uuid',$my_uuid,PDO::PARAM_STR);
		$stmt->bindValue(':username',$my_username,PDO::PARAM_STR);
		$stmt->bindValue(':email',$my_email,PDO::PARAM_STR);
		// $stmt->execute();

	// $sql = "insert into prototypetb01(uuid,username,email)values({$my_uuid},{$my_username},{$my_email})";
	// $stmt = $pdo->prepare($sql);
	// $stmt->execute();
	}catch(Exception $e){
		echo "Error";
		echo $e->getMessage();
		exit();
	}
 ?>