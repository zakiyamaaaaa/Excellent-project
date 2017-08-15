<?php

	$requestUserJsonData = file_get_contents('php://input');
	$requestUserData = json_decode($requestUserJsonData,true);



	$my_id = $requestUserData["uuid"];
	$my_lat = $requestUserData["lat"];
	$my_lng = $requestUserData["lng"];

	//Connect Database
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


	//Update user location
	// try{
	// 	// $location = 'point('. $my_lng. ' '. {$my_lat}.')';
		// $location = 'point(130 20)';
		$location = 'point('.$my_lng.' '.$my_lat.')';


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

	try{
		$stmt = $pdo -> prepare('UPDATE se_dummy SET latlng = ST_PointFromText(:location) where uuid = :uuid');
		// $stmt = $pdo -> prepare('UPDATE se_dummy SET login_count = 1000,updated_at = now() where uuid = :uuid');
		
		$stmt->bindValue(':uuid',$my_id,PDO::PARAM_STR);
		$stmt->bindValue(':location',$location,PDO::PARAM_STR);
		$stmt->execute();


		// $stmt = $pdo -> prepare('UPDATE se_dummy SET username =  "佐藤" where uuid = :uuid');
		// $stmt->bindValue(':uuid',$my_uuid,PDO::PARAM_STR);
		
		// $stmt->execute();
	}catch(Exception $e){
		echo $e->getMessage();
		exit();
	}
// exit();

	//Search near Userdata
	try{
		// $dummyUUID = "hoge";
		$myid_array = array($dummyUUID);
		$json = json_encode($myid_array);
		$length = 500000000;
		// $my_id = "f54d8a0dce";
		//これの前にユーザーからgetした位置情報をupdateする必要あり。
		// $sql = 	"select s2.id,s2.username,s2.companyname, s2.position, s2.appreciation, s2.imgfilename, st_distance_sphere(s1.point,s2.point) as distance from jsontb02 as s1 inner join jsontb02 as s2 where s1.id = ${my_id} and s1.id != s2.id  and !json_contains(s2.encounteredid,'${my_id}') group by s2.id having distance < ${length} order by distance is null asc;";

		// $sql = "select s2.uuid,s2.username,st_distance_sphere((select latlng from pt_jobhuntertb01 where !json_contains(s2.encounterd,'${my_id}')),s2.latlng) as distance from pt_recruitertb01 as s1 inner join pt_recruitertb01 as s2 group by s2.uuid having distance < 500000 and distance is not null order by distance asc;";

		// $sql = "select * from pt_recruitertb01;";
		

		$stmt = $pdo->prepare('select s2.uuid,s2.username,s2.liked,s2.encounterd,s2.matched,s2.company_name,s2.company_industry,s2.career,s2.company_recruitment,s2.company_introduction,s2.company_link,s2.company_feature,s2.birth,s2.skill,s2.message,s2.self_introduction,s2.position,s2.ogori,s2.education,st_distance_sphere((select latlng from se_dummy where uuid = :uuid and !json_contains(se_dummy.encounterd,json_array(s2.uuid))),s2.latlng) as distance from re_dummy as s1 inner join re_dummy as s2 group by s2.uuid, s2.liked,s2.matched,s2.username,s2.encounterd,s2.company_name,s2.company_industry,s2.company_recruitment,s2.company_feature,s2.birth,s2.skill,s2.position,s2.career,s2.ogori,s2.company_introduction,s2.education,s2.message,s2.self_introduction,s2.company_link,s2.latlng having distance < :length and distance is not null order by distance asc limit 3');
		$stmt->bindValue(':uuid',$my_id,PDO::PARAM_STR);
		// $stmt->bindValue(':jsonuuid',$json,PDO::PARAM_STR);
		$stmt->bindValue(':length',$length,PDO::PARAM_INT);
		$stmt->execute();

		$userDataArray = array();


		while($row = $stmt->fetch(PDO::FETCH_ASSOC)){
			// echo $row['uuid'];
		    // echo $row['username'];

			 // $userDataArray[]=array(
		  //   'uuid'=>$row['uuid'],
		  //   'username'=>$row['username'],
		  //   'distance'=>$row['distance'],
		  //   'encounterd'=>json_decode($row['encounterd']),
		  //   'liked'=>json_decode($row['liked']),
		  //   'matched'=>json_decode($row['matched']),
		    // 'companyname'=>$row['companyname'],
		    // 'industry' =>json_decode($row['industry']),
		    // 'occupation'=>json_decode($row['occupation']),
		    // 'treat'=>json_decode($row['treat'])
		    // );

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

		header('Content-type: application/json');
		echo json_encode($userDataArray);

	}catch(Exception $e){
		echo "Error";
		echo $e->getMessage();
		exit();
	}


  ?>