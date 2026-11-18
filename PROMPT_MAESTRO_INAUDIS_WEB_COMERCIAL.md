# Prompt maestro INAUDIS — Web comercial, catálogo, carrito y contenido administrable

**Uso:** entrega este Markdown a Codex o Cursor junto con el repositorio del nuevo proyecto y los materiales disponibles. El agente debe preguntar por los datos comerciales que falten y distinguir entre propuesta visual, implementación y publicación. No necesita acceso a la web de referencia para usar este archivo.

## Qué se extrae de Ferretería El Volcán

La referencia es [INAUDIS / Ferretería El Volcán, commit 846b343](https://github.com/inaudis-spa/ferreteriaelvolcan/commit/846b343be535c629f435de0a4e399318e79956a3). El proyecto usa HTML, CSS y JavaScript en el sitio público, PHP 8.3 y MySQL 8 para catálogo y administración. La revisión fue de código, no de producción.

| Componente | Patrón observado en El Volcán |
| --- | --- |
| Catálogo | Portada con destacados, catálogo completo, búsqueda, filtros, fichas y galerías. La API de catálogo expone productos publicados y admite consultar solo destacados. |
| Carrito de cotización | Guarda producto y cantidad en el navegador y arma una solicitud por WhatsApp. No cobra, no reserva stock, no registra una orden y no calcula despacho gratis. |
| Mantenedor | Alta, edición y publicación de productos y categorías. Admite precios, stock controlado o a consultar, destacados, ofertas y varias fotos por producto. |
| Fotos | La base guarda portada, orden, texto alternativo y punto focal. El procesador genera WebP y variantes de 480, 960 y 1600 px para nuevas fotografías. |
| Videos y fotos del sitio | Hay una galería general y puestos independientes para intro, hero, proyecto y portada de ofertas. La edición de estos puestos tiene historial y restauración. |
| Ventas y entrega | Cotización por WhatsApp, retiro en tienda y solicitud de despacho con confirmación comercial. |
| Diseño | Jerarquía visual y contenidos separados de los datos y el carrito. La estética, textos, videos y campañas del negocio de referencia no son requisitos para otro comercio. |

**Mejora a trasladar al proyecto nuevo:** el carrito no debe resolver sus líneas únicamente contra lo que aparece en la vista actual. En la referencia, la portada carga solo destacados y el carrito busca cada ID en la lista cargada. El nuevo proyecto debe poder mostrar un producto válido agregado desde el catálogo aunque no sea destacado.

**Puntos de lectura en el Git:** [portada](https://github.com/inaudis-spa/ferreteriaelvolcan/blob/846b343be535c629f435de0a4e399318e79956a3/index.html), [catálogo](https://github.com/inaudis-spa/ferreteriaelvolcan/blob/846b343be535c629f435de0a4e399318e79956a3/api/catalog.php), [carrito](https://github.com/inaudis-spa/ferreteriaelvolcan/blob/846b343be535c629f435de0a4e399318e79956a3/app.js), [panel](https://github.com/inaudis-spa/ferreteriaelvolcan/blob/846b343be535c629f435de0a4e399318e79956a3/admin/index.php), [modelo de datos](https://github.com/inaudis-spa/ferreteriaelvolcan/blob/846b343be535c629f435de0a4e399318e79956a3/database/schema.sql), [edición de medios](https://github.com/inaudis-spa/ferreteriaelvolcan/blob/846b343be535c629f435de0a4e399318e79956a3/api/admin-site-media.php) y [cargas](https://github.com/inaudis-spa/ferreteriaelvolcan/blob/846b343be535c629f435de0a4e399318e79956a3/lib/bootstrap.php).

---

## Prompt para Codex o Cursor

### 1. Misión y forma de trabajo

Actúa como desarrollador full-stack y diseñador web comercial para INAUDIS. Construye o amplía una web que el equipo del comercio pueda operar sin editar código. Separa el **diseño público**, las **reglas de venta**, la **fuente de datos** y el **mantenedor**. Conserva el stack, convenciones e integraciones del proyecto existente cuando sirvan. En un proyecto nuevo sin stack definido, presenta PHP 8.3 + MySQL 8 y JavaScript como opción compatible con Laragon, sin imponerlo si hay otra decisión.

Si te piden solo diseño o diagnóstico, no cambies código. Si te piden implementar, revisa primero el repositorio y explica qué reutilizarás y qué modificarás. No refactorices módulos ajenos, no sobrescribas datos ni medios existentes, y no publiques o cambies producción sin autorización explícita. Solicita permiso antes de ejecutar pruebas. Si el proyecto no define un alcance comercial, resuelve primero la pregunta que impide elegir el flujo. No pidas otra vez datos ya entregados.

### 2. Brief del nuevo comercio

Completa lo confirmado y deja como pendiente lo que falte.

| Dato | Entrada |
| --- | --- |
| Comercio, rubro, público y acción que más importa | [Completar] |
| Modo de venta | [Solo exhibición / cotización por WhatsApp / compra con pago] |
| Catálogo, categorías, SKUs, variantes, precios y stock | [Fuente y reglas] |
| Entrega | [Retiro / despacho / ambos]. Confirmar cobertura, costo y restricciones. |
| Identidad y material | [Logo, paleta, referencias, fotos, videos, derechos de uso] |
| Contacto, ubicación, horarios y dominio | [Datos comprobados] |
| Administración | [Quién edita qué y qué contenidos deben ser autoadministrables] |
| Repositorio, hosting y entorno | [URL o ruta, stack, rama, entorno local] |

Si faltan datos secundarios, avanza con supuestos declarados y reversibles. No inventes marcas, productos, stock, precios, cobertura, horarios, promociones ni plazos. Si usas material de muestra, etiquétalo y no lo publiques como inventario real. No copies el nombre ni el teléfono de El Volcán al nuevo proyecto.

### 3. Alcance por modo comercial

- **Solo exhibición.** Catálogo o servicios si aportan valor, fichas y contacto. No muestres ni implementes carrito por defecto.
- **Cotización por WhatsApp.** Usa “Mi pedido” o “Solicitar cotización”. El cliente arma su lista, elige entrega si corresponde y revisa el mensaje antes de abrir el canal. No afirmes que se creó una orden, se cobró o se reservó inventario.
- **Compra con pago.** Solo si está confirmada. Especifica pasarela, moneda, impuestos, cálculo de despacho, persistencia de orden y estados. Calcula importes en servidor, valida disponibilidad, verifica la confirmación del proveedor e impide procesar un mismo evento dos veces. Una pantalla de retorno no confirma el abono. Nunca guardes datos de tarjeta.

### 4. Catálogo público y carrito

- La base de datos es la fuente de verdad. Servir solo productos publicados. La portada puede pedir destacados, el catálogo completo debe ofrecer filtros, búsqueda y ficha con galería. Incluir estados de carga, vacío y error. No uses un catálogo de muestra como reemplazo silencioso si falla producción.
- Producto mínimo: ID estable, slug, nombre, categoría, descripción corta y larga, SKU, precio opcional, modo de stock, portada, imágenes y publicación. Marca, precio anterior, oferta y destacado son campos opcionales. Agrega variantes o precios por presentación solo si el comercio los necesita. Precio no informado no significa costo cero.
- Permite agregar, ajustar, eliminar y conservar cantidades al navegar. En cotización, guarda solo el identificador del producto o variante y la cantidad. Resuelve los datos contra el catálogo completo o un endpoint por IDs, no contra los resultados del filtro. Si cambian datos o disponibilidad, informa el cambio. Maneja almacenamiento no disponible o datos locales inválidos.
- El mensaje debe identificar comercio, ítems, cantidades, presentación si aplica, modalidad y localidad. Solicita dirección únicamente si se eligió despacho y es necesaria. No incluyas un total monetario para artículos sin precio confirmado. Genera el enlace desde el número autorizado y codifica correctamente el mensaje.
- Una promoción de despacho es **informativa** mientras no estén aprobados y definidos su cálculo, fuente de distancia, umbral, excepciones y cobertura. No la trates como regla universal ni copies los $100.000 o 7 km de El Volcán. Mantén consistente el mensaje del carrito, el banner y las condiciones publicadas.

### 5. Mantenedor de productos y categorías

- Acceso administrativo por sesión autenticada. Pantallas separadas para productos, categorías, medios y configuración comercial. En el listado de productos, búsqueda y filtros por publicación o categoría.
- Crear, editar, publicar y despublicar. Permitir ordenar y marcar destacado u oferta si se usan. Prefiere despublicar a borrar si hay referencias históricas. No elimines un producto o categoría sin considerar sus relaciones.
- Administrar múltiples fotos por producto, portada, orden, texto alternativo y punto focal. Confirmar acciones destructivas y mostrar errores junto al campo correspondiente. Cambios publicados deben verse en el catálogo respetando el caché que se defina.
- Usa consultas parametrizadas, escape de salida, contraseñas con hash, comprobación de permisos del lado servidor y protección CSRF en escrituras. No incluyas credenciales reales ni instales usuarios por defecto. Separa respaldo de base de datos y de archivos.

### 6. Fotos, videos y gestión de contenido

Mantén tres conceptos independientes:

| Biblioteca | Qué administra |
| --- | --- |
| Fotos de producto | Varias imágenes, portada, texto alternativo, orden y encuadre. Conserva calidad suficiente para ver detalles. |
| Galería general | Fotos y videos que no pertenecen a una ficha. Título, descripción, orden y visibilidad. |
| Medios del sitio | Puestos editables como hero, portada de campaña o video destacado. Cada puesto define tipo, reemplazo, fallback y, si se requiere, historial y restauración. |

Valida tipo real y tamaño en servidor, genera nombres seguros, bloquea la ejecución de scripts en cargas, y no borres un archivo usado por otro contenido. Para imágenes, corrige orientación cuando haya EXIF y ofrece WebP y tamaños adaptados al uso real. Para video web, usa un formato compatible, peso acordado, imagen de portada y reemplazo por imagen si no carga. No reproduzcas audio automáticamente. Una intro es opcional y no debe retrasar el acceso. Respeta la preferencia de movimiento reducido. El logo, banners y video deben poder cambiar sin alterar el carrito.

### 7. Diseño general, SEO local y contenido encontrable

- Define paleta, tipografías, escala, espaciado y componentes desde la identidad del nuevo comercio. Considera dos direcciones visuales si aún se está eligiendo diseño. Reutiliza comportamientos y componentes, no calques la estética de El Volcán.
- Estructura modular sugerida: encabezado, hero con acción clara, categorías o servicios, destacados, propuesta de valor, entrega o cobertura y pie con contacto. Solo usa promos, videos y secciones que aporten al objetivo. Si se pide menú fijo, comprueba scroll, anclas, modal del carrito y navegación móvil.
- Trabaja primero el flujo móvil. Mantén contraste, foco visible, acciones cómodas, jerarquía de encabezados, estados sin depender del color y tamaño reservado para imágenes y videos. El botón de catálogo o cotización debe ser HTML, no parte de una imagen.
- Usa títulos, descripciones y URLs descriptivas, canónicas y sitemap coherentes cuando correspondan. Publica dirección, contacto, horarios y cobertura solo si están confirmados. Usa datos estructurados con datos reales y consistentes con lo visible. No crees páginas locales duplicadas ni prometas aparecer en Google o en respuestas de IA.

### 8. Orden de implementación y entrega

1. Entrega diagnóstico, alcance elegido, incógnitas y archivos que tocarías. Reutiliza módulos existentes antes de crear alternativas.
2. Define modelo y migraciones. Base sugerida cuando corresponda: usuarios administrativos, categorías, productos, imágenes, galería, puestos de medios e historial. Agrega órdenes únicamente para compra con pago.
3. Implementa mantenedor y catálogo conectado. Después implementa el flujo de venta seleccionado y el manejo de entrega.
4. Integra identidad, medios, navegación y SEO. Documenta configuración de entorno, instalación, ubicación de cargas y operaciones de mantenimiento en el README.
5. Presenta cambios y lista de verificaciones. No declares una prueba que no se ejecutó ni un despliegue que no se confirmó.

**Criterios de aceptación para validar cuando se autorice:** un cambio de producto publicado se refleja en el catálogo, un borrador no es público, un producto no destacado permanece en el carrito al volver al inicio, la cantidad sobrevive a recarga, una imagen de portada se cambia sin romper la galería, un video faltante muestra su respaldo, una escritura sin permisos se rechaza, y el menú y el carrito no se tapan entre sí en móvil. Verifica además el flujo elegido: solo exhibición sin carrito, cotización bien armada sin afirmar que hubo una compra, o pago confirmado y registrado una sola vez.
