class User {
  final int id;
  final String fname;
  final String lname;
  final String email;
  final int role_id;
  final DateTime email_verified_at;
  final String active;
  final String van_status;
  final String invnt_report;
  final String email_verified_sent;
  final DateTime created_at;
  final DateTime updated_at;
  final String phone_num;
  final List<String> companies;
  final String role_name;

  const User({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.role_id,
    required this.email_verified_at,
    required this.active,
    required this.van_status,
    required this.invnt_report,
    required this.email_verified_sent,
    required this.created_at,
    required this.updated_at,
    required this.phone_num,
    required this.companies,
    required this.role_name,
  });
}
