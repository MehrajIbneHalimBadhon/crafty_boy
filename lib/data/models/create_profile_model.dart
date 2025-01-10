class CreateProfileModel {
  final String cusName;
  final String cusAdd;
  final String cusCity;
  final String cusState;
  final String cusPostcode;
  final String cusCountry;
  final String cusPhone;
  final String cusFax;
  final String shipName;
  final String shipAdd;
  final String shipCity;
  final String shipState;
  final String shipPostcode;
  final String shipCountry;
  final String shipPhone;

  CreateProfileModel(
      {required this.cusName,
      required this.cusAdd,
      required this.cusCity,
      required this.cusState,
      required this.cusPostcode,
      required this.cusCountry,
      required this.cusPhone,
      required this.cusFax,
      required this.shipName,
      required this.shipAdd,
      required this.shipCity,
      required this.shipState,
      required this.shipPostcode,
      required this.shipCountry,
      required this.shipPhone});
}
