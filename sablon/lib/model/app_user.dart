class AppUser {
  String id;
  String email;
  String username;
  String profilePicture;

  AppUser({this.id, this.email, this.username, this.profilePicture});

  AppUser copyWith(String username, String profilePicture) {
    return AppUser(
      id: this.id,
      email: this.email,
      username: username ?? this.username,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}
