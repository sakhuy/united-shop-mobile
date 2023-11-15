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

# TUGAS 8
## Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement(), disertai dengan contoh mengenai penggunaan kedua metode tersebut yang tepat!
-`Navigator.push()`: Metode ini digunakan untuk menambahkan halaman baru ke dalam tumpukan halaman (page stack) Navigator. Ini berarti halaman sebelumnya akan tetap ada di tumpukan dan dapat dikembalikan ke halaman tersebut.
~~~
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => NewPage()),
);
~~~
-`Navigator.pushReplacement()`: Metode ini juga menambahkan halaman baru ke dalam tumpukan halaman Navigator, tetapi dengan menggantikan halaman sebelumnya. Halaman sebelumnya dihapus dari tumpukan, sehingga pengguna tidak dapat kembali ke halaman tersebut.
~~~
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => NewPage()),
);
~~~
## Jelaskan masing-masing layout widget pada Flutter dan konteks penggunaannya masing-masing!
- Scaffold: Digunakan untuk membuat tata letak dasar aplikasi, seperti AppBar, Drawer, dan BottomNavigationBar.
- AppBar: Menyediakan AppBar (bilah aplikasi) yang menampilkan judul dan aksi aplikasi.
- Drawer: Digunakan untuk membuat menu geser yang dapat diakses dari sisi kiri atau kanan aplikasi.
## Sebutkan apa saja elemen input pada form yang kamu pakai pada tugas kali ini dan jelaskan mengapa kamu menggunakan elemen input tersebut!
TextFormField: Digunakan untuk memasukkan teks atau string. Pada tugas ini, digunakan untuk input Nama Produk, Harga, dan Deskripsi. Validasi dilakukan dengan memastikan input tidak kosong dan sesuai dengan tipe data yang diharapkan.
## Bagaimana penerapan clean architecture pada aplikasi Flutter?
Clean Architecture adalah pendekatan pengembangan perangkat lunak yang memisahkan aplikasi menjadi beberapa lapisan agar lebih modular dan mudah diuji. Dalam konteks Flutter, implementasi Clean Architecture dapat melibatkan:

Domain Layer: Berisi aturan bisnis, entitas, dan use case aplikasi.
Data Layer: Menangani akses ke sumber data eksternal seperti API atau database.
Presentation Layer: Menangani UI dan interaksi pengguna.
Penerapan Clean Architecture pada Flutter melibatkan penggunaan paket atau library tertentu, seperti `flutter_bloc` atau `provider`, untuk mengelola keadaan (state) dan dependensi antar lapisan. Selain itu, kelas-kelas yang berada di lapisan domain harus bersih dari ketergantungan pada lapisan lain.

## Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial)
1. Membuat folder baru pada lib yaitu screens dan widgets untuk mempermudah melakukan metode clean architeture, lalu buat file `shoplist_form.dart` sebagai halaman form untuk menerima input. 

~~~
import 'package:flutter/material.dart';
import 'package:united_squad/widgets/left_drawer.dart';

class ShopFormPage extends StatefulWidget {
  const ShopFormPage({super.key});

  @override
  State<ShopFormPage> createState() => _ShopFormPageState();
}

class _ShopFormPageState extends State<ShopFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _amount = 0;
  int _price = 0;
  String _description = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Form Tambah Produk',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Produk",
                    labelText: "Nama Produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _name = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Nama tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Jumlah",
                    labelText: "Jumlah",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _price = int.parse(value!);
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Jumlah tidak boleh kosong!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Jumlah harus berupa angka!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Harga",
                    labelText: "Harga",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _price = int.parse(value!);
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Harga tidak boleh kosong!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Harga harus berupa angka!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Deskripsi",
                    labelText: "Deskripsi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Deskripsi tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Produk berhasil tersimpan'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nama: $_name'),
                                    Text('Jumlah: $_amount'),
                                    Text('Harga: $_price'),
                                    Text('Deskripsi: $_description'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        _formKey.currentState!.reset();
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

~~~

2. Membuat drawer yang menghubungkan opsi tambah item yang berada pada drawer dan halaman utama ke shoplist_form.dart
~~~
import 'package:flutter/material.dart';
import 'package:united_squad/screens/menu.dart';
import 'package:united_squad/screens/shoplist_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
            child: Column(
              children: [
                Text(
                  'Shopping List',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text("Catat seluruh keperluan belanjamu di sini!",
                    textAlign:  TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    )
                    ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Tambah Produk'),
            // Bagian redirection ke ShopFormPage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShopFormPage(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
~~~

3. Menghubungkan "Tambah Item" button pada halaman utama menuju `ShopFormPage`
~~~
if (item.name == "Tambah Item") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ShopFormPage()));
          }
~~~

IMPLEMENTASI BONUS

Membuat model `Item` dalam `Item.dart` di folder baru `models`
~~~
class Item {
  String name;
  int amount;
  int price;
  String description;

  Item({required this.name, required this.amount, required this.price, required this.description});
}
~~~

memodifikasi `shoplist_form.dart` agar menyimpan hasil produk yang telah dibuat
~~~
List<Item> itemList = [];
~~~
~~~
Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        itemList.add(Item(
                          name: _name,
                          amount: _amount,
                          price: _price,
                          description: _description,
                        ));
                        
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Produk berhasil tersimpan'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nama: $_name'),
                                    Text('Jumlah: $_amount'),
                                    Text('Harga: $_price'),
                                    Text('Deskripsi: $_description'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                        _formKey.currentState!.reset();
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
~~~

Membuat file `shoplist_page.dart` untuk menampilkan semua item yang telah ditambahkan melalui form
~~~
import 'package:flutter/material.dart';
import 'package:united_squad/models/item.dart';

class ProductListPage extends StatelessWidget {
  final List<Item> items;

  const ProductListPage({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Item'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(items[index].name),
              subtitle: Text(
                  'Harga: ${items[index].price}\nDeskripsi: ${items[index].description}'),
            ),
          );
        },
      ),
    );
  }
}
~~~

Membuat tombol pada drawer untuk mengarahkan ke `shoplist_page.dart`
~~~
ListTile(
            leading: const Icon(Icons.shopping_bag_rounded),
            title: const Text('Lihat Produk'),
            // Bagian redirection ke ShopFormPage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductListPage(items: itemList),
                  ));
            },
          ),
~~~

Mengarahkan ke `shoplist_page.dart` jika menekan tombol "Lihat Produk" pada halaman utama
~~~
if (item.name == "Lihat Item") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProductListPage(items: itemList)));
          }
~~~