# Ferretería Lacustre — sitio web

Vitrina comercial y catálogo consultable para Ferretería Lacustre. Funciona como sitio estático (HTML, CSS y JavaScript), sin proceso de instalación.

Al ingresar, `ferreteria-lacustre-cargainicio.mp4` se reproduce como presentación de carga. Puede omitirse, se cierra al terminar y no se muestra a quienes tienen activada la preferencia de movimiento reducido.

## Uso local

Abrir `http://localhost/ferreterialacustre/` con Laragon iniciado. La web requiere PHP y MySQL para cargar el catálogo, por lo que no debe abrirse `index.html` directamente.

## Instalación del mantenedor

1. Importar `database/schema.sql` y luego `database/seed_products.sql` en MySQL usando codificación UTF-8 (`--default-character-set=utf8mb4` si se utiliza la consola).
2. Copiar `config.example.php` como `config.php` y ajustar las credenciales de MySQL si corresponde.
3. Abrir `/instalar/` desde el sitio y crear el primer administrador. El asistente se bloquea automáticamente después de crear la primera cuenta.

   Como alternativa, puede crearse desde una terminal:

   `php scripts/create-admin.php correo@dominio.cl "una-clave-de-12-o-mas-caracteres" "Nombre"`

4. Abrir `http://localhost/ferreterialacustre/admin/`.

El panel permite administrar productos, categorías, fotos de producto, medios del sitio con historial y la biblioteca de fotos de ofertas. Las cargas quedan separadas en `uploads/images` y `uploads/videos`; Apache bloquea allí la ejecución de scripts.

El catálogo completo está en `catalogo.html`. La portada consulta únicamente productos publicados marcados como **Destacado** en el mantenedor.

## Flujo comercial

- El visitante busca o filtra productos.
- Agrega productos y cantidades a “Mi cotización”. La lista se conserva en el navegador.
- La solicitud se envía al WhatsApp `+56 9 7291 2278`.
- El mensaje es una consulta: no cobra, no reserva inventario ni crea una orden.

## Contenido pendiente de confirmar

- Direcciones exactas y horarios de Villarrica, Labranza y Cunco.
- Políticas de retiro, despacho y cobertura.
- Catálogo definitivo, precios, marcas y disponibilidad.
- Dominio final para reemplazar la URL canónica relativa.

Los productos actuales se construyeron exclusivamente a partir de las fotografías proporcionadas y se presentan sin precio ni promesa de stock.
