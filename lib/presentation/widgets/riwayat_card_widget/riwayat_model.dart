class RiwayatModel {
  RiwayatModel(
    this.nominal, {
    this.date = 'unknown',
    this.isConfirmed = false,
  });
  int nominal;
  String date;
  bool isConfirmed;
}
