<?php
header('Content-Type: application/json');

require_once('../clases/AutoCarga.php');
require_once('../clases/vendor/autoload.php');

//file_put_contents("peticiones.txt", $_SERVER['REQUEST_METHOD'] . " " . $_GET['url']  . " " .file_get_contents('php://input') . "\n", FILE_APPEND | LOCK_EX);

$json = json_decode(file_get_contents('php://input'));
$parametros = explode('/', $_GET['url']);
$api = new Api($_SERVER['REQUEST_METHOD'], $json, $parametros, $_GET);
$api->doTask();
echo $api->getResponse();

