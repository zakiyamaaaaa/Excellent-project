<?php 

 // $userData = file_get_contents('php://input');
// $path =  $_FILES["test"]["tmp_name"];
// $post = $_POST["test"];
// $image = file_get_contents($_FILES["test"]["name"]);
// echo $userData;
// echo $userData;
// $data = file_get_contents($path);
// $tmpImg = imagecreatefromstring($data);
// imagepng($tmpImg,"./img/");
// file_put_contents("./img/aaa.png",$data);
 // echo var_dump($path);
// echo var_dump($post);

//下記のディレクトリ名は好きなもので
// $pathData = pathinfo($_FILES["upfile"]["tmp_name"]);
// $filename = $pathData["filename"];
// $filename = $_FILES["upfile"]["name"];
$filename = basename($_FILES["upfile"]["name"],".png");
$target_dir = "./img/{$filename}";
if(!file_exists($target_dir))
{
mkdir($target_dir, 0777, true);
}

$target_dir = $target_dir . "/" . basename($_FILES["upfile"]["name"]);

if (move_uploaded_file($_FILES["upfile"]["tmp_name"], $target_dir)) {
echo json_encode([
"Message" => "The file ". basename( $_FILES["upfile"]["name"]). " has been uploaded.",
"Status" => "OK",
"Result" => "SUCCESS"
]);

} else {

echo json_encode([
"Message" => "Sorry, there was an error uploading your file.",
"Status" => "Error",
"userId" => "failuer"
]);
}

 ?>