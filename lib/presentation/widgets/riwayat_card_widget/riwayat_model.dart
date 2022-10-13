class RiwayatModel {
  int nominal;
  String date;
  bool isConfirmed;

  RiwayatModel(
    this.nominal, {
    this.date = 'unknown',
    this.isConfirmed = false,
  });
}
