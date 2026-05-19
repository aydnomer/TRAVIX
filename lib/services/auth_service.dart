import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Firebase Auth motoru
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // HATA BURADAYDI: google_sign_in v7 ile artık "instance" kullanmak zorunlu!
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  // 1. EMAIL & ŞİFRE İLE KAYIT OLMA (SIGN UP)
  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print("Kayıt Hatası: ${e.message}");
      return null;
    }
  }

  // 2. EMAIL & ŞİFRE İLE GİRİŞ YAPMA (SIGN IN)
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print("Giriş Hatası: ${e.message}");
      return null;
    }
  }

  // 3. ÇIKIŞ YAPMA (SIGN OUT)
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
