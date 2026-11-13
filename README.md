## Perbandingan Provider vs Cubit

| Pertanyaan | Provider | Cubit |
|---|---|---|
| Berapa berkas/baris yang berubah? | 9 berkas (7 tanpa file otomatis), +221 −8 | 8 berkas (7 tanpa file otomatis), +241 −15 |
| Di mana logika bisnis berada? | `KeranjangModel` (lib/keranjang_model.dart) | `KeranjangCubit` (lib/keranjang_cubit.dart) |
| Bagaimana UI mengetahui perubahan? | Model memanggil `notifyListeners()`; UI memakai `watch`/`select` | Cubit memanggil `emit()` dengan state baru; UI memakai `BlocBuilder`/`select` |
| Mana yang lebih mudah diuji? Mengapa? | (isi pendapat Anda) | (isi pendapat Anda) |
| Mana yang dipilih untuk proyek akhir? Mengapa? | (isi pendapat Anda) | (isi pendapat Anda) |

Catatan: angka diambil dari `git diff --stat main <branch>`.