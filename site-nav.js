import('./site-media-runtime.js');
import('./visual-editor.js');
(()=>{
  const nav=document.querySelector('.site-header nav');if(!nav)return;
  const page=location.pathname.split('/').pop()||'index.html';
  const items=[['index.html','Inicio'],['catalogo.html','Catálogo'],['ofertas.html','Ofertas'],['index.html#locales','Locales']];
  nav.innerHTML=items.map(([href,label])=>{const target=href.split('#')[0],active=page===target&&(!href.includes('#')||location.hash==='#locales');return `<a href="${href}" ${active?'aria-current="page" class="active"':''}>${label}</a>`}).join('');
  nav.id='main-navigation';
  if(!document.querySelector('.menu-toggle')){const button=document.createElement('button');button.type='button';button.className='menu-toggle';button.setAttribute('aria-controls','main-navigation');button.setAttribute('aria-expanded','false');button.innerHTML='<span></span><span></span><span></span><b>Menú</b>';nav.before(button);button.onclick=()=>{const open=nav.classList.toggle('open');button.setAttribute('aria-expanded',String(open))};nav.addEventListener('click',event=>{if(event.target.closest('a')){nav.classList.remove('open');button.setAttribute('aria-expanded','false')}})}
  if(!document.querySelector('.social-float')){
    const social=document.createElement('div');social.className='social-float';social.setAttribute('aria-label','Redes sociales y contacto');
    social.innerHTML='<a class="social-instagram" href="https://www.instagram.com/ferreteria.lacustre/" target="_blank" rel="noopener noreferrer" aria-label="Ferretería Lacustre en Instagram"><svg viewBox="0 0 24 24" aria-hidden="true"><rect x="3" y="3" width="18" height="18" rx="5"/><circle cx="12" cy="12" r="4"/><circle cx="17.5" cy="6.5" r="1" class="dot"/></svg></a><a class="social-whatsapp" href="https://wa.me/56972912278?text=Hola%20Ferreter%C3%ADa%20Lacustre%2C%20necesito%20ayuda." target="_blank" rel="noopener noreferrer" aria-label="Contactar a Ferretería Lacustre por WhatsApp"><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M20 11.6a8 8 0 0 1-11.8 7L4 20l1.4-4A8 8 0 1 1 20 11.6Z"/><path d="M8.5 7.8c.3-.4.6-.4.9-.1l1.1 1.5c.2.3.1.6-.1.9l-.5.6c.7 1.5 1.8 2.6 3.3 3.2l.6-.7c.2-.2.5-.3.8-.1l1.6.8c.4.2.4.5.3.9-.4 1-1.3 1.5-2.4 1.4-3.8-.5-6.8-3.4-7.3-7.1-.1-.6.5-1.1 1.7-1.3Z"/></svg></a>';
    document.body.appendChild(social);
  }
})();
