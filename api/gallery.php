<?php
require __DIR__.'/../lib/bootstrap.php';
try{$where=admin()&&($_GET['all']??'')==='1'?'1':'is_published=1';if(($_GET['images']??'')==='1')$where.=" AND media_type='image'";$q=db()->query("SELECT * FROM gallery_media WHERE $where ORDER BY sort_order,id DESC");json_response(['media'=>$q->fetchAll()]);}catch(Throwable $e){json_response(['error'=>'Galería no disponible'],503);}
