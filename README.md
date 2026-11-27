# Student Dashboard — Flutter

Aplikasi **Student Dashboard** interaktif berbasis Flutter dan Dart yang dikembangkan untuk **Praktikum Pemrograman Perangkat Bergerak (PPB)**. Aplikasi ini mengusung antarmuka modern bernuansa **Sage Green** yang responsif—menampilkan *floating sidebar* pada layar lebar (Web/Desktop) serta *bottom navigation bar* pada layar perangkat mobile.

---

## Identitas Mahasiswa

| Keterangan | Detail |
| :--- | :--- |
| **Nama** | Muchammad Naufal Aziz |
| **NRP** | 5053251009 |
| **Program Studi** | Rekayasa Perangkat Lunak |
| **Kelas / Semester** | Kelas M • Semester 3 |

---

## Fitur Utama

* **Kartu Identitas & Profil Mahasiswa:** Menampilkan foto profil menggunakan `CircleAvatar` (`assets/profile_pic.jpg`), nama lengkap, NRP, program studi, kelas, serta tombol *Favorite* interaktif yang tersinkronisasi antara halaman Dashboard dan Profile.
* **Interactive Counter:** Mengimplementasikan `StatefulWidget` dan `setState()` dengan tombol tambah (`+`), kurang (`-`) yang dibatasi nilai minimum `0`, serta tombol `Reset`.
* **Ringkasan Akademik:** Menampilkan informasi beban studi **21 SKS** dan **7 Mata Kuliah** aktif pada semester berjalan.
* **Pencarian Menu (*Live Search*):** Kolom pencarian pada bagian atas dashboard untuk memfilter item pada *Learning Menu* secara langsung.
* **Learning Menu & Halaman Terpisah:** Menggunakan `GridView.builder` yang menghubungkan setiap menu ke halamannya masing-masing:
  1. **Flutter Fundamentals** — Ringkasan konsep dasar widget, layouting, dan navigasi Flutter.
  2. **Enrolled Courses** — Daftar 7 mata kuliah yang diambil pada Semester 3 (Kelas M).
  3. **Learning Materials** — Daftar modul dan materi perkuliahan.
  4. **Assignments** — Daftar praktikum dan tugas beserta status pengerjaannya.
  5. **Grades / Nilai** — Rekap nilai dan skor akhir dari 7 mata kuliah.
* **Navigasi Responsif:** Otomatis menyesuaikan tata letak antara *Floating Sidebar* (lebar layar $\ge 850\text{px}$) dan `NavigationBar` (layar mobile) untuk berpindah antar halaman **Dashboard**, **Courses**, dan **Profile**.

---

## Widget & Komponen Utama

* `MaterialApp` & `Scaffold`
* `AppBar` & `NavigationBar`
* `Card`, `Column`, `Row`, `Expanded`
* `GridView.builder` & `ListView.builder`
* `CircleAvatar` & `AssetImage`
* `StatefulWidget` & `setState()`

---

## Struktur Direktori

```text
studentdashboard/
├── assets/
│   └── profile_pic.jpg
├── lib/
│   └── main.dart
├── pubspec.yaml
└── README.md
```



