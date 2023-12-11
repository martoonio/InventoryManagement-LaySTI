# Inventory Management System

## Deskripsi
Aplikasi Perangkat Lunak Inventory Management System (IMS) ini adalah solusi komprehensif untuk manajemen dan pemantauan inventaris bahan baku dalam suatu organisasi. IMS dirancang untuk meningkatkan efisiensi dalam proses pengelolaan stok, memastikan ketersediaan bahan baku yang memadai, dan memberikan transparansi terhadap pergerakan bahan baku. 

## Role
IMS memiliki dua peran utama: Admin dan User (tim produksi). Admin memiliki akses penuh ke fitur Materials dan History, sementara User dapat menggunakan fitur Make Order dan History.

## Fitur Utama
1. Materials (Admin)
Fitur Materials memungkinkan pengguna untuk melihat bahan baku yang sudah tersimpan di inventory beserta kuantitasnya. Fungsionalitas utama melibatkan:
-   Tampilan Bahan Baku: Menampilkan daftar bahan baku yang ada di inventory.
-   Kuantitas: Menampilkan kuantitas dari setiap bahan baku.

2. History (Admin)
Fitur History memungkinkan pengguna untuk melihat riwayat pergerakan bahan baku dalam sistem, mencakup:
-   Materials In: Menampilkan bahan baku yang baru saja ditambahkan ke inventory.
-   Materials Out: Keluar ke Production: Menampilkan bahan baku yang telah digunakan dalam proses produksi.
-   Request Materials: Menampilkan bahan baku yang sedang dalam proses permintaan ke supplier berdasarkan permintaan dari produksi.

3. Make Order (User)
Fitur Make Order memungkinkan User (tim produksi) untuk membuat pesanan bahan baku yang tidak tersedia di inventory dan harus diproduksi terlebih dahulu. Fungsionalitas utama melibatkan:
-   Pemilihan Barang: User dapat memasukkan barang yang ingin dibuat sesuai dengan katalog.
-   Membuat Pesanan: User dapat membuat pesanan bahan baku baru untuk diproduksi, dengan menentukan jumlah yang dibutuhkan.

4. History (User)
Fitur History memungkinkan User (tim produksi) untuk melihat riwayat pesanan barang yang telah dibuat. Fungsionalitas utama melibatkan:
-   Melihat Riwayat Pesanan: User dapat melihat daftar barang yang pernah dipesan bersama dengan tanggal dan status pesanan. 
-   Automatic Supplier Request (Jika Order Pending): Jika status pesanan berada dalam kondisi pending (karena tidak ada bahan di inventory), sistem akan secara otomatis membuat permintaan ke supplier untuk memenuhi kebutuhan bahan baku yang dibutuhkan. Fungsionalitas ini secara langsung terhubung ke request materials di fungsi History milik Admin.

## Pedoman Penggunaan
1. Untuk mengakses perangkat lunak dapat dilakukan dengan download aplikasi di [Aplikasi Inventory Management System](https://drive.google.com/drive/folders/1T4EvlsONIiUUA7PrE0U5-NzWb9Dit-ae?usp=sharing) atau masuk lewat [Website Inventory Management System](https://inventory-management-lay-sti.vercel.app/)
2. Admin adalah tim inventory yang memiliki akses ke materials yang tersedia, materials yang digunakan untuk produksi, dan materials yang sedang direquest ke supplier. Untuk masuk sebagai admin, login dengan email `admin@lasti.com` dan password `admin123`.
3. User adalah tim produksi yang bertugas untuk memesan produk apabila produk tersebut tidak ada di inventory produk. Untuk masuk sebagai user, login dengan email `user@lasti.com` dan password `user123`.

## Anggota Kelompok
- Adrian Fahri Affandi - 18221002
- Farchan Martha Adji Chandra - 18221011
- Raden Sjora Okalani - 18221014
- Nabilah Amanda Putri - 18221021
- Athira Dhyanissa Tafkir - 18221022