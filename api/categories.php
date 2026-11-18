<?php
require __DIR__.'/../lib/bootstrap.php';
try{if(admin()&&($_GET['all']??'')==='1'){$q=db()->query('SELECT * FROM categories ORDER BY sort_order,name');}else{$q=db()->query('SELECT * FROM categories WHERE is_active=1 ORDER BY sort_order,name');}json_response(['categories'=>$q->fetchAll()]);}catch(Throwable $e){json_response(['error'=>'Categorías no disponibles'],503);}
