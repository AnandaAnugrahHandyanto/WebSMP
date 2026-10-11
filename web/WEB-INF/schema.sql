-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 28, 2026 at 09:00 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_smp`
--
CREATE DATABASE IF NOT EXISTS `db_smp` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `db_smp`;

--
-- Hapus semua tabel lama (urutan dari child ke parent)
--
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `absensi`;
DROP TABLE IF EXISTS `jadwal`;
DROP TABLE IF EXISTS `TblRuangKuliah`;
DROP TABLE IF EXISTS `nilai`;
DROP TABLE IF EXISTS `siswa`;
DROP TABLE IF EXISTS `mapel`;
DROP TABLE IF EXISTS `kelas`;
DROP TABLE IF EXISTS `guru`;
DROP TABLE IF EXISTS `users`;
SET FOREIGN_KEY_CHECKS = 1;

--
-- Struktur tabel untuk tabel `users`
--
CREATE TABLE `users` (
  `id_user` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `role` ENUM('admin','guru','siswa') NOT NULL DEFAULT 'admin',
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Struktur tabel untuk tabel `guru`
--
CREATE TABLE `guru` (
  `id_guru` INT(11) NOT NULL AUTO_INCREMENT,
  `nip` VARCHAR(20) NOT NULL UNIQUE,
  `nama_guru` VARCHAR(100) NOT NULL,
  `jenis_kelamin` ENUM('L','P') NOT NULL,
  `no_hp` VARCHAR(15) DEFAULT NULL,
  PRIMARY KEY (`id_guru`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Struktur tabel untuk tabel `kelas`
--
CREATE TABLE `kelas` (
  `id_kelas` INT(11) NOT NULL AUTO_INCREMENT,
  `nama_kelas` VARCHAR(50) NOT NULL UNIQUE,
  `id_wali_kelas` INT(11) DEFAULT NULL,
  PRIMARY KEY (`id_kelas`),
  FOREIGN KEY (`id_wali_kelas`) REFERENCES `guru`(`id_guru`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Struktur tabel untuk tabel `siswa`
--
CREATE TABLE `siswa` (
  `id_siswa` INT(11) NOT NULL AUTO_INCREMENT,
  `nis` VARCHAR(20) NOT NULL UNIQUE,
  `nama_siswa` VARCHAR(100) NOT NULL,
  `jenis_kelamin` ENUM('L','P') NOT NULL,
  `tanggal_lahir` DATE DEFAULT NULL,
  `alamat` TEXT DEFAULT NULL,
  `no_hp` VARCHAR(15) DEFAULT NULL,
  `id_kelas` INT(11) DEFAULT NULL,
  PRIMARY KEY (`id_siswa`),
  FOREIGN KEY (`id_kelas`) REFERENCES `kelas`(`id_kelas`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Struktur tabel untuk tabel `mapel`
--
CREATE TABLE `mapel` (
  `id_mapel` INT(11) NOT NULL AUTO_INCREMENT,
  `kode_mapel` VARCHAR(10) NOT NULL UNIQUE,
  `nama_mapel` VARCHAR(100) NOT NULL,
  `id_guru_pengampu` INT(11) DEFAULT NULL,
  `kkm` INT(11) DEFAULT 75,
  PRIMARY KEY (`id_mapel`),
  FOREIGN KEY (`id_guru_pengampu`) REFERENCES `guru`(`id_guru`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Struktur tabel untuk tabel `nilai`
--
CREATE TABLE `nilai` (
  `id_nilai` INT(11) NOT NULL AUTO_INCREMENT,
  `id_siswa` INT(11) NOT NULL,
  `id_mapel` INT(11) NOT NULL,
  `nilai_tugas` INT(11) DEFAULT 0,
  `nilai_uts` INT(11) DEFAULT 0,
  `nilai_uas` INT(11) DEFAULT 0,
  `nilai_akhir` DECIMAL(5,2) DEFAULT 0.00,
  `predikat` CHAR(1) DEFAULT 'D',
  PRIMARY KEY (`id_nilai`),
  UNIQUE KEY `idx_siswa_mapel` (`id_siswa`, `id_mapel`),
  FOREIGN KEY (`id_siswa`) REFERENCES `siswa`(`id_siswa`) ON DELETE CASCADE,
  FOREIGN KEY (`id_mapel`) REFERENCES `mapel`(`id_mapel`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Struktur tabel untuk tabel `jadwal`
--
CREATE TABLE `jadwal` (
  `id_jadwal` INT(11) NOT NULL AUTO_INCREMENT,
  `id_kelas` INT(11) NOT NULL,
  `id_mapel` INT(11) NOT NULL,
  `id_guru` INT(11) NOT NULL,
  `hari` ENUM('Senin','Selasa','Rabu','Kamis','Jumat') NOT NULL,
  `jam_mulai` TIME NOT NULL,
  `jam_selesai` TIME NOT NULL,
  `ruang` VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (`id_jadwal`),
  FOREIGN KEY (`id_kelas`) REFERENCES `kelas`(`id_kelas`) ON DELETE CASCADE,
  FOREIGN KEY (`id_mapel`) REFERENCES `mapel`(`id_mapel`) ON DELETE CASCADE,
  FOREIGN KEY (`id_guru`) REFERENCES `guru`(`id_guru`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Struktur tabel untuk tabel `TblRuangKuliah`
--
CREATE TABLE `TblRuangKuliah` (
  `No` INT NOT NULL AUTO_INCREMENT,
  `idruang` VARCHAR(3) NOT NULL,
  `Letak` VARCHAR(10) NOT NULL,
  `Lokasi` VARCHAR(10) NOT NULL,
  `Kapasitas` INT NOT NULL,
  PRIMARY KEY (`No`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `TblRuangKuliah`
--
INSERT INTO `TblRuangKuliah` (`idruang`, `Letak`, `Lokasi`, `Kapasitas`) VALUES
('201', 'Lantai 2', 'Gedung A', 30),
('202', 'Lantai 2', 'Gedung A', 40),
('301', 'Lantai 3', 'Gedung A', 30),
('302', 'Lantai 3', 'Gedung A', 40),
('401', 'Lantai 4', 'Gedung A', 30),
('402', 'Lantai 4', 'Gedung A', 40),
('201', 'Lantai 2', 'Gedung B', 30),
('202', 'Lantai 2', 'Gedung B', 40),
('301', 'Lantai 3', 'Gedung B', 30),
('302', 'Lantai 3', 'Gedung B', 40),
('401', 'Lantai 4', 'Gedung B', 30);

--
-- Struktur tabel untuk tabel `absensi`
--
CREATE TABLE `absensi` (
  `id_absensi` INT(11) NOT NULL AUTO_INCREMENT,
  `id_siswa` INT(11) NOT NULL,
  `tanggal` DATE NOT NULL,
  `status` ENUM('Hadir','Sakit','Izin','Alpa') NOT NULL,
  `keterangan` TEXT DEFAULT NULL,
  PRIMARY KEY (`id_absensi`),
  UNIQUE KEY `idx_siswa_tanggal` (`id_siswa`, `tanggal`),
  FOREIGN KEY (`id_siswa`) REFERENCES `siswa`(`id_siswa`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `users`
--
INSERT INTO `users` (`username`, `password`, `role`) VALUES
('admin', 'admin', 'admin');

--
-- Dumping data untuk tabel `guru`
--
INSERT INTO `guru` (`nip`, `nama_guru`, `jenis_kelamin`, `no_hp`) VALUES
('198501012010011001', 'Budi Santoso, S.Pd', 'L', '081234567890'),
('198702022011012002', 'Sari Dewi, M.Pd', 'P', '081234567891');

--
-- Dumping data untuk tabel `kelas`
--
INSERT INTO `kelas` (`nama_kelas`, `id_wali_kelas`) VALUES
('VII A', 1),
('VII B', 2);

--
-- Dumping data untuk tabel `mapel`
--
INSERT INTO `mapel` (`kode_mapel`, `nama_mapel`, `id_guru_pengampu`, `kkm`) VALUES
('MTK', 'Matematika', 1, 75),
('IPA', 'Ilmu Pengetahuan Alam', 2, 75),
('BIN', 'Bahasa Indonesia', 1, 75);

--
-- Dumping data untuk tabel `siswa`
--
INSERT INTO `siswa` (`nis`, `nama_siswa`, `jenis_kelamin`, `alamat`, `id_kelas`) VALUES
('2024001', 'Andi Pratama', 'L', 'Jl. Merdeka No. 10', 1),
('2024002', 'Siti Nurhaliza', 'P', 'Jl. Sudirman No. 5', 1),
('2024003', 'Rizki Ramadhan', 'L', 'Jl. Diponegoro No. 20', 2);

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;