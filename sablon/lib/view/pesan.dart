import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PesanScreen extends StatefulWidget {
  @override
  _PesanScreenState createState() => _PesanScreenState();
}

class _PesanScreenState extends State<PesanScreen> {
  final _formKey = GlobalKey<FormState>();
  int harga1 = 10000;
  int harga2 = 10000;
  int harga3 = 10000;
  int harga4 = 10000;
  int harga5 = 10000;
  int harga6 = 10000;
  int harga7 = 10000;
  int harga8 = 10000;
  int harga9 = 10000;
  int harga10 = 10000;

  TextEditingController nama = new TextEditingController();
  TextEditingController warna = new TextEditingController();
  TextEditingController bahan = new TextEditingController();
  TextEditingController jml = new TextEditingController();
  TextEditingController ukuran = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference sablon = firestore.collection('sablon');
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesan"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: nama,
                decoration: InputDecoration(
                    labelText: "Nama",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: warna,
                decoration: InputDecoration(
                    labelText: "Masukan Warna",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: bahan,
                decoration: InputDecoration(
                    labelText: "Bahan",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: jml,
                decoration: InputDecoration(
                    labelText: "Jumlah ",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                controller: ukuran,
                decoration: InputDecoration(
                    labelText: "Ukuran ",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Text("Pesan"),
                  textColor: Colors.white,
                  onPressed: () {
                    sablon.add({}).then((value) => print(" Added")).catchError(
                        (error) => print("Failed to add user: $error"));
                    nama.text = "";
                    warna.text = "";
                    bahan.text = "";
                    jml.text = "";
                    ukuran.text = "";
                    ShowToast("ORDER BERHASIL");
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
          ],
        ),
      ),
    );
  }

  ShowToast(text) {
    Fluttertoast.showToast(
        msg: "",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
