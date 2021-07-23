import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_page.dart';

class AbsenCard extends StatelessWidget {
  final String name, absenmasuk, absenpulang;
  final int id;

  AbsenCard(this.name, this.id, this.absenmasuk, this.absenpulang);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 70.0),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Center(
                    child: Text(name,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 16)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                  child: Text(
                    "ID Pekerja $id",
                    style: GoogleFonts.poppins(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                  child: Text('Masuk : ' '$absenmasuk'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                  child: Text("Pulang : $absenpulang"),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
