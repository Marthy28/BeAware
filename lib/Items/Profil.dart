class Profil {
  String firstName, lastName;

  Profil.fromProfilData(Map<String, dynamic> data) {
    this.firstName = data['firstName'];
    this.lastName = data['lastName'];
  }
}
