-- drop database abarrotes_zorro;
CREATE DATABASE IF NOT EXISTS abarrotes_zorro;
USE abarrotes_zorro;

-- Tabla de roles
CREATE TABLE rol (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

-- Tabla de usuarios
CREATE TABLE empleado (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(20),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    id_rol INT,
    FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);


CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    numero_cliente VARCHAR(6) UNIQUE NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    direccion TEXT,
    rfc VARCHAR(20),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de proveedores
CREATE TABLE proveedor (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre_empresa VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefono VARCHAR(20),
    direccion TEXT,
    dias_entrega INT,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de categorías
CREATE TABLE categoria_producto (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT,
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de productos
CREATE TABLE producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_categoria INT,
    id_proveedor INT,
    descripcion TEXT,
    precio_compra DECIMAL(10,2) NOT NULL,
    precio_venta DECIMAL(10,2) NOT NULL,
    stock_minimo DECIMAL(10,3) DEFAULT 5,
    stock_actual DECIMAL(10,3) DEFAULT 0,
    unidad_medida ENUM('PIEZA', 'KILO', 'LITRO', 'PAQUETE', 'CAJA') DEFAULT 'PIEZA',
    imagen_url VARCHAR(255),
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_categoria) REFERENCES categoria_producto(id_categoria),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor)
);

-- Tabla de ventas
CREATE TABLE venta (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    folio VARCHAR(20) UNIQUE,
    fecha_venta DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_cliente INT,
    id_vendedor INT NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    total DECIMAL(12,2) NOT NULL,
    metodo_pago ENUM('EFECTIVO') NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON DELETE SET NULL,
    FOREIGN KEY (id_vendedor) REFERENCES empleado(id_empleado)
);

-- Detalle de ventas
CREATE TABLE detalle_venta (
    id_detalle BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT,
    nombre_producto VARCHAR(100),
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(12,2) NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES venta(id_venta) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE SET NULL
);

-- Tabla de cierre de ventas diarias
CREATE TABLE cierre_venta (
    id_cierre INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE UNIQUE NOT NULL,
    total_ventas DECIMAL(12,2) NOT NULL,
    total_productos_vendidos DECIMAL(12,3) NOT NULL,
    generado_por INT NOT NULL,
    fecha_generado DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (generado_por) REFERENCES empleado(id_empleado)
);

-- Tabla de inventario
CREATE TABLE inventario (
    id_inventario INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    stock_inicial DECIMAL(10,3) DEFAULT 0,
    stock_actual DECIMAL(10,3) DEFAULT 0,
    punto_reorden DECIMAL(10,3) DEFAULT 0,
    fecha_ultima_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto) ON DELETE CASCADE
);

-- Historial de movimientos de inventario
CREATE TABLE movimiento_inventario (
    id_movimiento BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    tipo ENUM('ENTRADA', 'SALIDA') NOT NULL,
    cantidad DECIMAL(10,3) NOT NULL,
    motivo VARCHAR(100),
    fecha_movimiento DATETIME DEFAULT CURRENT_TIMESTAMP,
    realizado_por INT,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
    FOREIGN KEY (realizado_por) REFERENCES empleado(id_empleado)
);

-- Pedidos a proveedores
CREATE TABLE pedido_proveedor (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT,
    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_esperada_entrega DATE,
    estado ENUM('PENDIENTE', 'EN_TRANSITO','COMPLETADO', 'CANCELADO') DEFAULT 'PENDIENTE',
    subtotal DECIMAL(12,2) NOT NULL DEFAULT 0,
    total DECIMAL(12,2) NOT NULL DEFAULT 0,
    notas TEXT,
    solicitado_por INT NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
    FOREIGN KEY (solicitado_por) REFERENCES empleado(id_empleado)
);

-- Detalle del pedido a proveedores
CREATE TABLE detalle_pedido_proveedor (
    id_detalle BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_solicitada DECIMAL(10,3) NOT NULL,
    precio_unitario DECIMAL(12,2) NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedido_proveedor(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);
