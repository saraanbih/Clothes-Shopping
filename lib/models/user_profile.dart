class UserProfile {
  final String uid;
  final String displayName;
  final String email;

  UserProfile({
    required this.uid,
    required this.displayName,
    required this.email,
  });

  factory UserProfile.fromMap(String uid, Map<String, dynamic> data) {
    return UserProfile(
      uid: uid,
      displayName: data['displayName'] as String? ?? '',
      email: data['email'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'email': email,
    };
  }
}
