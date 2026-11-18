<?php
if(PHP_SAPI!=='cli'){http_response_code(404);exit;}
require __DIR__.'/../lib/bootstrap.php';
[$script,$email,$password,$name]=array_pad($argv,4,'');
if(!$email||strlen($password)<12||!$name){fwrite(STDERR,"Uso: php scripts/create-admin.php correo clave-segura nombre\nLa clave debe tener al menos 12 caracteres.\n");exit(1);}
$q=db()->prepare('INSERT INTO admin_users(email,password_hash,name) VALUES(?,?,?)');$q->execute([strtolower($email),password_hash($password,PASSWORD_DEFAULT),$name]);echo "Administrador creado.\n";
