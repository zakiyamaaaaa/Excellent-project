<?php

	$requestUserJsonData = file_get_contents('php://input');
	$requestUserData = json_decode($requestUserJsonData,true);

	$my_id = $requestUserData["uid"];
	$my_lat = $requestUserData["lat"];
	$my_lng = $requestUserData["lng"];

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

	try{
		$myid_array = array($my_id);
		$json = json_encode($myid_array);
		$length = 500000;
		// $my_id = '["hoge"]';
		//これの前にユーザーからgetした位置情報をupdateする必要あり。
		// $sql = 	"select s2.id,s2.username,s2.companyname, s2.position, s2.appreciation, s2.imgfilename, st_distance_sphere(s1.point,s2.point) as distance from jsontb02 as s1 inner join jsontb02 as s2 where s1.id = ${my_id} and s1.id != s2.id  and !json_contains(s2.encounteredid,'${my_id}') group by s2.id having distance < ${length} order by distance is null asc;";

		// $sql = "select s2.uuid,s2.username,st_distance_sphere((select latlng from pt_jobhuntertb01 where !json_contains(s2.encounterd,'${my_id}')),s2.latlng) as distance from pt_recruitertb01 as s1 inner join pt_recruitertb01 as s2 group by s2.uuid having distance < 500000 and distance is not null order by distance asc;";

		// $sql = "select * from pt_recruitertb01;";
		
		$stmt = $pdo->prepare('select s2.uuid,s2.username,st_distance_sphere((select latlng from pt_jobhuntertb01 where !json_contains(s2.encounterd,:uuid)),s2.latlng) as distance from pt_recruitertb01 as s1 inner join pt_recruitertb01 as s2 group by s2.uuid having distance < :length and distance is not null order by distance asc');
		$stmt->bindValue(':uuid',$json,PDO::PARAM_STR);
		$stmt->bindValue(':length',$length,PDO::PARAM_INT);
		$stmt->execute();

		$userDataArray = array();

		while($row = $stmt->fetch(PDO::FETCH_ASSOC)){
			// echo $row['uuid'];
		    // echo $row['username'];

			 $userDataArray[]=array(
		    'uuid'=>$row['uuid'],
		    'username'=>$row['username'],
		    'distance'=>$row['distance']
		    // 'companyname'=>$row['companyname'],
		    // 'position'=>$row['position'],
		    // 'appreciation'=>$row['appreciation'],
		    // 'imgfilename'=>$row['imgfilename']
		    );
		}

		header('Content-type: application/json');
		echo json_encode($userDataArray);

	}catch(Exception $e){
		echo "Error";
		echo $e->getMessage();
		exit();
	}


  ?>