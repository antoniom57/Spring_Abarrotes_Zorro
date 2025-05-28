USE abarrotes_zorro;


-- Tabla rol
INSERT INTO rol (nombre) VALUES ('ADMIN'), ('CAJERO'), ('ALMACENISTA');


-- Tabla empleado
-- contrasenias password123, cajero123, almacen456
INSERT INTO empleado (email, contrasena, nombre, apellido, telefono, id_rol, activo) VALUES 
('admin@zorro.com', '$2a$10$D8pwv4mvp93x6qNYFhWKSu3E7TPkiDCU0EBS1pHmhEvEhJSAZ9Ji.', 'Juan', 'Pérez López', '5551234567', 1, TRUE),
('cajero1@zorro.com', '$2a$10$qQe13Upxg9FMtVDWKGLk1O6AEMI5I99gbpWthZaItU0IPUkfuEJ.u', 'María', 'García Hernández', '5557654321', 2, TRUE),
('almacen@zorro.com', '$2a$10$0undOZFbclwkWzUWUR6xIOTskjBdJhLFlqLHxS6SI6zh4K8haD8AS', 'Carlos', 'Martínez Jiménez', '5559876543', 3, TRUE);


-- Tabla cliente
INSERT INTO cliente (numero_cliente, nombre, apellido, email, telefono, direccion, rfc) VALUES 
('CLI001', 'Ana', 'Rodríguez Sánchez', 'ana.rodriguez@email.com', '5551112233', 'Calle Primavera 123, Col. Centro', 'ROSA800101ABC'),
('CLI002', 'Luis', 'González Méndez', 'luis.gonzalez@email.com', '5554445566', 'Av. Reforma 456, Col. Juárez', 'GOML750202DEF'),
('CLI003', 'Sofía' ,'Ramírez Torres', 'sofia.ramirez@email.com', '5557778899', 'Calle Luna 789, Col. Del Valle', 'RATS820303GHI');

-- Tabla proveedor
INSERT INTO proveedor (nombre_empresa, email, telefono, direccion, dias_entrega) VALUES 
('Distribuidora Alimenticia SA', 'ventas@dalimenticia.com', '5550001122', 'Carretera México-Toluca Km 12.5', 3),
('Bebidas Refrescantes México', 'contacto@bebimex.com', '5553334455', 'Av. Industrias 789, Parque Industrial', 2),
('Productos Lácteos del Valle', 'pedidos@lacteosvalle.com', '5556667788', 'Km 8.5 Carretera a Cuernavaca', 5);

-- Tabla categoria_producto
INSERT INTO categoria_producto (nombre, descripcion) VALUES 
('Abarrotes', 'Productos básicos de despensa'),
('Bebidas', 'Refrescos, aguas y jugos'),
('Lácteos', 'Leche, queso, crema y derivados');

-- Tabla producto
INSERT INTO producto (nombre, id_categoria, id_proveedor, descripcion, precio_compra, precio_venta, stock_actual, unidad_medida) VALUES 
('Arroz 1kg', 1, 1, 'Arroz blanco grano largo', 15.50, 22.00, 50, 'PIEZA'),
('Refresco Cola 600ml', 2, 2, 'Refresco de cola en botella', 8.00, 15.00, 120, 'PIEZA'),
('Leche Entera 1L', 3, 3, 'Leche entera pasteurizada', 12.00, 18.50, 80, 'LITRO');

-- Tabla venta
INSERT INTO venta (folio, id_cliente, id_vendedor, subtotal, total, metodo_pago) VALUES 
('VTA2023001', 1, 2, 150.50, 175.00, 'EFECTIVO'),
('VTA2023002', NULL, 2, 85.00, 85.00, 'EFECTIVO'),
('VTA2023003', 2, 2, 220.75, 255.00, 'EFECTIVO');

-- Tabla detalle_venta
INSERT INTO detalle_venta (id_venta, id_producto, nombre_producto, cantidad, precio_unitario, subtotal) VALUES 
(1, 1, 'Arroz 1kg', 2, 22.00, 44.00),
(1, 2, 'Refresco Cola 600ml', 3, 15.5, 45.00),
(2, 3, 'Leche Entera 1L', 4, 18.75, 74.00);

-- Tabla cierre_venta
INSERT INTO cierre_venta (fecha, total_ventas, total_productos_vendidos, generado_por) VALUES 
('2023-05-01', 12500.50, 850, 1),
('2023-05-02', 9800.75, 720, 1),
('2023-05-03', 15320.25, 1100, 1);

-- Tabla inventario
INSERT INTO inventario (id_producto, stock_inicial, stock_actual, punto_reorden) VALUES 
(1, 100, 50, 20),
(2, 200, 120, 50),
(3, 150, 80, 30);

-- Tabla movimiento_inventario
INSERT INTO movimiento_inventario (id_producto, tipo, cantidad, motivo, realizado_por) VALUES 
(1, 'SALIDA', 5, 'Venta al público', 2),
(2, 'ENTRADA', 50, 'Compra a proveedor', 3),
(3, 'SALIDA', 10, 'Venta al mayoreo', 2);

-- Tabla pedido_proveedor
INSERT INTO pedido_proveedor (id_proveedor, fecha_esperada_entrega, estado, subtotal, total, solicitado_por) VALUES 
(1, '2023-05-10', 'PENDIENTE', 2500.00, 2900.00, 3),
(2, '2023-05-08', 'COMPLETADO', 1800.00, 2070.00, 3),
(3, '2023-05-12', 'EN_TRANSITO', 3200.00, 3680.00, 3);

-- Tabla detalle_pedido_proveedor
INSERT INTO detalle_pedido_proveedor (id_pedido, id_producto, cantidad_solicitada, precio_unitario, subtotal) VALUES 
(1, 1, 100, 15.50, 1550.00),
(2, 2, 150, 8.00, 1200.00),
(3, 3, 200, 12.00, 2400.00);
