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

insert  into `bahan_baku`(`id_bahan_baku`,`nama_bahan`,`satuan`,`stok`) values 
(1,'Tepung Terigu','gram',10000),
(2,'Gula Pasir','gram',5000),
(3,'Coklat Bubuk','gram',2000),
(4,'Ragi','gram',500),
(5,'Mentega','gram',3000);

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

insert  into `detail_penjualan`(`id_detail_penjualan`,`id_produk`,`id_penjualan`,`jumlah`,`subtotal`) values 
(1,1,1,1,39000),
(2,2,1,2,36000),
(3,3,2,2,NULL);

/*Table structure for table `pelanggan` */

DROP TABLE IF EXISTS `pelanggan`;

CREATE TABLE `pelanggan` (
  `id_pelanggan` int(11) NOT NULL AUTO_INCREMENT,
  `nama_pelanggan` varchar(100) NOT NULL,
  `no_hp` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id_pelanggan`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pelanggan` */

insert  into `pelanggan`(`id_pelanggan`,`nama_pelanggan`,`no_hp`) values 
(1,'Andi Wijaya','081234567890'),
(2,'budi sutiono','082345678901');

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

insert  into `pembayaran`(`id_pembayaran`,`id_penjualan`,`tanggal_bayar`,`metode_pembayaran`,`jumlah_bayar`) values 
(1,1,'2025-04-15 00:00:00','Cash',39000.00),
(2,2,'2025-04-16 00:00:00','Transfer Bank',36000.00);

/*Table structure for table `penjualan` */

DROP TABLE IF EXISTS `penjualan`;

CREATE TABLE `penjualan` (
  `id_penjualan` int(11) NOT NULL AUTO_INCREMENT,
  `id_pelanggan` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `keterangan` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_penjualan`),
  KEY `fk_penjualan_pelanggan1` (`id_pelanggan`),
  CONSTRAINT `fk_penjualan_pelanggan1` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id_pelanggan`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `penjualan` */

insert  into `penjualan`(`id_penjualan`,`id_pelanggan`,`tanggal`,`total`,`keterangan`) values 
(1,1,'2025-04-15',39000.00,NULL),
(2,2,'2025-04-16',36000.00,NULL);

/*Table structure for table `produk` */

DROP TABLE IF EXISTS `produk`;

CREATE TABLE `produk` (
  `id_produk` int(11) NOT NULL AUTO_INCREMENT,
  `nama_produk` varchar(100) NOT NULL,
  `harga` decimal(10,2) NOT NULL,
  `stok` int(11) NOT NULL,
  PRIMARY KEY (`id_produk`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `produk` */

insert  into `produk`(`id_produk`,`nama_produk`,`harga`,`stok`) values 
(1,'Roti Tawar',18000.00,50),
(2,'Donat Coklat',12000.00,80),
(3,'Croissant',18000.00,60);

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

insert  into `resep_produk`(`id_resep`,`id_produk`,`id_bahan_baku`,`nama_resep`,`jumlah_bahan`) values 
(1,1,1,'Roti Tawar Basic',300.00),
(2,1,2,'Roti Tawar Basic',50.00),
(3,1,4,'Roti Tawar Basic',10.00),
(4,2,1,'Donat Coklat',250.00),
(5,2,3,'Donat Coklat',70.00),
(6,3,1,'Croissant Recipe',200.00),
(7,3,5,'Croissant Recipe',100.00);

/* Procedure structure for procedure `CountTransaksi` */

/*!50003 DROP PROCEDURE IF EXISTS  `CountTransaksi` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `CountTransaksi`(
	out total_jumlah int
)
begin 
	select count(*) into total_jumlah from detail_penjualan;
end */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteEntriesByIDMaster` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteEntriesByIDMaster` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteEntriesByIDMaster`(
	in id_hapus int
)
begin 
	delete from produk where id_produk = id_hapus;
end */$$
DELIMITER ;

/* Procedure structure for procedure `GetDataMasterByID` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetDataMasterByID` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDataMasterByID`(
	in id_baru int,
	out data_out varchar (200)
)
begin 
	select * from bahan_baku where id_bahan_baku = id_baru;
end */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateDataMaster` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateDataMaster` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateDataMaster`(
	in id_baru int,
	in nama_baru varchar(100),
	out status_operasi varchar(50)
)
begin 
	update pelanggan
	set nama_pelanggan = nama_baru
	where id_pelanggan = id_baru;
	
	set status_operasi = "sudah dijalankan";
end */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateFieldTransaksi` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateFieldTransaksi` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateFieldTransaksi`(
	IN a_id_produk INT,
	INOUT field1 DECIMAL(10,2),
	INOUT field2 INT
)
BEGIN
	UPDATE produk
	SET 
		harga = IF(field1 IS NULL, harga, field1),
		stok = IF(field2 IS NULL, stok, field2)
	WHERE id_produk = a_id_produk;
END */$$
DELIMITER ;

/*Table structure for table `view_pembayaran_pelanggan` */

DROP TABLE IF EXISTS `view_pembayaran_pelanggan`;

/*!50001 DROP VIEW IF EXISTS `view_pembayaran_pelanggan` */;
/*!50001 DROP TABLE IF EXISTS `view_pembayaran_pelanggan` */;

/*!50001 CREATE TABLE  `view_pembayaran_pelanggan`(
 `nama_pelanggan` varchar(100) ,
 `metode_pembayaran` enum('Cash','Virtual Account','Transfer Bank') ,
 `jumlah_bayar` decimal(10,2) ,
 `tanggal_bayar` datetime 
)*/;

/*Table structure for table `view_penjualan_di_atas_20rb` */

DROP TABLE IF EXISTS `view_penjualan_di_atas_20rb`;

/*!50001 DROP VIEW IF EXISTS `view_penjualan_di_atas_20rb` */;
/*!50001 DROP TABLE IF EXISTS `view_penjualan_di_atas_20rb` */;

/*!50001 CREATE TABLE  `view_penjualan_di_atas_20rb`(
 `id_penjualan` int(11) ,
 `tanggal` date ,
 `nama_pelanggan` varchar(100) ,
 `total` decimal(10,2) 
)*/;

/*Table structure for table `view_produk_terlaris` */

DROP TABLE IF EXISTS `view_produk_terlaris`;

/*!50001 DROP VIEW IF EXISTS `view_produk_terlaris` */;
/*!50001 DROP TABLE IF EXISTS `view_produk_terlaris` */;

/*!50001 CREATE TABLE  `view_produk_terlaris`(
 `nama_produk` varchar(100) ,
 `total_terjual` decimal(32,0) 
)*/;

/*Table structure for table `view_resep_produk` */

DROP TABLE IF EXISTS `view_resep_produk`;

/*!50001 DROP VIEW IF EXISTS `view_resep_produk` */;
/*!50001 DROP TABLE IF EXISTS `view_resep_produk` */;

/*!50001 CREATE TABLE  `view_resep_produk`(
 `nama_resep` varchar(45) ,
 `nama_bahan` varchar(100) ,
 `jumlah_bahan` decimal(10,2) ,
 `satuan` varchar(45) 
)*/;

/*Table structure for table `view_total_bahan_per_resep` */

DROP TABLE IF EXISTS `view_total_bahan_per_resep`;

/*!50001 DROP VIEW IF EXISTS `view_total_bahan_per_resep` */;
/*!50001 DROP TABLE IF EXISTS `view_total_bahan_per_resep` */;

/*!50001 CREATE TABLE  `view_total_bahan_per_resep`(
 `nama_resep` varchar(45) ,
 `total_bahan_diperlukan` decimal(32,2) 
)*/;

/*View structure for view view_pembayaran_pelanggan */

/*!50001 DROP TABLE IF EXISTS `view_pembayaran_pelanggan` */;
/*!50001 DROP VIEW IF EXISTS `view_pembayaran_pelanggan` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_pembayaran_pelanggan` AS select `a`.`nama_pelanggan` AS `nama_pelanggan`,`b`.`metode_pembayaran` AS `metode_pembayaran`,`b`.`jumlah_bayar` AS `jumlah_bayar`,`b`.`tanggal_bayar` AS `tanggal_bayar` from ((`pembayaran` `b` join `penjualan` `c` on(`c`.`id_penjualan` = `b`.`id_penjualan`)) join `pelanggan` `a` on(`c`.`id_pelanggan` = `a`.`id_pelanggan`)) */;

/*View structure for view view_penjualan_di_atas_20rb */

/*!50001 DROP TABLE IF EXISTS `view_penjualan_di_atas_20rb` */;
/*!50001 DROP VIEW IF EXISTS `view_penjualan_di_atas_20rb` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_penjualan_di_atas_20rb` AS select `a`.`id_penjualan` AS `id_penjualan`,`a`.`tanggal` AS `tanggal`,`b`.`nama_pelanggan` AS `nama_pelanggan`,`a`.`total` AS `total` from (`penjualan` `a` join `pelanggan` `b` on(`a`.`id_pelanggan` = `b`.`id_pelanggan`)) where `a`.`total` > 20000 */;

/*View structure for view view_produk_terlaris */

/*!50001 DROP TABLE IF EXISTS `view_produk_terlaris` */;
/*!50001 DROP VIEW IF EXISTS `view_produk_terlaris` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_produk_terlaris` AS select `a`.`nama_produk` AS `nama_produk`,sum(`b`.`jumlah`) AS `total_terjual` from (`detail_penjualan` `b` join `produk` `a` on(`b`.`id_produk` = `a`.`id_produk`)) group by `a`.`nama_produk` order by sum(`b`.`jumlah`) desc */;

/*View structure for view view_resep_produk */

/*!50001 DROP TABLE IF EXISTS `view_resep_produk` */;
/*!50001 DROP VIEW IF EXISTS `view_resep_produk` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_resep_produk` AS select `a`.`nama_resep` AS `nama_resep`,`b`.`nama_bahan` AS `nama_bahan`,`a`.`jumlah_bahan` AS `jumlah_bahan`,`b`.`satuan` AS `satuan` from (`resep_produk` `a` join `bahan_baku` `b` on(`a`.`id_bahan_baku` = `b`.`id_bahan_baku`)) */;

/*View structure for view view_total_bahan_per_resep */

/*!50001 DROP TABLE IF EXISTS `view_total_bahan_per_resep` */;
/*!50001 DROP VIEW IF EXISTS `view_total_bahan_per_resep` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_total_bahan_per_resep` AS select `a`.`nama_resep` AS `nama_resep`,sum(`b`.`jumlah_bahan`) AS `total_bahan_diperlukan` from (`resep_produk` `b` join `resep_produk` `a` on(`b`.`id_produk` = `a`.`id_produk`)) group by `a`.`nama_resep` */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
