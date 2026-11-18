# Prompt para Codex o Cursor — Mantenedores de Ferretería El Volcán

**Referencia:** rama main de [INAUDIS / Ferretería El Volcán, commit 846b343](https://github.com/inaudis-spa/ferreteriaelvolcan/commit/846b343be535c629f435de0a4e399318e79956a3). Basado en lectura de código, no en pruebas de producción.

**Cómo usarlo:** entrega este archivo al nuevo proyecto y pide replicar los flujos. Conserva la experiencia administrativa de El Volcán, pero usa la identidad visual y los medios del nuevo cliente. No reemplaza el prompt maestro de la web completa. Este documento detalla exclusivamente los mantenedores.

---

## Prompt listo para usar

Actúa como desarrollador full-stack. Replica la experiencia administrativa de Ferretería El Volcán con dos entradas claras: **Medios de la web** y **Productos**. Dentro del panel, conserva también **Categorías** y **Fotos de ofertas** como flujos relacionados e independientes. Implementa sobre el stack existente. La referencia usa PHP, MySQL y JavaScript sin compilación. Mantén el diseño público desacoplado del modo de edición.

Si te pido solo revisar o plantear el diseño, no modifiques código. Si autorizo implementar, identifica los archivos y componentes que tocarás. No refactorices el carrito ni cambies producción. Pide autorización antes de ejecutar pruebas.

### 1. Medios de la web — edición sobre la misma página

**Objetivo:** un administrador puede cambiar el video o la foto de una sección concreta de la página sin editar el código y sin modificar los demás medios.

1. El administrador inicia sesión en el panel y selecciona **Medios de la web**. En El Volcán el acceso lleva a `index.html?edit=media`.
2. La web consulta `api/admin-session.php`. Solo con sesión válida muestra la barra administrativa y los controles visuales. El parámetro de URL activa la vista, **no otorga permisos**.
3. En la portada, muestra el botón **Cambiar** para cada video conectado. El video de introducción se cambia desde la barra administrativa. El hero y el proyecto se cambian en sus propios bloques. Un enlace abre **Editar portada de ofertas** en `ofertas.html?edit=media`.
4. Al abrir el editor, muestra el nombre del espacio, lo que está publicado, selector de archivo, vista previa de la carga y acciones de guardar o restaurar. Para imágenes muestra encuadre X/Y de 0 a 100 con vista previa. Los videos se previsualizan, pero no tienen editor de encuadre. En el código de referencia se guardan con X/Y en 50.
5. Al guardar, sube solo el archivo del espacio elegido y actualiza ese bloque. Al volver a cargar, debe seguir el nuevo medio. Si no se puede resolver el medio desde la API, conserva el recurso inicial de la página.

| Espacio verificado | Tipo | Dónde aparece |
| --- | --- | --- |
| `intro_video` | Video | Introducción de carga, elemento `#loader-video`. |
| `hero_video` | Video | Hero de inicio, elemento `#hero-video`. |
| `terrace_video` | Video | Proyecto de terraza, elemento `#terrace-video`. Para otro negocio, adapta solo este bloque. |
| `offers_cover` | Imagen | Fondo de la portada de ofertas. Usa el punto focal como posición del fondo. |

**Importante:** el botón de guardar portada de ofertas en la referencia exige seleccionar un archivo. No prometas que permite guardar solo el encuadre de la foto actual. No confundas la portada de ofertas con la galería de la página.

#### Contrato técnico de medios

- **Lectura:** `GET api/site-media.php` expone los espacios con `slot_key`, etiqueta, tipo, ruta y foco. El historial se agrega solo si la sesión es de administrador.
- **Reemplazo:** `POST api/admin-site-media.php` con sesión, CSRF, `slot_key` y archivo `media` en multipart. Para una imagen admite `focal_x` y `focal_y`. El servidor identifica el tipo permitido a partir del espacio, no a partir de la elección del navegador.
- **Restauración:** mismo endpoint con `action=restore`, `history_id` y el espacio. Valida que la versión pertenezca al espacio. En la misma transacción, registra la versión actual en historial y activa la seleccionada con sus puntos focales. Reemplazar también guarda la versión anterior. **No borres archivos referenciados por el historial.**
- **Persistencia:** `site_media_slots` guarda la versión activa. `site_media_history` guarda versiones previas por ID de espacio. En la portada, `app.js` aplica las rutas a los videos. En ofertas, `ofertas.js` aplica la foto y el encuadre al fondo.
- Da respuesta clara al usuario si falta un archivo, no se acepta su formato, supera el máximo o la sesión no está vigente. Ningún visitante debe poder cargar archivos o restaurar versiones.

### 2. Productos — panel completo y edición rápida

El Volcán tiene **dos niveles de edición del mismo producto**. Ambos guardan en MySQL, pero tienen alcance distinto.

| Nivel | Entrada | Qué permite |
| --- | --- | --- |
| Panel completo | `/admin/index.php?section=products` | Crear, editar, publicar o despublicar. Administrar precios, oferta, destacado, SEO, orden y fotos. También existe eliminación definitiva. |
| Edición rápida | Botón **Editar** en una tarjeta visible de la web, solo para administrador y fuera del modo de medios | Cambiar nombre, categoría, descripción corta, descripción larga, precio, stock y publicación. Incluye acceso al panel completo para gestionar fotos. |

#### Panel completo

- Muestra el listado de productos con portada, categoría, precio y estado. Permite crear uno nuevo y editar los existentes. Los estados **Publicado**, **Destacado** y **En oferta** se pueden cambiar de forma independiente. El formulario de producto nuevo trae publicación, oferta y destacado desmarcados.
- Campos: nombre obligatorio, categoría opcional, SKU, slug, marca, descripción corta y larga, título SEO, descripción SEO, indexación, precio, precio anterior, stock, modo de stock, destacado, oferta, publicación y orden. Slug generado desde el nombre cuando no se ingresa uno. Slug único y SKU único cuando existe. Precio vacío es sin precio informado, no cero.
- **Control de stock:** `track` para stock controlado y `consult` para stock a consultar. Guardar una cantidad no implica reservar unidades ni cambiar el funcionamiento del carrito de cotización.
- **Fotos del producto:** admite varias en una carga. La primera se convierte en portada si el producto no tenía fotos. Cada foto tiene texto alternativo, orden y foco X/Y. Permite seleccionar otra portada y eliminar una foto. La API entrega la galería con portada primero y luego por orden.
- **Categorías:** crear y editar nombre, slug, descripción, título SEO, descripción SEO, contenido SEO/GEO, indexación, orden y activación. Archivar desactiva la categoría **sin borrar los productos asociados**.
- **Eliminación definitiva:** existe en El Volcán. Mantén la distinción con despublicar y pide confirmación explícita en la interfaz. No mezcles la eliminación del producto con el historial de medios del sitio.

#### Edición rápida y publicación

- Al abrir **Editar**, precarga el producto y las categorías activas. Envía `POST api/admin-product.php` con ID, sesión, CSRF y **solo** los campos rápidos anteriores. No permite cambiar SKU, slug, marca, precio anterior, modo de stock, SEO, fotos, oferta ni destacado desde el panel rápido.
- Tras guardar, la referencia recarga catálogo y carrito, cierra el editor y muestra confirmación. Los borradores no aparecen en el catálogo público. Si se despublica un producto visible, la edición completa se conserva desde el panel.
- La portada pide `api/catalog.php?featured=1`. El catálogo completo pide `api/catalog.php`. Ambos devuelven solo productos activos. La primera ruta exige, además, que estén destacados. Conserva la separación entre tarjeta visible y fuente de verdad del carrito.

### 3. Fotos de ofertas — biblioteca separada

En el menú del panel se llama **Fotos de ofertas** y abre `admin/index.php?section=gallery`. La biblioteca acepta fotos y videos. Permite agregar archivo y título, descripción, orden y publicación. En edición permite cambiar metadatos, visibilidad y encuadre. También permite eliminar.

`api/gallery.php` devuelve los medios publicados. **La galería pública de ofertas filtra solo imágenes**, aunque el panel acepte videos. No presentes eso como galería pública de videos ya implementada. La foto de fondo de ofertas se cambia por el espacio `offers_cover`, no desde este listado.

### 4. Carga y seguridad comunes

- En El Volcán, formatos de foto: JPEG, PNG, WebP. Formatos de video: MP4 y WebM. Límites por defecto: **8 MB para fotos y 40 MB para videos**, configurables y sujetos también a los límites de PHP y del servidor.
- Comprueba el MIME real, genera nombres aleatorios y separa `uploads/images/` y `uploads/videos/`. Las fotos se convierten a WebP con GD, calidad 82 y variantes de hasta **480, 960 y 1600 px**, sin agrandar originales pequeños. Si JPEG trae orientaciones EXIF compatibles, se corrigen. Los videos se guardan en el formato aceptado, **sin transcodificación automática**.
- Usa permisos de administrador del lado servidor, sesión, CSRF y consultas parametrizadas. No permitas ejecutar scripts en el directorio de cargas. Separa `products` y `product_images` de `gallery_media`, `site_media_slots` y `site_media_history`.

### 5. Límites de la réplica y entrega

Reproduce el comportamiento visible, no los defectos de la referencia. Si el nuevo proyecto requiere que siempre exista una sola portada, asegura esa condición también al borrar una foto secundaria. El borrado de fotos en el código de referencia marca otra imagen como portada sin limpiar la marca anterior. No agregues edición de video, archivos multimedia por variante, ni historial de producto si no se pide.

Entrega primero un mapa breve de pantallas, botones, endpoints, tablas y archivos a tocar. Cuando se autoricen pruebas, valida: visitante sin controles ni acceso de escritura, cambio y restauración de un medio sin afectar otro, imagen con foco guardado, creación y publicación de producto, edición rápida sin alterar los campos del panel, y carga de varias fotos con portada y orden correctos.

## Archivos de referencia

- [Panel y acciones de administración](https://github.com/inaudis-spa/ferreteriaelvolcan/blob/846b343be535c629f435de0a4e399318e79956a3/admin/index.php)
- [Edición en vivo y catálogo](https://github.com/inaudis-spa/ferreteriaelvolcan/blob/846b343be535c629f435de0a4e399318e79956a3/app.js)
- [Portada y galería de ofertas](https://github.com/inaudis-spa/ferreteriaelvolcan/blob/846b343be535c629f435de0a4e399318e79956a3/ofertas.js)
- [Escritura de medios del sitio](https://github.com/inaudis-spa/ferreteriaelvolcan/blob/846b343be535c629f435de0a4e399318e79956a3/api/admin-site-media.php)
- [Escritura rápida de productos](https://github.com/inaudis-spa/ferreteriaelvolcan/blob/846b343be535c629f435de0a4e399318e79956a3/api/admin-product.php)
- [Modelo de datos](https://github.com/inaudis-spa/ferreteriaelvolcan/blob/846b343be535c629f435de0a4e399318e79956a3/database/schema.sql)
