
# 📦 Sistema de Inventario para Textil Anahui S.A.C.

![Texto alternativo](/public/assets/img/anahui.png)


## 1. Descripción General

El **Sistema de Inventario de Textil Anahui** es una solución web desarrollada con el objetivo de **optimizar, automatizar y digitalizar los procesos logísticos** del área de Tejeduría en la empresa **Textil Anahui S.A.C.**, ubicada en Lima, Perú. Esta herramienta permite una gestión centralizada y en tiempo real del inventario de telas, materias primas, compras, ventas y trazabilidad de acciones del personal.

---

## 2. Beneficios para el Área Logística

| Funcionalidad Clave                 | Beneficio Directo                                                 |
| ----------------------------------- | ----------------------------------------------------------------- |
| 📊 **Stock en tiempo real**         | Evita quiebres o excesos de inventario.                           |
| 🔄 **Control de movimientos**       | Trazabilidad completa de entradas y salidas mediante Kardex.      |
| 🛒 **Optimización de compras**      | Basada en stock mínimo y consumo histórico.                       |
| 🧾 **Auditoría de acciones (logs)** | Historial detallado de actividades para control y seguridad.      |
| 🗂️ **Gestión por almacenes**       | Organización eficiente según tipo de producto y ubicación física. |

---

## 3. Funcionalidades Principales

* **🧵 Gestión de Productos Textiles**
  Registro detallado de telas tejidas (tipo, composición, medidas, presentación).

* **📦 Gestión de Compras y Ventas**
  Módulo para registrar y visualizar operaciones con proveedores y clientes.

* **👥 Gestión de Personal y Roles**
  Asignación de usuarios por cargo con permisos diferenciados (ej. Tejedor, Supervisor).

* **📈 Reportes Automatizados**
  Informes sobre stock, movimientos, ventas por producto o categoría, entre otros.

* **🔐 Seguridad y Control de Acceso**
  Sistema de autenticación con control de roles y auditoría mediante `activity_logs`.

---

## 4. Tecnologías Utilizadas

| Componente          | Tecnología                                  |
| ------------------- | ------------------------------------------- |
| **Backend**         | PHP 8.x, Laravel 10.x                       |
| **Frontend**        | Blade Templates, Tailwind CSS (opcional)    |
| **Base de Datos**   | MySQL 5.7 o superior                        |
| **Dependencias**    | Composer                                    |
| **Procesos**        | Laravel Queues para tareas en segundo plano |
| **Datos de prueba** | Faker para generación de datos simulados    |

---

## 5. Requisitos del Sistema

* PHP 8.1 o superior
* MySQL 5.7 o superior
* Composer
* Node.js (para estilos y scripts opcionales)
* Git (clonación del repositorio)

---

## 6. Instalación y Configuración

```bash
# Clonar el repositorio
git clone https://github.com/your-username/textil-anahui-inventory.git
cd textil-anahui-inventory

# Instalar dependencias
composer install

# Configurar entorno
cp .env.example .env
# Editar las variables de entorno en .env (DB, APP_NAME, etc.)
php artisan key:generate

# Migrar y poblar la base de datos
php artisan migrate --seed

# Crear enlace simbólico a almacenamiento
php artisan storage:link

# Iniciar servidor local
php artisan serve
```

---

## 7. Estructura de la Base de Datos (Tablas Clave)

* **Productos y Categorías**: `productos`, `categorias`, `presentaciones`
* **Inventario y Movimientos**: `inventario`, `kardex`, `movimientos`
* **Compras/Ventas**: `compras`, `ventas`, `producto_venta`
* **Usuarios y Roles**: `users`, `roles`, `permissions`, `empleados`
* **Auditoría**: `activity_logs` (registro de acciones en el sistema)

---

## 8. Guía de Uso

1. **Inicio de sesión** con credenciales de administrador o usuario asignado.
2. **Administrar inventario**: Agregar productos, registrar existencias por almacén.
3. **Procesar compras o ventas**: Registrar operaciones con insumos o telas terminadas.
4. **Consultar reportes** por periodo, producto, tipo de operación o almacén.
5. **Gestionar usuarios y roles** con diferentes permisos según responsabilidades.

---

## 9. Licencia

Este software se distribuye bajo la **Licencia MIT**, permitiendo su uso, modificación y distribución bajo los términos definidos en dicha licencia.

---

## 10. Contacto

**Desarrollador Principal:**
Cristhian Paul Calloquispe Cusi
📧 [paulcalloquispe2700@gmail.com](mailto:paulcalloquispe2700@gmail.com)
📍 Lima, Perú
# textil-anahui-inventory-system
# textil-anahui-inventory-system
