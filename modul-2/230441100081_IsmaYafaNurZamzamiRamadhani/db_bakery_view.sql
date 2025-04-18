CREATE TABLE `produk` (
  `id_produk` INT NOT NULL AUTO_INCREMENT,
  `nama_produk` VARCHAR(100) NOT NULL,
  `harga` DECIMAL(10,2) NOT NULL,
  `stok` INT NOT NULL,
  PRIMARY KEY (`id_produk`));

CREATE TABLE `pelanggan` (
  `id_pelanggan` INT NOT NULL AUTO_INCREMENT,
  `nama_pelanggan` VARCHAR(100) NOT NULL,
  `no_hp` VARCHAR(15) NULL,
  PRIMARY KEY (`id_pelanggan`));

CREATE TABLE `penjualan` (
  `id_penjualan` INT NOT NULL AUTO_INCREMENT,
  `id_pelanggan` INT NOT NULL,
  `tanggal` DATE NOT NULL,
  `total` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_penjualan`),
  CONSTRAINT `fk_penjualan_pelanggan1`
    FOREIGN KEY (`id_pelanggan`)
    REFERENCES `pelanggan` (`id_pelanggan`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `pembayaran` (
  `id_pembayaran` INT NOT NULL,
  `id_penjualan` INT NOT NULL,
  `tanggal_bayar` DATETIME NULL,
  `metode_pembayaran` ENUM('Cash', 'Virtual Account', 'Transfer Bank') NOT NULL,
  `jumlah_bayar` DECIMAL(10,2) NULL,
  PRIMARY KEY (`id_pembayaran`),
  CONSTRAINT `fk_pembayaran_penjualan1`
    FOREIGN KEY (`id_penjualan`)
    REFERENCES `penjualan` (`id_penjualan`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `detail_penjualan` (
  `id_detail_penjualan` INT NOT NULL,
  `id_produk` INT NOT NULL,
  `id_penjualan` INT NOT NULL,
  `jumlah` INT NOT NULL,
  `subtotal` INT NULL,
  PRIMARY KEY (`id_detail_penjualan`),
  CONSTRAINT `fk_produk_has_penjualan_produk`
    FOREIGN KEY (`id_produk`)
    REFERENCES `produk` (`id_produk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produk_has_penjualan_penjualan1`
    FOREIGN KEY (`id_penjualan`)
    REFERENCES `penjualan` (`id_penjualan`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `bahan_baku` (
  `id_bahan_baku` INT NOT NULL,
  `nama_bahan` VARCHAR(100) NOT NULL,
  `satuan` VARCHAR(45) NOT NULL,
  `stok` INT NULL,
  PRIMARY KEY (`id_bahan_baku`));

CREATE TABLE `resep_produk` (
  `id_resep` INT NOT NULL,
  `id_produk` INT NOT NULL,
  `id_bahan_baku` INT NOT NULL,
  `nama_resep` VARCHAR(45) NOT NULL,
  `jumlah_bahan` DECIMAL(10,2) NULL,
  PRIMARY KEY (`id_resep`),
  CONSTRAINT `fk_produk_has_bahan_baku_produk1`
    FOREIGN KEY (`id_produk`)
    REFERENCES `produk` (`id_produk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_produk_has_bahan_baku_bahan_baku1`
    FOREIGN KEY (`id_bahan_baku`)
    REFERENCES `bahan_baku` (`id_bahan_baku`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
INSERT INTO produk (id_produk, nama_produk, harga, stok) VALUES
(1, 'Roti Tawar', 15000.00, 100),
(2, 'Donat Coklat', 12000.00, 80),
(3, 'Croissant', 18000.00, 60);

INSERT INTO bahan_baku (id_bahan_baku, nama_bahan, satuan, stok) VALUES
(1, 'Tepung Terigu', 'gram', 10000),
(2, 'Gula Pasir', 'gram', 5000),
(3, 'Coklat Bubuk', 'gram', 2000),
(4, 'Ragi', 'gram', 500),
(5, 'Mentega', 'gram', 3000);

INSERT INTO resep_produk (id_resep, id_produk, id_bahan_baku, nama_resep, jumlah_bahan) VALUES
(1, 1, 1, 'Roti Tawar Basic', 300),
(2, 1, 2, 'Roti Tawar Basic', 50),
(3, 1, 4, 'Roti Tawar Basic', 10),
(4, 2, 1, 'Donat Coklat', 250),
(5, 2, 3, 'Donat Coklat', 70),
(6, 3, 1, 'Croissant Recipe', 200),
(7, 3, 5, 'Croissant Recipe', 100);

INSERT INTO pelanggan (id_pelanggan, nama_pelanggan, no_hp) VALUES
(1, 'Andi Wijaya', '081234567890'),
(2, 'Siti Rahma', '082345678901');

INSERT INTO penjualan (id_penjualan, id_pelanggan, tanggal, total) VALUES
(1, 1, '2025-04-15', 39000.00),
(2, 2, '2025-04-16', 36000.00);

INSERT INTO detail_penjualan (id_detail_penjualan, id_penjualan, id_produk, jumlah) VALUES
(1, 1, 1, 1),  
(2, 1, 2, 2),  
(3, 2, 3, 2);  
INSERT INTO pembayaran (id_pembayaran, id_penjualan, metode_pembayaran, jumlah_bayar, tanggal_bayar) VALUES
(1, 1, 'Tunai', 39000.00, '2025-04-15'),
(2, 2, 'Transfer Bank', 36000.00, '2025-04-16');

CREATE VIEW view_resep_produk AS
SELECT 
    a.nama_resep,
    b.nama_bahan,
    a.jumlah_bahan,
    b.satuan
FROM resep_produk a
JOIN bahan_baku b ON a.id_bahan_baku = b.id_bahan_baku;

SELECT * FROM view_resep_produk;

CREATE VIEW view_pembayaran_pelanggan AS
SELECT 
    a.nama_pelanggan,
    b.metode_pembayaran,
    b.jumlah_bayar,
    b.tanggal_bayar
FROM pembayaran b
JOIN penjualan c ON c.id_penjualan = b.id_penjualan
JOIN pelanggan a ON c.id_pelanggan = a.id_pelanggan;

SELECT * FROM view_pembayaran_pelanggan;

CREATE VIEW view_penjualan_di_atas_20rb AS
SELECT 
    a.id_penjualan,
    a.tanggal,
    b.nama_pelanggan,
    a.total
FROM penjualan a
JOIN pelanggan b ON a.id_pelanggan = b.id_pelanggan
WHERE a.total > 20000;

SELECT * FROM view_penjualan_di_atas_20rb;

CREATE VIEW view_total_bahan_per_resep AS
SELECT 
    a.nama_resep,
    SUM(b.jumlah_bahan) AS total_bahan_diperlukan
FROM resep_produk b
JOIN resep_produk a ON b.id_produk = a.id_produk
GROUP BY a.nama_resep;

SELECT * FROM view_total_bahan_per_resep;

CREATE VIEW view_produk_terlaris AS
SELECT 
    a.nama_produk,
    SUM(b.jumlah) AS total_terjual
FROM detail_penjualan b
JOIN produk a ON b.id_produk = a.id_produk
GROUP BY a.nama_produk
ORDER BY total_terjual DESC;

SELECT * FROM view_produk_terlaris;


