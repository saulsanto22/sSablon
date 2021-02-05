import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sablon/view/login_page.dart';
import 'package:sablon/view/pesan.dart';
import 'package:sablon/model/register_user.dart';
import 'package:sablon/services/firebase_auth_services.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  RegisterUser registerUser;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var registerData =
    //     ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    // registerUser = registerData['register_user'];
    CollectionReference produksablon =
        FirebaseFirestore.instance.collection('produk');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text(
          "Selamat Datang",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.lightBlue[100],
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            // UserAccountsDrawerHeader(
            //   // accountName: new Text(),
            //   // accountEmail: new Text('${registerUser.email}'),
            //   decoration: new BoxDecoration(color: Colors.blueAccent[700]),
            // ),
            ListTile(
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PesanScreen()));
              },
              title: Text("Pesan"),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Keluar"),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
          stream: produksablon.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text('"Loading...');
            }
            int length = snapshot.data.docs.length;
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //two columns
                  mainAxisSpacing: 0.1, //space the card
                  childAspectRatio: 0.800, //space largo de cada card
                ),
                itemCount: length,
                padding: EdgeInsets.all(2.0),
                itemBuilder: (_, int index) {
                  final DocumentSnapshot docs = snapshot.data.docs[index];

                  return new Container(
                      child: Card(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PesanScreen()));
                              },
                              child: new Container(
                                child: Image.network(docs.data()['gambar']),
                                width: 170,
                                height: 120,
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              docs.data()["nama"],
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 19.0,
                              ),
                            ),
                            subtitle: Text(
                              docs.data()["deskripsi"],
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 12.0),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PesanScreen()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ));
                });
          }),
    );
  }
}
