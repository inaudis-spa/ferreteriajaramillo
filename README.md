# Ferretería Lacustre — sitio web

Sitio comercial con catálogo, productos destacados, ofertas, cotización por WhatsApp y panel administrativo.

## Instalación

1. Crear una base de datos MySQL llamada `ferreteria_lacustre`.
2. Importar únicamente `database/schema.sql` usando codificación UTF-8. Este archivo crea las tablas y carga categorías, 24 productos, imágenes, destacados, ofertas y medios iniciales.
3. Copiar `config.example.php` como `config.php` y configurar las credenciales de MySQL.
4. Abrir `/instalar/` y crear el primer administrador.
5. Ingresar al panel desde `/admin/`.

Para una instalación antigua que ya tenga las tablas pero no los productos, importar `database/seed_products.sql`.

Como alternativa, `database/deploy_database.sql` contiene una copia completa de la estructura y de los datos actuales de catálogo, categorías, imágenes, destacados, ofertas y medios. Por seguridad no contiene cuentas administradoras ni hashes de contraseñas.

Las credenciales de producción no deben guardarse en Git. `config.example.php` admite las variables de entorno `LACUSTRE_DB_DSN`, `LACUSTRE_DB_USER` y `LACUSTRE_DB_PASS`. En un hosting sin variables de entorno, copia el archivo como `config.php`, completa allí las credenciales y mantén ese archivo fuera del repositorio.

## Contenido inicial

- 24 productos publicados en el catálogo.
- 8 productos destacados para la portada.
- 3 productos marcados inicialmente como oferta.
- Fotografías de producto vinculadas al catálogo.
- Logo, videos y galería promocional configurados.

Los productos iniciales no incluyen precios comerciales. Desde el panel se puede ingresar el precio normal, el precio oferta, stock, descripciones y estado de publicación.

## Administración

El panel permite administrar productos, categorías, fotos de producto, medios generales con historial y fotografías de ofertas. Las cargas se almacenan separadamente en `uploads/images` y `uploads/videos`.

La portada muestra únicamente productos que estén simultáneamente **publicados** y marcados como **destacados**. La página de ofertas muestra productos publicados con la opción **En oferta** activa.

## Flujo comercial

- El visitante navega por el catálogo.
- Agrega productos y cantidades a su cotización.
- Ingresa nombre y teléfono.
- Envía la solicitud al WhatsApp `+56 9 7291 2278`.

La solicitud no cobra, no reserva inventario ni genera automáticamente una orden.
