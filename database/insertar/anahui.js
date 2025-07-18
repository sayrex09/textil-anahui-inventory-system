import mysql from 'mysql2/promise';
import { faker } from '@faker-js/faker';

async function populateDatabase() {
  const connection = await mysql.createConnection({
    host: '127.0.0.1',
    user: 'root',
    password: 'root',
    database: 'anahui'
  });

  console.log('✅ Conectado a la base de datos');

  try {
    await connection.beginTransaction();
    console.log('🔄 Transaction started');

    // Insert monedas (unchanged, as currency is generic)
    const monedas = [
      { estandar_iso: 'PEN', nombre_completo: 'Sol Peruano', simbolo: 'S/' },
      { estandar_iso: 'USD', nombre_completo: 'Dólar Estadounidense', simbolo: '$' },
      { estandar_iso: 'EUR', nombre_completo: 'Euro', simbolo: '€' }
    ];
    for (const moneda of monedas) {
      try {
        await connection.execute(
          `INSERT IGNORE INTO monedas (estandar_iso, nombre_completo, simbolo, created_at, updated_at) 
           VALUES (?, ?, ?, NOW(), NOW())`,
          [moneda.estandar_iso, moneda.nombre_completo, moneda.simbolo]
        );
      } catch (error) {
        console.warn(`⚠️ Error inserting moneda ${moneda.estandar_iso}: ${error.message}`);
      }
    }
    console.log('✅ Inserted/verified monedas');

    // Insert empresa (updated to emphasize weaving focus)
    const [empresaRows] = await connection.execute(
      `SELECT id FROM empresa WHERE moneda_id = ?`,
      [1]
    );
    if (empresaRows.length === 0) {
      await connection.execute(
        `INSERT INTO empresa (nombre, propietario, ruc, porcentaje_impuesto, abreviatura_impuesto, direccion, correo, telefono, ubicacion, moneda_id, created_at, updated_at) 
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())`,
        [
          'Textil Anahui SAC - Área de Tejeduría',
          'Anahui Owner',
          '20338996706',
          18,
          'IGV',
          'Av. Aviación Nro. 476 Int. 308, Lima',
          'contacto@anahuitejeduria.pe',
          faker.string.numeric({ length: 9 }),
          'Lima, Perú',
          1
        ]
      );
      console.log('✅ Inserted empresa');
    } else {
      console.log('⚠️ Empresa with moneda_id = 1 already exists');
    }

    // Insert documentos (unchanged, as document types are generic)
    const documentos = ['DNI', 'RUC', 'Carnet de Extranjería', 'Pasaporte'];
    for (const nombre of documentos) {
      try {
        await connection.execute(
          `INSERT IGNORE INTO documentos (nombre, created_at, updated_at) VALUES (?, NOW(), NOW())`,
          [nombre]
        );
      } catch (error) {
        console.warn(`⚠️ Error inserting documento ${nombre}: ${error.message}`);
      }
    }
    console.log('✅ Inserted/verified documentos');

    // Insert personas (unchanged, as personas are generic)
    const personas = [];
    for (let i = 0; i < 100; i++) {
      try {
        const numero_documento = faker.string.numeric({ length: { min: 8, max: 11 } });
        const [result] = await connection.execute(
          `INSERT INTO personas (razon_social, direccion, telefono, tipo, email, estado, documento_id, numero_documento, created_at, updated_at) 
           VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())`,
          [
            faker.person.fullName(),
            faker.location.streetAddress(),
            faker.string.numeric({ length: 9 }),
            faker.helpers.arrayElement(['NATURAL', 'JURIDICA']),
            faker.internet.email(),
            1,
            faker.helpers.arrayElement([1, 2, 3, 4]),
            numero_documento
          ]
        );
        personas.push(result.insertId);
      } catch (error) {
        console.warn(`⚠️ Error inserting persona: ${error.message}`);
      }
    }
    console.log('✅ Inserted personas');

    // Insert clientes (unchchanged, as clients are generic)
    const clientes = [];
    for (let i = 0; i < Math.min(100, personas.length); i++) {
      try {
        const [result] = await connection.execute(
          `INSERT INTO clientes (persona_id, created_at, updated_at) VALUES (?, NOW(), NOW())`,
          [personas[i]]
        );
        clientes.push(result.insertId);
      } catch (error) {
        console.warn(`⚠️ Error inserting cliente for persona_id ${personas[i]}: ${error.message}`);
      }
    }
    console.log('✅ Inserted clientes');

    // Insert proveedores (updated to include weaving-related suppliers)
    for (let i = Math.min(5, personas.length); i < personas.length; i++) {
      try {
        await connection.execute(
          `INSERT INTO proveedores (persona_id, created_at, updated_at) VALUES (?, NOW(), NOW())`,
          [personas[i]]
        );
      } catch (error) {
        console.warn(`⚠️ Error inserting proveedor for persona_id ${personas[i]}: ${error.message}`);
      }
    }
    console.log('✅ Inserted proveedores');

    // Insert caracteristicas (updated for weaving-specific attributes)
    const caracteristicas = [];
    const weavingAttributes = [
      { nombre: 'Hilo Algodón', descripcion: 'Hilo de algodón de alta calidad para tejeduría' },
      { nombre: 'Hilo Poliéster', descripcion: 'Hilo sintético resistente para tejidos duraderos' },
      { nombre: 'Tejido Plano', descripcion: 'Patrón de tejido plano para telas uniformes' },
      { nombre: 'Tejido Sarga', descripcion: 'Patrón de tejido en diagonal para mayor resistencia' },
      { nombre: 'Tejido Satén', descripcion: 'Tejido suave y brillante para acabados premium' },
      { nombre: 'Hilo de 20/2', descripcion: 'Hilo de algodón con grosor 20/2' },
      { nombre: 'Hilo de 30/1', descripcion: 'Hilo de algodón con grosor 30/1' },
      { nombre: 'Densidad 60 hilos/cm', descripcion: 'Densidad de tejido de 60 hilos por cm' },
      { nombre: 'Densidad 80 hilos/cm', descripcion: 'Densidad de tejido de 80 hilos por cm' },
      { nombre: 'Acabado Suave', descripcion: 'Tratamiento para suavidad al tacto' },
      { nombre: 'Acabado Antimanchas', descripcion: 'Tratamiento resistente a manchas' },
      { nombre: 'Tejido Elástico', descripcion: 'Tejido con elasticidad para prendas ajustadas' },
      { nombre: 'Tejido Mezcla', descripcion: 'Mezcla de algodón y poliéster' },
      { nombre: 'Color Natural', descripcion: 'Tejido sin teñir en color natural' },
      { nombre: 'Color Teñido', descripcion: 'Tejido teñido en colores sólidos' }
    ];
    for (const attr of weavingAttributes) {
      try {
        const [result] = await connection.execute(
          `INSERT INTO caracteristicas (nombre, descripcion, estado, created_at, updated_at) 
           VALUES (?, ?, ?, NOW(), NOW())`,
          [attr.nombre, attr.descripcion, 1]
        );
        caracteristicas.push(result.insertId);
      } catch (error) {
        console.warn(`⚠️ Error inserting caracteristica: ${error.message}`);
      }
    }
    console.log('✅ Inserted caracteristicas');

    // Insert categorias (updated for weaving-related categories)
    const categorias = [];
    const weavingCategories = [
      'Telas de Algodón',
      'Telas Sintéticas',
      'Telas Mixtas',
      'Telas para Uniformes',
      'Telas para Decoración'
    ];
    for (let i = 0; i < Math.min(5, caracteristicas.length); i++) {
      try {
        const [result] = await connection.execute(
          `INSERT INTO categorias (caracteristica_id, created_at, updated_at) VALUES (?, NOW(), NOW())`,
          [caracteristicas[i]]
        );
        categorias.push(result.insertId);
      } catch (error) {
        console.warn(`⚠️ Error inserting categoria for caracteristica_id ${caracteristicas[i]}: ${error.message}`);
      }
    }
    console.log('✅ Inserted categorias');

    // Insert marcas (updated for weaving-related brands)
    const marcas = [];
    const weavingBrands = [
      'Anahui Tejidos',
      'Textil Perú',
      'Fibras Andinas',
      'Tejidos del Valle',
      'EcoTejidos'
    ];
    for (let i = Math.min(5, caracteristicas.length); i < Math.min(10, caracteristicas.length); i++) {
      try {
        const [result] = await connection.execute(
          `INSERT INTO marcas (caracteristica_id, created_at, updated_at) VALUES (?, NOW(), NOW())`,
          [caracteristicas[i]]
        );
        marcas.push(result.insertId);
      } catch (error) {
        console.warn(`⚠️ Error inserting marca for caracteristica_id ${caracteristicas[i]}: ${error.message}`);
      }
    }
    console.log('✅ Inserted marcas');

    // Insert presentaciones (updated for weaving-specific presentations)
    const presentaciones = [];
    const weavingPresentations = [
      { sigla: 'ROL', descripcion: 'Rollo de tela (50m)' },
      { sigla: 'MTR', descripcion: 'Metro lineal' },
      { sigla: 'PAQ', descripcion: 'Paquete de 10m' },
      { sigla: 'UNID', descripcion: 'Unidad de tela pre-cortada' },
      { sigla: 'BOL', descripcion: 'Bolsa de retazos' }
    ];
    for (let i = Math.min(10, caracteristicas.length); i < caracteristicas.length; i++) {
      try {
        const presentation = weavingPresentations[(i - Math.min(10, caracteristicas.length)) % weavingPresentations.length];
        const [result] = await connection.execute(
          `INSERT INTO presentaciones (caracteristica_id, sigla, created_at, updated_at) 
           VALUES (?, ?, NOW(), NOW())`,
          [caracteristicas[i], presentation.sigla]
        );
        presentaciones.push(result.insertId);
      } catch (error) {
        console.warn(`⚠️ Error inserting presentacion for caracteristica_id ${caracteristicas[i]}: ${error.message}`);
      }
    }
    console.log('✅ Inserted presentaciones');

    // Insert productos (updated for woven textile products)
    const productos = [];
    const weavingProducts = [
      { nombre: 'Tela Algodón Plano', descripcion: 'Tela de algodón con tejido plano, ideal para camisas' },
      { nombre: 'Tela Sarga Poliéster', descripcion: 'Tela sintética con tejido sarga para uniformes' },
      { nombre: 'Tela Satén Mixta', descripcion: 'Tela suave con acabado satén para decoración' },
      { nombre: 'Tela Algodón Elástica', descripcion: 'Tela elástica para prendas ajustadas' },
      { nombre: 'Tela Mezcla Antimanchas', descripcion: 'Tela con tratamiento antimanchas para tapicería' },
      { nombre: 'Tela Algodón 60 hilos', descripcion: 'Tela de alta densidad para ropa de cama' },
      { nombre: 'Tela Poliéster Teñida', descripcion: 'Tela sintética teñida para cortinas' },
      { nombre: 'Tela Sarga Resistente', descripcion: 'Tela durable para ropa de trabajo' },
      { nombre: 'Tela Algodón Natural', descripcion: 'Tela sin teñir para proyectos ecológicos' },
      { nombre: 'Tela Mixta Decorativa', descripcion: 'Tela para decoración de interiores' }
    ];
    for (let i = 0; i < 100; i++) {
      try {
        const product = weavingProducts[i % weavingProducts.length];
        const [result] = await connection.execute(
          `INSERT INTO productos (codigo, nombre, descripcion, img_path, estado, precio, marca_id, presentacione_id, categoria_id, created_at, updated_at) 
           VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())`,
          [
            faker.string.alphanumeric({ length: 10 }),
            product.nombre,
            product.descripcion,
            faker.image.url(),
            1,
            faker.number.float({ min: 20, max: 150, precision: 0.01 }),
            marcas.length ? faker.helpers.arrayElement(marcas) : null,
            faker.helpers.arrayElement(presentaciones),
            categorias.length ? faker.helpers.arrayElement(categorias) : null
          ]
        );
        productos.push(result.insertId);
      } catch (error) {
        console.warn(`⚠️ Error inserting producto: ${error.message}`);
      }
    }
    console.log('✅ Inserted productos');

    // Insert ubicaciones (updated to reflect weaving storage areas)
    const ubicaciones = [];
    const [existingUbicaciones] = await connection.execute(`SELECT id FROM ubicaciones`);
    ubicaciones.push(...existingUbicaciones.map(row => row.id));
    const weavingLocations = [
      'Almacén de Telas Planas',
      'Almacén de Telas Elásticas',
      'Estante de Rollos',
      'Zona de Telas Teñidas',
      'Depósito de Retazos'
    ];
    for (let i = 0; i < 9; i++) {
      try {
        const [result] = await connection.execute(
          `INSERT INTO ubicaciones (nombre, created_at, updated_at) VALUES (?, NOW(), NOW())`,
          [weavingLocations[i]]
        );
        ubicaciones.push(result.insertId);
      } catch (error) {
        console.warn(`⚠️ Error inserting ubicacion: ${error.message}`);
      }
    }
    console.log('✅ Inserted/verified ubicaciones');

    // Insert inventario (updated for weaving products)
    for (const producto_id of productos) {
      try {
        await connection.execute(
          `INSERT INTO inventario (producto_id, ubicacione_id, cantidad, cantidad_minima, cantidad_maxima, fecha_vencimiento, created_at, updated_at) 
           VALUES (?, ?, ?, ?, ?, ?, NOW(), NOW())`,
          [
            producto_id,
            faker.helpers.arrayElement(ubicaciones),
            faker.number.int({ min: 50, max: 500 }), // Adjusted for meters of fabric
            faker.number.int({ min: 20, max: 50 }),
            faker.number.int({ min: 300, max: 1000 }),
            faker.date.future({ years: 2 }) // Textiles may not have expiration, but kept for consistency
          ]
        );
      } catch (error) {
        console.warn(`⚠️ Error inserting inventario for producto_id ${producto_id}: ${error.message}`);
      }
    }
    console.log('✅ Inserted inventario');

    // Insert comprobantes (unchanged, as document types are generic)
    const comprobantes = ['Factura', 'Boleta'];
    for (const nombre of comprobantes) {
      try {
        await connection.execute(
          `INSERT IGNORE INTO comprobantes (nombre, created_at, updated_at) VALUES (?, NOW(), NOW())`,
          [nombre]
        );
      } catch (error) {
        console.warn(`⚠️ Error inserting comprobante ${nombre}: ${error.message}`);
      }
    }
    console.log('✅ Inserted/verified comprobantes');

    // Insert empleados (updated to include weaving-related roles)
    // Insert empleados (updated to include weaving-related roles)
    const empleados = [];
    const weavingRoles = [
      'Tejedor Principal',
      'Operario de Telar',
      'Inspector de Calidad Textil',
      'Supervisor de Tejeduría',
      'Técnico de Mantenimiento de Telares'
    ];
    for (let i = 0; i < 9; i++) {
      try {
        const [result] = await connection.execute(
          `INSERT INTO empleados (razon_social, cargo, img_path, created_at, updated_at) 
           VALUES (?, ?, ?, NOW(), NOW())`,
          [
            faker.person.fullName(),
            weavingRoles[i],
            faker.image.url()
          ]
        );
        empleados.push(result.insertId);
      } catch (error) {
        console.warn(`⚠️ Error inserting empleado: ${error.message}`);
      }
    }
    console.log('✅ Inserted empleados');

    // Insert users (unchanged, as user data is generic)
    const users = [];
    for (const empleado_id of empleados) {
      try {
        const [result] = await connection.execute(
          `INSERT INTO users (name, email, password, empleado_id, estado, created_at, updated_at) 
           VALUES (?, ?, ?, ?, ?, NOW(), NOW())`,
          [
            faker.person.fullName(),
            faker.internet.email(),
            '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
            empleado_id,
            1
          ]
        );
        users.push(result.insertId);
      } catch (error) {
        console.warn(`⚠️ Error inserting user: ${error.message}`);
      }
    }
    console.log('✅ Inserted users');

    // Insert roles (unchanged, as roles are generic)
    const roles = [
      { name: 'administrador', guard_name: 'web' },
      { name: 'vendedor', guard_name: 'web' }
    ];
    const roleIds = [];
    for (const role of roles) {
      try {
        const [result] = await connection.execute(
          `INSERT IGNORE INTO roles (name, guard_name, created_at, updated_at) VALUES (?, ?, NOW(), NOW())`,
          [role.name, role.guard_name]
        );
        if (result.insertId) roleIds.push(result.insertId);
        else {
          const [existingRole] = await connection.execute(
            `SELECT id FROM roles WHERE name = ? AND guard_name = ?`,
            [role.name, role.guard_name]
          );
          if (existingRole.length) roleIds.push(existingRole[0].id);
        }
      } catch (error) {
        console.warn(`⚠️ Error inserting role ${role.name}: ${error.message}`);
      }
    }
    console.log('✅ Inserted/verified roles');

    // Insert permissions (updated to include weaving-related permissions)
    const permissions = [
      'gestionar_telas',
      'gestionar_ventas_textiles',
      'gestionar_compras_hilos',
      'ver_reportes_tejeduria'
    ];
    const permissionIds = [];
    for (const name of permissions) {
      try {
        const [result] = await connection.execute(
          `INSERT IGNORE INTO permissions (name, guard_name, created_at, updated_at) VALUES (?, ?, NOW(), NOW())`,
          [name, 'web']
        );
        if (result.insertId) permissionIds.push(result.insertId);
        else {
          const [existingPermission] = await connection.execute(
            `SELECT id FROM permissions WHERE name = ? AND guard_name = ?`,
            [name, 'web']
          );
          if (existingPermission.length) permissionIds.push(existingPermission[0].id);
        }
      } catch (error) {
        console.warn(`⚠️ Error inserting permission ${name}: ${error.message}`);
      }
    }
    console.log('✅ Inserted/verified permissions');

    // Insert role_has_permissions (unchanged)
    for (const roleId of roleIds) {
      for (const permissionId of permissionIds) {
        if (roleId === roleIds[0] || permissionId !== permissionIds[3]) {
          try {
            await connection.execute(
              `INSERT IGNORE INTO role_has_permissions (role_id, permission_id) VALUES (?, ?)`,
              [roleId, permissionId]
            );
          } catch (error) {
            console.warn(`⚠️ Error inserting role_has_permissions for role ${roleId} and permission ${permissionId}: ${error.message}`);
          }
        }
      }
    }
    console.log('✅ Inserted role_has_permissions');

    // Insert model_has_roles (unchanged)
    for (let i = 0; i < users.length; i++) {
      try {
        await connection.execute(
          `INSERT IGNORE INTO model_has_roles (role_id, model_type, model_id) VALUES (?, ?, ?)`,
          [i < 2 ? roleIds[0] : roleIds[1], 'App\\Models\\User', users[i]]
        );
      } catch (error) {
        console.warn(`⚠️ Error inserting model_has_roles for user ${users[i]}: ${error.message}`);
      }
    }
    console.log('✅ Inserted model_has_roles');

    // Insert cajas (unchanged, as cash registers are generic)
    const cajas = [];
    for (const user_id of users) {
      try {
        const [result] = await connection.execute(
          `INSERT INTO cajas (nombre, fecha_hora_apertura, saldo_inicial, estado, user_id, created_at, updated_at) 
           VALUES (?, ?, ?, ?, ?, NOW(), NOW())`,
          [
            `Caja ${faker.string.numeric(3)}`,
            faker.date.recent(),
            faker.number.float({ min: 100, max: 1000, precision: 0.01 }),
            1,
            user_id
          ]
        );
        cajas.push(result.insertId);
      } catch (error) {
        console.warn(`⚠️ Error inserting caja: ${error.message}`);
      }
    }
    console.log('✅ Inserted cajas');

    // Insert compras (updated for weaving-related purchases, e.g., yarns or raw materials)
    const compras = [];
    const [proveedoresRows] = await connection.execute(`SELECT id FROM proveedores`);
    const proveedores = proveedoresRows.map(row => row.id);
    for (let i = 0; i < 100; i++) {
      try {
        const subtotal = faker.number.float({ min: 200, max: 1000, precision: 0.01 });
        const impuesto = subtotal * 0.18;
        const total = subtotal + impuesto;
        const [result] = await connection.execute(
          `INSERT INTO compras (user_id, comprobante_id, proveedore_id, numero_comprobante, metodo_pago, fecha_hora, impuesto, subtotal, total, created_at, updated_at) 
           VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())`,
          [
            faker.helpers.arrayElement(users),
            faker.helpers.arrayElement([1, 2]),
            faker.helpers.arrayElement(proveedores),
            `COMP-${faker.string.numeric(8)}`,
            faker.helpers.arrayElement(['EFECTIVO', 'TARJETA']),
            faker.date.recent(),
            impuesto,
            subtotal,
            total
          ]
        );
        compras.push(result.insertId);
      } catch (error) {
        console.warn(`⚠️ Error inserting compra: ${error.message}`);
      }
    }
    console.log('✅ Inserted compras');

    // Insert compra_producto (updated for weaving products)
    for (const compra_id of compras) {
      for (let i = 0; i < 3; i++) {
        try {
          await connection.execute(
            `INSERT INTO compra_producto (compra_id, producto_id, cantidad, precio_compra, fecha_vencimiento, created_at, updated_at) 
             VALUES (?, ?, ?, ?, ?, NOW(), NOW())`,
            [
              compra_id,
              faker.helpers.arrayElement(productos),
              faker.number.int({ min: 10, max: 100 }), // Adjusted for meters or units
              faker.number.float({ min: 10, max: 80, precision: 0.01 }),
              faker.date.future({ years: 2 })
            ]
          );
        } catch (error) {
          console.warn(`⚠️ Error inserting compra_producto: ${error.message}`);
        }
      }
    }
    console.log('✅ Inserted compra_producto');

    // Insert ventas (unchanged, as sales process is generic)
    const ventas = [];
    for (let i = 0; i < 4; i++) {
      try {
        const subtotal = faker.number.float({ min: 100, max: 500, precision: 0.01 });
        const impuesto = subtotal * 0.18;
        const total = subtotal + impuesto;
        const monto_recibido = total + faker.number.float({ min: 0, max: 50, precision: 0.01 });
        const [result] = await connection.execute(
          `INSERT INTO ventas (cliente_id, user_id, caja_id, comprobante_id, numero_comprobante, metodo_pago, fecha_hora, subtotal, impuesto, total, monto_recibido, vuelto_entregado, created_at, updated_at) 
           VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW())`,
          [
            faker.helpers.arrayElement(clientes),
            faker.helpers.arrayElement(users),
            faker.helpers.arrayElement(cajas),
            faker.helpers.arrayElement([1, 2]),
            `VENTA-${faker.string.numeric(8)}`,
            faker.helpers.arrayElement(['EFECTIVO', 'TARJETA']),
            faker.date.recent(),
            subtotal,
            impuesto,
            total,
            monto_recibido,
            monto_recibido - total
          ]
        );
        ventas.push(result.insertId);
      } catch (error) {
        console.warn(`⚠️ Error inserting venta: ${error.message}`);
      }
    }
    console.log('✅ Inserted ventas');

    // Insert producto_venta (updated for weaving products)
    for (const venta_id of ventas) {
      for (let i = 0; i < 3; i++) {
        try {
          await connection.execute(
            `INSERT INTO producto_venta (venta_id, producto_id, cantidad, precio_venta, created_at, updated_at) 
             VALUES (?, ?, ?, ?, NOW(), NOW())`,
            [
              venta_id,
              faker.helpers.arrayElement(productos),
              faker.number.int({ min: 5, max: 50 }), // Adjusted for meters sold
              faker.number.float({ min: 20, max: 150, precision: 0.01 })
            ]
          );
        } catch (error) {
          console.warn(`⚠️ Error inserting producto_venta: ${error.message}`);
        }
      }
    }
    console.log('✅ Inserted producto_venta');

    // Insert kardex (updated for weaving transactions)
    for (const producto_id of productos) {
      const tiposTransaccion = ['COMPRA', 'VENTA', 'AJUSTE', 'APERTURA'];
      for (let i = 0; i < 3; i++) {
        try {
          const tipo = faker.helpers.arrayElement(tiposTransaccion);
          const entrada = tipo === 'COMPRA' || tipo === 'APERTURA' ? faker.number.int({ min: 10, max: 200 }) : null;
          const salida = tipo === 'VENTA' || tipo === 'AJUSTE' ? faker.number.int({ min: 5, max: 50 }) : null;
          const saldo = faker.number.int({ min: 0, max: 500 });
          await connection.execute(
            `INSERT INTO kardex (producto_id, tipo_transaccion, descripcion_transaccion, entrada, salida, saldo, costo_unitario, created_at, updated_at) 
             VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), NOW())`,
            [
              producto_id,
              tipo,
              `Movimiento de ${tipo.toLowerCase()} de tela`,
              entrada,
              salida,
              saldo,
              faker.number.float({ min: 10, max: 80, precision: 0.01 })
            ]
          );
        } catch (error) {
          console.warn(`⚠️ Error inserting kardex for producto_id ${producto_id}: ${error.message}`);
        }
      }
    }
    console.log('✅ Inserted kardex');

    // Insert movimientos (unchanged, as movements are generic)
    for (const caja_id of cajas) {
      for (let i = 0; i < 3; i++) {
        try {
          await connection.execute(
            `INSERT INTO movimientos (tipo, descripcion, monto, metodo_pago, caja_id, created_at, updated_at) 
             VALUES (?, ?, ?, ?, ?, NOW(), NOW())`,
            [
              faker.helpers.arrayElement(['VENTA', 'RETIRO']),
              `Transacción de ${faker.helpers.arrayElement(['venta de telas', 'retiro de efectivo'])}`,
              faker.number.float({ min: 50, max: 500, precision: 0.01 }),
              faker.helpers.arrayElement(['EFECTIVO', 'TARJETA']),
              caja_id
            ]
          );
        } catch (error) {
          console.warn(`⚠️ Error inserting movimiento: ${error.message}`);
        }
      }
    }
    console.log('✅ Inserted movimientos');

    // Insert activity_logs (updated for weaving-related actions)
    for (const user_id of users) {
      for (let i = 0; i < 2; i++) {
        try {
          await connection.execute(
            `INSERT INTO activity_logs (user_id, action, module, data, ip_address, created_at, updated_at) 
             VALUES (?, ?, ?, ?, ?, NOW(), NOW())`,
            [
              user_id,
              faker.helpers.arrayElement(['create', 'update', 'delete']),
              faker.helpers.arrayElement(['telas', 'ventas_textiles', 'compras_hilos']),
              JSON.stringify({ details: `Acción en ${faker.helpers.arrayElement(['tela', 'hilo', 'tejido'])}` }),
              faker.internet.ip()
            ]
          );
        } catch (error) {
          console.warn(`⚠️ Error inserting activity_log: ${error.message}`);
        }
      }
    }
    console.log('✅ Inserted activity_logs');

    await connection.commit();
    console.log('✅ Transaction committed successfully');
    console.log('✅ Database populated successfully');
  } catch (error) {
    await connection.rollback();
    console.error('❌ Error populating database:', error);
  } finally {
    await connection.end();
    console.log('✅ Database connection closed');
  }
}

populateDatabase().catch(console.error);