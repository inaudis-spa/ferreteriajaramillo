<?php
require __DIR__.'/../lib/bootstrap.php';
try{$rows=db()->query('SELECT id,slot_key,label,media_type,path,focal_x,focal_y FROM site_media_slots ORDER BY id')->fetchAll();if(admin()){foreach($rows as &$r){$q=db()->prepare('SELECT id,path,focal_x,focal_y,created_at FROM site_media_history WHERE slot_id=? ORDER BY id DESC');$q->execute([$r['id']]);$r['history']=$q->fetchAll();}}json_response(['slots'=>$rows]);}catch(Throwable $e){json_response(['error'=>'Medios no disponibles'],503);}
