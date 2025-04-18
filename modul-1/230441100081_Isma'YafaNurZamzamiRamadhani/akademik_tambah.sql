/*
SQLyog Ultimate v12.4.3 (64 bit)
MySQL - 10.4.32-MariaDB : Database - akademik
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`akademik` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `akademik`;

/*Table structure for table `dosen` */

DROP TABLE IF EXISTS `dosen`;

CREATE TABLE `dosen` (
  `nip` char(18) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `prodi` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`nip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `dosen` */

insert  into `dosen`(`nip`,`nama`,`prodi`) values 
('197509092002121001','Dr. Budi Dwi Satoto, S.T., M.Kom','Sistem Informasi'),
('197709212008122002','Dr. Yeni Kustiyahningsih, S.Kom., M.Kom','Sistem Informasi'),
('197805042002121002','Firmansyah Adiputra, S.T., M.Cs.','Sistem Informasi'),
('197808042003121001','Wahyudi Agustiono, S.Kom., M.Sc., Ph.D','Sistem Informasi'),
('197906052003122003','Eza Rahmanita, S.T., M.T.','Sistem Informasi'),
('198003212008011008','Mohammad Syarief, S.T., M.Cs.','Sistem Informasi'),
('198306082008012005','Rosida Vivin Nahari, S.Kom., M.T','Sistem Informasi'),
('198308282008122002','Sri Herawati, S.Kom., M.Kom','Sistem Informasi'),
('198705202019031013','Doni Abdul Fatah, S.Kom., M.Kom','Sistem Informasi'),
('198711272014042001','Novi Prastiti, S.Kom, M.Kom','Sistem Informasi');

/*Table structure for table `jadwal` */

DROP TABLE IF EXISTS `jadwal`;

CREATE TABLE `jadwal` (
  `id_jadwal` int(11) NOT NULL AUTO_INCREMENT,
  `kode_mk` char(5) DEFAULT NULL,
  `nip` char(18) DEFAULT NULL,
  `kode_ruang` char(5) DEFAULT NULL,
  `hari` varchar(10) DEFAULT NULL,
  `jam_mulai` time DEFAULT NULL,
  `jam_selesai` time DEFAULT NULL,
  PRIMARY KEY (`id_jadwal`),
  KEY `kode_mk` (`kode_mk`),
  KEY `nip` (`nip`),
  KEY `kode_ruang` (`kode_ruang`),
  CONSTRAINT `jadwal_ibfk_1` FOREIGN KEY (`kode_mk`) REFERENCES `matakuliah` (`kode_mk`),
  CONSTRAINT `jadwal_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `dosen` (`nip`),
  CONSTRAINT `jadwal_ibfk_3` FOREIGN KEY (`kode_ruang`) REFERENCES `ruang` (`kode_ruang`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `jadwal` */

insert  into `jadwal`(`id_jadwal`,`kode_mk`,`nip`,`kode_ruang`,`hari`,`jam_mulai`,`jam_selesai`) values 
(1,'SI443','197709212008122002','308','Senin','09:15:00','11:45:00'),
(2,'SI444','198003212008011008','204','Selasa','12:45:00','15:15:00'),
(3,'SI441','197509092002121001','307','Rabu','06:45:00','09:15:00'),
(4,'SI442','197808042003121001','204','Kamis','15:15:00','17:45:00'),
(5,'SI445','197906052003122003','307','Jumat','06:45:00','09:15:00');

/*Table structure for table `karturencanastudi` */

DROP TABLE IF EXISTS `karturencanastudi`;

CREATE TABLE `karturencanastudi` (
  `id_krs` int(11) NOT NULL AUTO_INCREMENT,
  `nim` char(12) DEFAULT NULL,
  `kode_mk` char(5) DEFAULT NULL,
  `semester` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_krs`),
  KEY `nim` (`nim`),
  KEY `kode_mk` (`kode_mk`),
  CONSTRAINT `karturencanastudi_ibfk_1` FOREIGN KEY (`nim`) REFERENCES `mahasiswa` (`nim`),
  CONSTRAINT `karturencanastudi_ibfk_2` FOREIGN KEY (`kode_mk`) REFERENCES `matakuliah` (`kode_mk`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `karturencanastudi` */

insert  into `karturencanastudi`(`id_krs`,`nim`,`kode_mk`,`semester`) values 
(1,'230441100081','SI443',4),
(2,'230441100171','SI444',4),
(3,'230441100034','SI441',4),
(4,'230441100026','SI442',4),
(5,'230441100047','SI445',4);

/*Table structure for table `mahasiswa` */

DROP TABLE IF EXISTS `mahasiswa`;

CREATE TABLE `mahasiswa` (
  `nim` char(12) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `prodi` varchar(100) DEFAULT NULL,
  `angkatan` year(4) DEFAULT NULL,
  PRIMARY KEY (`nim`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `mahasiswa` */

insert  into `mahasiswa`(`nim`,`nama`,`prodi`,`angkatan`) values 
('230441100026','Ar Raffi Abqori Nur Azizi','Sistem Informasi',2023),
('230441100027','Dylan Akhtareza','Sistem Infromasi',2023),
('230441100029','Vikas Irmanwansyah','Sistem Informasi',2023),
('230441100034','Agus Wedi','Sistem Informasi',2023),
('230441100041','Dony Eka Octavian Putra','Sistem Informasi',2023),
('230441100042','Mohammad Naufal Fahmi','Sistem Informasi',2023),
('230441100047','Muhammad Maulana Khanif','Sistem Informasi',2023),
('230441100081','Isma Yafa Nur Zamzami Ramadhani','Sistem Informasi',2023),
('230441100120','Alvyan Maulana Karnawan Putra','Sistem Informasi',2023),
('230441100171','Muhammad Fajri Alfaini','Sistem Informasi',2023);

/*Table structure for table `matakuliah` */

DROP TABLE IF EXISTS `matakuliah`;

CREATE TABLE `matakuliah` (
  `kode_mk` char(5) NOT NULL,
  `nama_mk` varchar(100) DEFAULT NULL,
  `sks` int(11) DEFAULT NULL,
  `nip` char(18) DEFAULT NULL,
  PRIMARY KEY (`kode_mk`),
  KEY `nip` (`nip`),
  CONSTRAINT `matakuliah_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `dosen` (`nip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `matakuliah` */

insert  into `matakuliah`(`kode_mk`,`nama_mk`,`sks`,`nip`) values 
('SI222','Pemrograman Berbasis objek',4,'197805042002121002'),
('SI223','Pengantar Basis Data',3,'198308282008122002'),
('SI226','E-Bussines dan E-Commerce',3,'198705202019031013'),
('SI441','Data Mining',3,'197509092002121001'),
('SI442','Implementasi Dan Pengujian Perangkat Lunak',3,'197808042003121001'),
('SI443','Sistem Pendukung Keputusan',3,'197709212008122002'),
('SI444','Sistem Manajemen Basis Data',4,'198003212008011008'),
('SI445','Perencanaan Sumber Daya Perusahaan',3,'197906052003122003'),
('SI446','Manajemen Proyek IT',3,'198711272014042001'),
('SI664','Internet Of Thing',3,'198306082008012005');

/*Table structure for table `ruang` */

DROP TABLE IF EXISTS `ruang`;

CREATE TABLE `ruang` (
  `kode_ruang` char(5) NOT NULL,
  `nama_ruang` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`kode_ruang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `ruang` */

insert  into `ruang`(`kode_ruang`,`nama_ruang`) values 
('204','RKBF Sistem Informasi'),
('307','RKBF Sistem Informasi'),
('308','RKBF Sistem Informasi');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
