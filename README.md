# mood_tracer_app

## Deskripsi
Mood Tracer App adalah aplikasi mobile & web berbasis Flutter yang berfungsi untuk membantu pengguna melacak suasana hati (mood) mereka setiap hari. Aplikasi ini mencatat mood harian pengguna, menyimpan data ke database melalui koneksi API (Node.js + MongoDB), dan menyediakan fitur login/sign up akun pengguna. Aplikasi ini menggunakan UI responsif, mendukung dark mode, serta menerapkan manajemen state menggunakan Provider.

## Tujuan Aplikasi
1. Membantu pengguna memahami pola suasana hati mereka dari hari ke hari.
2. Mendukung pengguna dalam mencatat perasaan dan catatan harian secara pribadi.
3. Mengimplementasikan full-stack Flutter app dengan koneksi ke backend API dan database.
4. Menunjukkan penggunaan autentikasi user melalui Sign Up & Sign In.
5. Melatih pengembangan aplikasi modern berbasis Flutter dengan backend Node.js + MongoDB.

## Fitur-fitur Utama
1. Sign Up & Sign In
   Pengguna dapat mendaftar dan login menggunakan email & password. Data diverifikasi dari database MongoDB.
2. Tracking Mood
   Pengguna dapat mencatat suasana hati (happy, sad, excited, dsb) dan memberi catatan pribadi.
4. Dashboard & Mood List
   Menampilkan daftar suasana hati yang pernah dicatat.
5. Tema Gelap/Terang (Dark Mode)
   Pengguna dapat mengganti tema tampilan aplikasi
6. State Management (Provider)
   Mengelola status login, tema, dan mood secara global.
7. Responsif & Adaptif
   Mendukung tampilan untuk mobile & web dengan go_router, DevicePreview, dan MediaQuery.
8. Terhubung ke Backend API
   Menggunakan HTTP request (http.post) ke Node.js server dengan data disimpan di MongoDB

## Teknologi yang Digunakan
1. Frontend (Flutter):
   - flutter & dart
   - provider → manajemen state
   - go_router → navigasi antar halaman
   - google_fonts, intl → tampilan modern
   - device_preview → simulasi multi-device
2. Backend (API):
   - Node.js + Express → membuat REST API
   - MongoDB → menyimpan data akun dan mood
   - bcryptjs → enkripsi password
   - jsonwebtoken (opsional) → autentikasi lanjutan

## Autentikasi User
- Saat pengguna Sign Up:
  1. Data dikirim via POST /signup ke API
  2. Password dienkripsi dan disimpan di MongoDB
- Saat Sign In:
  1. Flutter mengirim email & password ke POST /login
  2. Server mencocokkan dan membalas token (opsional)

## Penyimpan Mood
