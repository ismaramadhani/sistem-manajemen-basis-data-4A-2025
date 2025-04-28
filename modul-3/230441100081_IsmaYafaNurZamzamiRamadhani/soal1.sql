-- Soal 1 --

DELIMITER//
CREATE PROCEDURE AddUMKM (
	IN nama_usaha VARCHAR(200),
	IN jumlah_karyawan INT(11)
)
BEGIN 
	INSERT INTO umkm (nama_usaha, jumlah_karyawan)
	VALUES (nama_usaha, jumlah_karyawan);
END;
DELIMITER;

CALL AddUMKM("Ayam Geprek Sejahtera",35);

SELECT id_umkm, nama_usaha, jumlah_karyawan FROM umkm;

-- Soal 2 --

delimiter //
create procedure UpdateKategoriUMKM (
	in a_id_kategori int(11),
	in b_nama_baru varchar(100)
)
begin
	update kategori_umkm 
	set nama_kategori = b_nama_baru
	where id_kategori = a_id_kategori;
end//
delimiter//

call UpdateKategoriUMKM(7,'makanan');

select * from kategori_umkm;

-- Soal 3 --

delimiter // 
create procedure DeletePemilikUMKM(
	in a_id_pemilik int
)
begin 
	delete from pemilik_umkm
	where id_pemilik = a_id_pemilik;
end//
delimiter;

call DeletePemilikUMKM(15);

select * from pemilik_umkm;

-- Soal 4 --

delimiter //
create procedure AddProduk(
	in a_id_umkm int,
	in a_nama_produk varchar(200),
	in a_harga decimal(15,2)
)
begin
	insert into produk_umkm (id_umkm, nama_produk, harga)
	values (a_id_umkm, a_nama_produk, a_harga);
end // 
delimiter;

call AddProduk (14, 'Geprek Walang', 100000.00);

select * from produk_umkm;

-- Soal 5 --

DELIMITER //
CREATE PROCEDURE GetUMKMByID (
    IN p_id_umkm INT,
    OUT p_nama_usaha VARCHAR(200),
    OUT p_alamat_usaha text
)
BEGIN
    SELECT nama_usaha, alamat_usaha
    INTO p_nama_usaha, p_alamat_usaha
    FROM umkm
    WHERE id_umkm = p_id_umkm;
END //
DELIMITER ;

CALL GetUMKMByID(3, @p_nama_usaha, @p_alamat_usaha);
SELECT @p_nama_usaha AS nama_usaha, @p_alamat_usaha AS alamat_usaha;



	


