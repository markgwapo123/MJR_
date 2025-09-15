class TokenStorage {
  static String? _token;
  static Map<String, dynamic>? _userInfo;

  // Store token after login
  static void saveToken(String token, Map<String, dynamic> userInfo) {
    _token = token;
    _userInfo = userInfo;
  }

  // Get stored token
  static String? getToken() {
    return _token;
  }

  // Get user info
  static Map<String, dynamic>? getUserInfo() {
    return _userInfo;
  }

  // Check if user is logged in
  static bool isLoggedIn() {
    return _token != null;
  }

  // Clear token (logout)
  static void clearToken() {
    _token = null;
    _userInfo = null;
  }

  // Get user ID from stored user info
  static String? getUserId() {
    return _userInfo?['id'];
  }

  // Get user email from stored user info
  static String? getUserEmail() {
    return _userInfo?['email'];
  }
}
