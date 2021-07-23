import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_page.dart';

class ItemCard extends StatelessWidget {
  final String name;
  final int id;

  final Function tampil;
  final Function absenMasuk;
  final Function absenPulang;

  ItemCard(this.name, this.id,
      {this.tampil, this.absenMasuk, this.absenPulang});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Center(
                    child: Text(name,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, fontSize: 16)),
                  ),
                ),
                Text(
                  "ID Pekerja $id",
                  style: GoogleFonts.poppins(),
                )
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(
                height: 40,
                width: 55,
                child: RaisedButton(
                    shape: CircleBorder(),
                    color: Colors.green[900],
                    child: Center(
                      child: Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (tampil != null) tampil();
                    }),
              ),
              SizedBox(
                height: 40,
                width: 55,
                child: RaisedButton(
                    shape: CircleBorder(),
                    color: Colors.green[900],
                    child: Center(
                        child: Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    )),
                    onPressed: () {
                      if (absenMasuk != null) absenMasuk();
                    }),
              ),
              SizedBox(
                height: 40,
                width: 55,
                child: RaisedButton(
                    shape: CircleBorder(),
                    color: Colors.red[900],
                    child: Center(
                        child: Icon(
                      Icons.arrow_downward_rounded,
                      color: Colors.white,
                    )),
                    onPressed: () {
                      if (absenPulang != null) absenPulang();
                    }),
              )
            ],
          )
        ],
      ),
    );
  }
}
