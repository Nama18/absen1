import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import 'item_card.dart';

class Absen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  CollectionReference workers = FirebaseFirestore.instance.collection('worker');
  CollectionReference absen = FirebaseFirestore.instance.collection('absen');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
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
    );
  }
}
