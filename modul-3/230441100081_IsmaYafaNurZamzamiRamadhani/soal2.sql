-- Soal 1 --
DELIMITER //
CREATE PROCEDURE UpdateDataMaster (
	IN id_baru INT,
	IN nama_baru VARCHAR(100),
	OUT status_operasi VARCHAR(50)
)
BEGIN 
	UPDATE pelanggan
	SET nama_pelanggan = nama_baru
	WHERE id_pelanggan = id_baru;
	
	SET status_operasi = "sudah dijalankan";
END //
DELIMITER ;

CALL UpdateDataMaster (2,'budi sutiono',@status_operasi);

SELECT @status_operasi;

select * from pelanggan;

-- Soal 2 --

delimiter //
create procedure CountTransaksi (
	out total_jumlah int
)
begin 
	select count(*) into total_jumlah from detail_penjualan;
end // 
delimiter ;

call CountTransaksi (@total_jumlah);
select @total_jumlah;

-- Soal 3 --
delimiter //
create procedure GetDataMasterByID (
	in id_baru int,
	out data_out varchar (200)
)
begin 
	select * from bahan_baku where id_bahan_baku = id_baru;
end //
delimiter ;

call GetDataMasterByID (1,@data_out);

-- Soal 4 -- 

DELIMITER //
CREATE PROCEDURE UpdateFieldTransaksi (
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
END //
DELIMITER ;

SET @harga_baru = 20000.00;
SET @stok_baru = 50;
SET @id_produk = 1;

CALL UpdateFieldTransaksi(@id_produk, @harga_baru, @stok_baru);

SELECT * FROM produk WHERE id_produk = 1;


-- Soal 5 --

delimiter //
create procedure DeleteEntriesByIDMaster (
	in id_hapus int
)
begin 
	delete from produk where id_produk = id_hapus;
end //
delimiter ;

call DeleteEntriesByIDMaster (4);

select * from produk;
