# Katalog Oleh-Oleh Medan: Praktikum Pertemuan 7
 
Praktikum State Management (setState, Provider, Cubit) pada mata kuliah Pemrograman Mobile.
Fitur keranjang belanja ditambahkan ke aplikasi katalog Pertemuan 6, dibangun dua kali dengan pendekatan berbeda di branch terpisah.
 
## Identitas
 
- Nama: (isi nama Anda)
- NIM: (isi NIM Anda)
- Mata Kuliah: Pemrograman Mobile (3KOM40215), Semester 5
- Program Studi Ilmu Komputer, FMIPA, Universitas Negeri Medan
## Branch
 
| Branch | Pendekatan | Paket |
|---|---|---|
| `main` | Katalog Pertemuan 6 (tanpa keranjang) | go_router |
| `keranjang-provider` | ChangeNotifier + Provider | provider |
| `keranjang-cubit` | Cubit (state immutable) | flutter_bloc |
 
Kedua branch sengaja tidak digabung ke `main` agar dapat dibandingkan.
 
## Fitur
 
- Tombol **Tambah ke keranjang** di halaman detail produk (label berubah menjadi "Tambah lagi (n di keranjang)").
- **Badge** jumlah item pada ikon keranjang di navigasi.
- Tab **Keranjang**: daftar item, tombol tambah/kurang, total harga, dan tombol **Checkout** (menampilkan SnackBar "Pesanan dibuat (simulasi)").
## Struktur Utama
 
```
lib/
  data.dart               data produk, cariProduk, extension .rupiah
  main.dart               router go_router, provider di atas pohon, kerangka navigasi + badge
  halaman_detail.dart     tombol tambah ke keranjang
  halaman_keranjang.dart  daftar, total, checkout
  keranjang_model.dart    (branch Provider) ChangeNotifier
  keranjang_cubit.dart    (branch Cubit) Cubit + KeranjangState
test/
  widget_test.dart        test widget, dibungkus Provider/BlocProvider
  keranjang_test.dart     (Provider) unit test model
  keranjang_cubit_test.dart  (Cubit) unit test cubit
```
 
## Cara Menjalankan
 
```bash
git switch keranjang-provider   # atau keranjang-cubit
flutter pub get
flutter run
flutter test
```
 
## Perbandingan Provider vs Cubit
 
| Pertanyaan | Provider | Cubit |
|---|---|---|
| Berapa berkas/baris yang berubah? | 9 berkas (7 tanpa file otomatis), +221 −8 | 8 berkas (7 tanpa file otomatis), +241 −15 |
| Di mana logika bisnis berada? | `KeranjangModel` (lib/keranjang_model.dart) | `KeranjangCubit` (lib/keranjang_cubit.dart) |
| Bagaimana UI mengetahui perubahan? | Model memanggil `notifyListeners()`; UI memakai `watch`/`select` | Cubit memanggil `emit()` dengan state baru; UI memakai `BlocBuilder`/`select` |
| Mana yang lebih mudah diuji? Mengapa? | Mudah. `KeranjangModel` adalah kelas Dart biasa, jadi cukup dibuat dan dipanggil tanpa UI. Kekurangannya, test harus memasang `addListener` dan menghitung notifikasi (`notifikasi == 4`) untuk memastikan UI akan diberi tahu. | Sedikit lebih mudah. Test cukup memanggil method lalu membaca `cubit.state`, tanpa listener. State adalah objek tersendiri yang bisa diperiksa setelah tiap langkah. Kekurangannya, harus memanggil `close()` di akhir, dan `KeranjangState` belum menimpa `==`, jadi state tidak bisa dibandingkan utuh dengan `expect`. |
| Mana yang dipilih untuk proyek akhir? Mengapa? | (tidak dipilih) | Cubit. Alasan teknis: state immutable membuat alur data satu arah dan mudah ditelusuri, serta efek sekali jalan seperti SnackBar checkout dipisahkan jelas lewat `BlocListener`. Alasan non-teknis: struktur ini memudahkan pembagian kerja dalam tim karena logika dan UI terpisah tegas. Konsekuensinya kodenya lebih panjang, misalnya menyalin Map setiap perubahan dan menambah field `pesananSelesai`. |
 
Catatan: angka diambil dari `git diff --stat main <branch>`. "File otomatis" adalah `pubspec.lock` dan `devtools_options.yaml`.

## Tangkapan Layar
`screenshots/`![alt text](<Halaman detail dengan tombol tambah ke keranjang.jpeg>)
`screenshots/`![alt text](<Tab Keranjang (daftar, total).jpeg>)
 