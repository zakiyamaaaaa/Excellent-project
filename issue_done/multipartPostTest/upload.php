<?php 

 $userData = file_get_contents('php://input');
// $data =  $_FILES["test"]["tmp_name"];
// $image = file_get_contents($_FILES["test"]["name"]);
// echo $userData;
// echo $userData;
$file_put_contents("./img/aaa.png",$userData);
 // echo var_dump($userData);

//下記のディレクトリ名は好きなもので
// $target_dir = "./img";
// if(!file_exists($target_dir))
// {
// mkdir($target_dir, 0777, true);
// }
// echo $_FILES["test"]["name"];
// $target_dir = $target_dir . "/" . basename($_FILES["test"]["name"]);

// if (move_uploaded_file($_FILES["test"]["tmp_name"], $target_dir)) {
// echo json_encode([
// "Message" => "The file ". basename( $_FILES["test"]["name"]). " has been uploaded.",
// "Status" => "OK",
// "Result" => "SUCCESS"
// ]);

// } else {

// echo json_encode([
// "Message" => "Sorry, there was an error uploading your file.",
// "Status" => "Error",
// "userId" => "failuer"
// ]);
// }

 ?>