import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absen/item_card.dart';
import 'package:flutter_absen/liatdata.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

final TextEditingController nameController = TextEditingController();
final TextEditingController idController = TextEditingController();

var currentPage = DrawerSection.home;

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference workers = firestore.collection('worker');
    CollectionReference absen = firestore.collection('absen');
    var now = DateTime.now();

    masuk() {
      Map<String, dynamic> worker = {
        "absen_masuk": DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
      };
    }

    int a = 0;
    int b = a;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        title: Text('Absesi'),
        centerTitle: true,
      ),
      backgroundColor: Colors.cyanAccent[100],
      body: Stack(
        children: [
          ListView(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: workers.snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data.docs
                            .map((e) => ItemCard(
                                  e.data()['name'],
                                  e.data()['id'],
                                  tampil: () {
                                    nameController.text = e.data()['name'];
                                    idController.text =
                                        e.data()['id'].toString();
                                  },
                                  absenMasuk: () {
                                    absen
                                        .doc(DateFormat('yyyy')
                                            .format(DateTime.now()))
                                        .collection(DateFormat('MMM')
                                            .format(DateTime.now()))
                                        .doc(nameController.text)
                                        .set({
                                      'name': nameController.text,
                                      'id':
                                          int.tryParse(idController.text) ?? 0,
                                      'absen_masuk':
                                          DateFormat('dd MMM yyyy – kk:mm')
                                              .format(DateTime.now()),
                                      'absen_pulang': null
                                    });
                                  },
                                  absenPulang: () {
                                    absen
                                        .doc(DateFormat('yyyy')
                                            .format(DateTime.now()))
                                        .collection(DateFormat('MMM')
                                            .format(DateTime.now()))
                                        .doc(nameController.text)
                                        .update({
                                      'absen_pulang': DateFormat('kk:mm')
                                          .format(DateTime.now())
                                    });
                                    a++;
                                  },
                                ))
                            .toList(),
                      );
                    } else {
                      return Text('Loading');
                    }
                  }),
              SizedBox(
                height: 150,
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(-5, 0),
                    blurRadius: 15,
                    spreadRadius: 3)
              ]),
              width: double.infinity,
              height: 130,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 160,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          style: GoogleFonts.poppins(),
                          controller: idController,
                          decoration: InputDecoration(
                              labelText: "ID",
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0))),
                          keyboardType: TextInputType.number,
                        ),
                        TextFormField(
                          style: GoogleFonts.poppins(),
                          controller: nameController,
                          decoration: InputDecoration(
                              labelText: "Name",
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0))),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 130,
                    width: 130,
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: Colors.blue[900],
                        child: Text(
                          'Add Data',
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          workers.add({
                            'name': nameController.text,
                            'id': int.tryParse(idController.text) ?? 0
                          });

                          nameController.text = '';
                          idController.text = '';
                        }),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  color: Colors.amber,
                  height: 70,
                  padding: EdgeInsets.only(top: 20.0),
                ),
                DrawerList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget DrawerList() {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(1, "Home", Icons.home_outlined,
              currentPage == DrawerSection.home ? true : false),
          menuItem(2, "Laporan", Icons.dashboard_outlined,
              currentPage == DrawerSection.laporan ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSection.home;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return MainPage();
                }),
              );
            } else if (id == 2) {
              currentPage = DrawerSection.laporan;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TampilData()),
              );
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 25,
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Text(
                    title,
                    style: GoogleFonts.comicNeue(fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSection {
  home,
  laporan,
}
