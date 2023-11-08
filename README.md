# Tugas 7
## 1. Apa perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter?
Perbedaan utama antara stateless dan stateful widget terletak di statis atau dinamis nya widget
Stateless Widget:
- Tidak dapat berubah: Widget ini tidak memiliki keadaan (state) internal yang dapat berubah. Artinya, setelah widget dibuat, tampilannya tidak akan berubah.
- Dipakai untuk komponen statis: Stateless widget cocok untuk menampilkan komponen yang tidak perlu berubah selama siklus hidup aplikasi, seperti teks, gambar, atau ikon statis.
- Efisien: Stateless widget lebih efisien daripada Stateful widget karena tidak perlu memperbarui tampilan saat keadaan berubah.

Stateful Widget:
- Dapat berubah: Widget ini memiliki keadaan (state) internal yang dapat berubah. Artinya, tampilan widget dapat diperbarui selama siklus hidup aplikasi.
- Digunakan untuk komponen dinamis: Stateful widget digunakan ketika kita perlu memperbarui atau merender ulang tampilan sesuai dengan perubahan dalam keadaan atau interaksi pengguna.
- Lebih kompleks: Stateful widget memerlukan pengelolaan keadaan dan pengelolaan siklus hidup widget, sehingga lebih kompleks daripada Stateless widget.
## 2. Sebutkan seluruh widget yang kamu gunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing.
- `MyApp` (Stateless Widget):
widget utama, Fungsi utamanya adalah sebagai titik masuk utama aplikasi. MyApp menetapkan tema aplikasi dan menginisialisasi MyHomePage sebagai halaman utama.
- `MyHomePage` (Stateless Widget):
tampilan utama dari aplikasi. Berisi AppBar dengan judul "United Squad" dan latar belakang berwarna indigo. Menampilkan daftar item di dalam GridView, di mana setiap item direpresentasikan oleh ShopCard.
ShopCard dirender berdasarkan item yang ada dalam daftar items.
- `ShopItem` (Class):
Ini adalah kelas model untuk setiap item di toko.
Setiap item memiliki tiga properti: name (nama item), icon (ikon yang terkait dengan item), dan color (warna latar belakang dari ShopCard yang terkait dengan item tersebut).
- `ShopCard` (Stateless Widget):
digunakan untuk menampilkan setiap item toko sebagai kartu.Mendefinisikan latar belakang kartu sesuai dengan warna yang terkait dengan item dari ShopItem.Saat kartu ditekan, akan menampilkan SnackBar yang memberi tahu pengguna tombol mana yang ditekan.
## 3. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step
1. Pada `main.dart`, meng-import package yang dibutuhkan.
    ~~~
    import 'package:flutter/material.dart';
    ~~~
2. Membuat class `MyApp` yang akan meng-extend `StatelessWidget`
    ~~~
        class MyApp extends StatelessWidget {
    const MyApp({super.key});

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a blue toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 241, 5, 5)),
            useMaterial3: true,
        ),
        home: MyHomePage(),
        );
    }
    }
    ~~~

3. Membuat file baru bernama `menu.dart` yang menyimpan logika untuk menu. lalu mengimport package yang dibutuhkan
    ~~~
    import 'package:flutter/material.dart';
    ~~~

4. Membuat class `ShopItem` yang nantinya akan menerima atribut `nama`, `icon`, dan `color`
    ~~~
    class ShopItem {
    final String name;
    final IconData icon;
    final Color color;

    ShopItem(this.name, this.icon, this.color);
    }
    ~~~

6\5. Membuat class `ShopCard` yang nantinya akan menggunakan data yang dimiliki dari `ShopItem` dan mendefinisikan atribut penampilannya.
    ~~~
    class ShopCard extends StatelessWidget {
    final ShopItem item;

    const ShopCard(this.item, {super.key}); // Constructor

    @override
    Widget build(BuildContext context) {
        return Material(
        color: item.color,
        child: InkWell(
            // Area responsive terhadap sentuhan
            onTap: () {
            // Memunculkan SnackBar ketika diklik
            ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    content: Text("Kamu telah menekan tombol ${item.name}!")));
            },
            child: Container(
            // Container untuk menyimpan Icon dan Text
            padding: const EdgeInsets.all(8),
            child: Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    Icon(
                    item.icon,
                    color: Colors.white,
                    size: 30.0,
                    ),
                    const Padding(padding: EdgeInsets.all(3)),
                    Text(
                    item.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                    ),
                ],
                ),
            ),
            ),
        ),
        );
    }
    }
    ~~~

6. Membuat class `MyHomePage` yang akan menampilkan widget-widget pada halaman utama
    ~~~
    class MyHomePage extends StatelessWidget {
        MyHomePage({Key? key}) : super(key: key);

        final List<ShopItem> items = [
            ShopItem("Lihat Item", Icons.checklist, Colors.yellow),
            ShopItem("Tambah Item", Icons.add_shopping_cart, Colors.green),
            ShopItem("Logout", Icons.logout, Colors.orange),
        ];

        @override
        Widget build(BuildContext context) {
            return Scaffold(
            appBar: AppBar(
                title: const Text(
                'United Squad',
                style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.indigo,
            ),
            body: SingleChildScrollView(
                // Widget wrapper yang dapat discroll
                child: Padding(
                padding: const EdgeInsets.all(10.0), // Set padding dari halaman
                child: Column(
                    // Widget untuk menampilkan children secara vertikal
                    children: <Widget>[
                    const Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                        child: Text(
                        'United Shop', // Text yang menandakan toko
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                        ),
                        ),
                    ),
                    // Grid layout
                    GridView.count(
                        // Container pada card kita.
                        primary: true,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        children: items.map((ShopItem item) {
                        // Iterasi untuk setiap item
                        return ShopCard(item);
                        }).toList(),
                    ),
                    ],
                ),
                ),
            ),
            );
        }
    }
    ~~~
