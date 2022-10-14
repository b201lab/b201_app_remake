class PilihBayarModel {
  PilihBayarModel(this.month, this.year, this.isPayed,
      {this.isSelected = false});
  int month;
  int year;
  bool isPayed;
  bool isSelected;
}

List<PilihBayarModel> modelBayar = [
  PilihBayarModel(1, 2020, true),
  PilihBayarModel(2, 2020, false),
  PilihBayarModel(3, 2020, false),
  PilihBayarModel(4, 2020, false),
  PilihBayarModel(5, 2020, false),
  PilihBayarModel(6, 2020, false),
  PilihBayarModel(7, 2020, false),
  PilihBayarModel(8, 2020, false),
  PilihBayarModel(9, 2020, false),
  PilihBayarModel(10, 2020, false),
  PilihBayarModel(11, 2020, false),
  PilihBayarModel(12, 2020, false),
];
