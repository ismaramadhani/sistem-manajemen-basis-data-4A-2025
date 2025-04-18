/*
SQLyog Ultimate v12.4.3 (64 bit)
MySQL - 10.4.32-MariaDB : Database - db_bakery
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_bakery` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `db_bakery`;

/*Table structure for table `bahan_baku` */

DROP TABLE IF EXISTS `bahan_baku`;

CREATE TABLE `bahan_baku` (
  `id_bahan_baku` int(11) NOT NULL,
  `nama_bahan` varchar(100) NOT NULL,
  `satuan` varchar(45) NOT NULL,
  `stok` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_bahan_baku`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `bahan_baku` */

/*Table structure for table `detail_penjualan` */

DROP TABLE IF EXISTS `detail_penjualan`;

CREATE TABLE `detail_penjualan` (
  `id_detail_penjualan` int(11) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `id_penjualan` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `subtotal` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_detail_penjualan`),
  KEY `fk_produk_has_penjualan_produk` (`id_produk`),
  KEY `fk_produk_has_penjualan_penjualan1` (`id_penjualan`),
  CONSTRAINT `fk_produk_has_penjualan_penjualan1` FOREIGN KEY (`id_penjualan`) REFERENCES `penjualan` (`id_penjualan`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_produk_has_penjualan_produk` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `detail_penjualan` */

/*Table structure for table `pelanggan` */

DROP TABLE IF EXISTS `pelanggan`;

CREATE TABLE `pelanggan` (
  `id_pelanggan` int(11) NOT NULL AUTO_INCREMENT,
  `nama_pelanggan` varchar(100) NOT NULL,
  `no_hp` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id_pelanggan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pelanggan` */

/*Table structure for table `pembayaran` */

DROP TABLE IF EXISTS `pembayaran`;

CREATE TABLE `pembayaran` (
  `id_pembayaran` int(11) NOT NULL,
  `id_penjualan` int(11) NOT NULL,
  `tanggal_bayar` datetime DEFAULT NULL,
  `metode_pembayaran` enum('Cash','Virtual Account','Transfer Bank') NOT NULL,
  `jumlah_bayar` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_pembayaran`),
  KEY `fk_pembayaran_penjualan1` (`id_penjualan`),
  CONSTRAINT `fk_pembayaran_penjualan1` FOREIGN KEY (`id_penjualan`) REFERENCES `penjualan` (`id_penjualan`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pembayaran` */

/*Table structure for table `penjualan` */

DROP TABLE IF EXISTS `penjualan`;

CREATE TABLE `penjualan` (
  `id_penjualan` int(11) NOT NULL AUTO_INCREMENT,
  `id_pelanggan` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_penjualan`),
  KEY `fk_penjualan_pelanggan1` (`id_pelanggan`),
  CONSTRAINT `fk_penjualan_pelanggan1` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id_pelanggan`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `penjualan` */

/*Table structure for table `produk` */

DROP TABLE IF EXISTS `produk`;

CREATE TABLE `produk` (
  `id_produk` int(11) NOT NULL AUTO_INCREMENT,
  `nama_produk` varchar(100) NOT NULL,
  `harga` decimal(10,2) NOT NULL,
  `stok` int(11) NOT NULL,
  PRIMARY KEY (`id_produk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `produk` */

/*Table structure for table `resep_produk` */

DROP TABLE IF EXISTS `resep_produk`;

CREATE TABLE `resep_produk` (
  `id_resep` int(11) NOT NULL,
  `id_produk` int(11) NOT NULL,
  `id_bahan_baku` int(11) NOT NULL,
  `nama_resep` varchar(45) NOT NULL,
  `jumlah_bahan` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_resep`),
  KEY `fk_produk_has_bahan_baku_produk1` (`id_produk`),
  KEY `fk_produk_has_bahan_baku_bahan_baku1` (`id_bahan_baku`),
  CONSTRAINT `fk_produk_has_bahan_baku_bahan_baku1` FOREIGN KEY (`id_bahan_baku`) REFERENCES `bahan_baku` (`id_bahan_baku`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_produk_has_bahan_baku_produk1` FOREIGN KEY (`id_produk`) REFERENCES `produk` (`id_produk`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `resep_produk` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
