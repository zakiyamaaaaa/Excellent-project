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

	// $my_uuid = "hogehoge";

	try{
		$stmt = $pdo -> prepare('SELECT * FROM re_dummy where json_contains(matched,json_array(:uuid))');
		$stmt->bindValue(':uuid',$my_uuid,PDO::PARAM_STR);
		$stmt->execute();
		// $userDataArray = array();


		while($row = $stmt -> fetch(PDO::FETCH_ASSOC)){
			// echo $row['uuid'];
			$userDataArray[]=array(
		    'uuid'=>$row['uuid'],
		    'name'=>$row['username'],
		    'distance'=>$row['distance'],
		    'encounterd'=>json_decode($row['encounterd']),
		    'liked'=>json_decode($row['liked']),
		    'matched'=>json_decode($row['matched']),
		    'birth'=>$row['birth'],
		    'position'=>$row['position'],
		    'skill' =>json_decode($row['skill']),
		    'ogori'=>json_decode($row['ogori']),
		    'education'=>json_decode($row['education']),
		    'introduction'=>$row['self_introduction'],
		    'message'=>$row['message'],
		    'career'=>json_decode($row['career']),
		    'company_id'=>$row['company_id'],
		    'company_link'=>$row['company_link'],
		    'company_name'=>$row['company_name'],
		    'company_population'=>$row['company_population'],
		    'company_introduction'=>$row['company_introduction'],
		    'company_industry'=>$row['company_industry'],
		    'company_feature'=>json_decode($row['company_feature']),
		    'company_recruitment'=>json_decode($row['company_recruitment'])
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