class OtpArguments{
  final String? name;
  final String? password;
  final String? phone;
  final String? email;
  final bool isRegisterOtp;

  OtpArguments(this.isRegisterOtp, {this.name, this.password, this.phone, this.email});
}