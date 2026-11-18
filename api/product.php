<?php
require __DIR__.'/../lib/bootstrap.php';
try{
 $id=(int)($_GET['id']??0);$slug=trim($_GET['slug']??'');
 if(!$id&&!$slug)json_response(['error'=>'Producto no indicado'],422);
 $sql='SELECT p.*,c.name category_name,c.slug category_slug FROM products p LEFT JOIN categories c ON c.id=p.category_id WHERE p.is_published=1 AND '.($id?'p.id=?':'p.slug=?').' LIMIT 1';
 $q=db()->prepare($sql);$q->execute([$id?:$slug]);$p=$q->fetch();if(!$p)json_response(['error'=>'Producto no disponible'],404);
 $images=db()->prepare('SELECT id,path,alt_text,is_cover,sort_order,focal_x,focal_y FROM product_images WHERE product_id=? ORDER BY is_cover DESC,sort_order,id');$images->execute([$p['id']]);$p['images']=$images->fetchAll();
 $p['id']=(string)$p['id'];$p['price']=$p['price']===null?null:(float)$p['price'];$p['old_price']=$p['old_price']===null?null:(float)$p['old_price'];
 json_response(['product'=>$p]);
}catch(Throwable $e){json_response(['error'=>'No fue posible cargar el producto'],503);}
