<?php

	$requestUserJsonData = file_get_contents('php://input');
	$requestUserData = json_decode($requestUserJsonData,true);



	$my_id = $requestUserData["uuid"];
	$my_lat = $requestUserData["lat"];
	$my_lng = $requestUserData["lng"];

	//Connect Database
	try{
		$user = "root";
		$passward = "************";
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

	//Update user location
	// try{
	// 	// $location = 'point('. $my_lng. ' '. {$my_lat}.')';
	// 	// $location = 'point(130 20)';
	// 	$location = 'point('.$my_lng.' '.$my_lat.')';


	// 	//Insert 新しく作るとき
	// 	// $stmt = $pdo->prepare('insert into pt_jobhuntertb01(uuid,username,email,latlng,currentlogintime,encounterd,matched)values(:uuid,"takashi","aaa",PointFromText(:location),now(),null,null)');
	// 	$stmt = $pdo->prepare('update pt_jobhuntertb01 set latlng = PointFromText(:location),currentlogintime = NOW() where uuid = :uuid');
	// 	// $stmt = $pdo->prepare('insert into pt_jobhuntertb01(uuid,registertime)values(:uuid,now())');
	// 	$stmt->bindValue(':uuid',$my_id,PDO::PARAM_STR);
	// 	$stmt->bindValue(':location',$location,PDO::PARAM_STR);
	// 	$stmt->execute();
	// 	// echo $location;
	// }catch(Exception $e){
	// 	echo "Error";
	// 	echo $e->getMessage();
	// 	exit();
	// }



	//Search near Userdata
	try{
		$dummyUUID = "hoge";
		$myid_array = array($dummyUUID);
		$json = json_encode($myid_array);
		$length = 500000000;
		// $my_id = '["hoge"]';
		//これの前にユーザーからgetした位置情報をupdateする必要あり。
		// $sql = 	"select s2.id,s2.username,s2.companyname, s2.position, s2.appreciation, s2.imgfilename, st_distance_sphere(s1.point,s2.point) as distance from jsontb02 as s1 inner join jsontb02 as s2 where s1.id = ${my_id} and s1.id != s2.id  and !json_contains(s2.encounteredid,'${my_id}') group by s2.id having distance < ${length} order by distance is null asc;";

		// $sql = "select s2.uuid,s2.username,st_distance_sphere((select latlng from pt_jobhuntertb01 where !json_contains(s2.encounterd,'${my_id}')),s2.latlng) as distance from pt_recruitertb01 as s1 inner join pt_recruitertb01 as s2 group by s2.uuid having distance < 500000 and distance is not null order by distance asc;";

		// $sql = "select * from pt_recruitertb01;";
		

		$stmt = $pdo->prepare('select s2.uuid,s2.username,s2.liked,s2.encounterd,s2.companyname,s2.industry,s2.occupation,s2.treat,st_distance_sphere((select latlng from pt_jobhuntertb01 where uuid = :uuid and !json_contains(pt_jobhuntertb01.encounterd,json_array(s2.uuid))),s2.latlng) as distance from pt_recruitertb01 as s1 inner join pt_recruitertb01 as s2 group by s2.uuid having distance < :length and distance is not null order by distance asc');
		$stmt->bindValue(':uuid',$my_id,PDO::PARAM_STR);
		// $stmt->bindValue(':jsonuuid',$json,PDO::PARAM_STR);
		$stmt->bindValue(':length',$length,PDO::PARAM_INT);
		$stmt->execute();

		$userDataArray = array();

		while($row = $stmt->fetch(PDO::FETCH_ASSOC)){
			// echo $row['uuid'];
		    // echo $row['username'];

			 $userDataArray[]=array(
		    'uuid'=>$row['uuid'],
		    'username'=>$row['username'],
		    'distance'=>$row['distance'],
		    'encounterd'=>json_decode($row['encounterd']),
		    'liked'=>json_decode($row['liked']),
		    'matched'=>json_decode($row['matched']),
		    'companyname'=>$row['companyname'],
		    'industry' =>json_decode($row['industry']),
		    'occupation'=>json_decode($row['occupation']),
		    'treat'=>json_decode($row['treat'])
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