# Sahabat Warga

Aplikasi Flutter **Sahabat Warga** membantu warga menyampaikan laporan
lingkungan dan berkomunikasi dengan tim Sahabat Warga. Proyek ini bernama
`tubes_sahabatwarga_707012401039`.

## Fitur praktikum

- **Form dan input:** form laporan menggunakan `TextFormField`, pilihan kategori
  dengan radio, serta checkbox untuk persetujuan dan laporan anonim.
- **Pustaka chat:** percakapan warga menggunakan `dash_chat_2`.
- **State dan navigasi:** `FormLaporanModel`, `ChatModel`, dan `FavoritModel`
  disediakan melalui `MultiProvider`. Route aplikasi terdaftar sebagai konstanta
  di `lib/navigation/app_routes.dart`.
- **Tema:** teal dan amber dengan latar terang agar tampilan konsisten dan nyaman
  dibaca.

Laporan yang dikirim muncul pada beranda dan daftar laporan. Pesan percakapan
dikelola oleh provider dan jumlah pesan juga ditampilkan pada beranda.

## Menjalankan aplikasi

```sh
flutter pub get
flutter run
```

Jalankan pengujian widget dengan:

```sh
flutter test
```
