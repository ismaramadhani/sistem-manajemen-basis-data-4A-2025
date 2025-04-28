-- Soal 1 --
ALTER TABLE penjualan 
ADD COLUMN keterangan TEXT;

-- Soal 2 --

SELECT a.nama_produk, b.jumlah FROM produk a JOIN detail_penjualan b ON a.id_produk = b.id_produk;

-- Soal 3 --

SELECT * FROM pelanggan ORDER BY nama_pelanggan DESC;

SELECT * FROM produk ORDER BY nama_produk ASC;

SELECT * FROM detail_penjualan ORDER BY jumlah;

-- Soal 4 ---

ALTER TABLE penjualan MODIFY COLUMN keterangan VARCHAR(200);
describe penjualan;

-- Soal 5 --

select a.id_produk, b.jumlah, a.nama_produk from produk a left join detail_penjualan b on a.id_produk = b.`id_produk`;

select a.nama_bahan, b.nama_resep from bahan_baku a right join resep_produk b  on a.id_bahan_baku = b.`id_bahan_baku`;

select p1.nama_produk as nama1, p2.nama_produk as nama2, p1.harga from produk p1 inner join produk p2 on p1.harga = p2.harga AND p1.id_produk < p2.id_produk;

-- Soal 6 --

select * from produk where harga > 10000 and harga between 10000 and 20000 and stok < 150 and nama_produk != 'Donat' and nama_produk like '%Roti%';