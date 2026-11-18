(()=>{
  const hero=document.querySelector('.offers-hero');if(!hero)return;
  const asset=path=>path.includes('/')?path.split('/').map(encodeURIComponent).join('/'):`ferreterialacustre/${encodeURIComponent(path)}`;
  const esc=value=>String(value??'').replace(/[&<>"']/g,char=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#039;'}[char]));
  async function load(){let photos=[];try{const response=await fetch('api/gallery.php?images=1');if(response.ok)photos=(await response.json()).media.map(item=>({path:item.path,title:item.title||'Oferta Lacustre',x:item.focal_x||50,y:item.focal_y||50}))}catch{}if(photos.length)render(photos)}
  function render(photos){
    const section=document.createElement('section');section.className='offers-photo-showcase';
    const cards=photos.map(photo=>{const src=asset(photo.path),title=esc(photo.title);return `<figure role="button" tabindex="0" data-lightbox-src="${src}" data-lightbox-alt="${title}" aria-label="Ampliar ${title}"><img src="${src}" alt="${title}" loading="lazy" style="object-position:${photo.x}% ${photo.y}%"><span class="photo-zoom" aria-hidden="true">＋</span><figcaption>${title}</figcaption></figure>`}).join('');
    section.innerHTML=`<div class="shell offers-photo-heading"><p class="kicker">Inspírate y encuentra</p><h2>Oportunidades en movimiento</h2></div><div class="offers-photo-window"><div class="offers-photo-track">${cards}${cards}</div></div>`;
    hero.insertAdjacentElement('afterend',section);
    section.querySelectorAll('[data-lightbox-src]').forEach(card=>{card.addEventListener('click',()=>openLightbox(card));card.addEventListener('keydown',event=>{if(event.key==='Enter'||event.key===' '){event.preventDefault();openLightbox(card)}})});
  }
  function openLightbox(card){
    closeLightbox();const overlay=document.createElement('div');overlay.className='photo-lightbox';overlay.innerHTML=`<button type="button" class="photo-lightbox-close" aria-label="Cerrar imagen">×</button><figure><img src="${card.dataset.lightboxSrc}" alt="${esc(card.dataset.lightboxAlt)}"><figcaption>${esc(card.dataset.lightboxAlt)}</figcaption></figure>`;document.body.appendChild(overlay);document.body.classList.add('lightbox-open');overlay.querySelector('button').focus();overlay.addEventListener('click',event=>{if(event.target===overlay||event.target.closest('.photo-lightbox-close'))closeLightbox()});
  }
  function closeLightbox(){document.querySelector('.photo-lightbox')?.remove();document.body.classList.remove('lightbox-open')}
  document.addEventListener('keydown',event=>{if(event.key==='Escape')closeLightbox()});load();
})();
