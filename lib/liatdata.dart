import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absen/absen_card.dart';
import 'package:intl/intl.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference absen = firestore
    .collection('absen')
    .doc(DateFormat('yyyy').format(DateTime.now()))
    .collection(DateFormat('MMM').format(DateTime.now()));

class TampilData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Laporan Data'),
          centerTitle: true,
        ),
        body: Container(
            child: StreamBuilder<QuerySnapshot>(
                stream: absen.snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: snapshot.data.docs
                          .map((e) => AbsenCard(
                                e.data()['name'],
                                e.data()['id'],
                                e.data()['absen_masuk'],
                                e.data()['absen_pulang'],
                              ))
                          .toList(),
                    );
                  }
                })));
  }
}
