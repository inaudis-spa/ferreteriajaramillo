<?php
require __DIR__.'/../lib/bootstrap.php';
try{
 $where='p.is_published=1';$args=[];
 if(($_GET['featured']??'')==='1')$where.=' AND p.is_featured=1';
 if(($_GET['offers']??'')==='1')$where.=' AND p.is_offer=1';
 if(!empty($_GET['ids'])){$ids=array_values(array_filter(array_map('intval',explode(',',$_GET['ids']))));if($ids){$where.=' AND p.id IN ('.implode(',',array_fill(0,count($ids),'?')).')';$args=$ids;}}
 $sql="SELECT p.*,c.name category_name,c.slug category_slug,(SELECT path FROM product_images i WHERE i.product_id=p.id ORDER BY i.is_cover DESC,i.sort_order,i.id LIMIT 1) image FROM products p LEFT JOIN categories c ON c.id=p.category_id WHERE $where ORDER BY p.sort_order,p.name";
 $q=db()->prepare($sql);$q->execute($args);$rows=$q->fetchAll();
 foreach($rows as &$r){$r['id']=(string)$r['id'];$r['category']=$r['category_slug']??'otros';$r['price']=$r['price']===null?null:(float)$r['price'];$r['old_price']=$r['old_price']===null?null:(float)$r['old_price'];}
 json_response(['products'=>$rows]);
}catch(Throwable $e){json_response(['error'=>'Catálogo no disponible'],503);}
