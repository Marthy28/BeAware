class Profil {
  String firstName, lastName;

  Profil.fromProfilData(Map<String, dynamic> data) {
    if (data == null) return;
    this.firstName = data['firstName'];
    this.lastName = data['lastName'];
  }
}
