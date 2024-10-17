abstract class RegExps {
  static final RegExp email = RegExp(r"^([a-zA-Z0-9_.-]+)@([a-zA-Z0-9_.-]+)\.([a-zA-Z]{2,5})$");

  static final RegExp name = RegExp(r"^[a-zA-Z]");

  static final RegExp phoneNumber = RegExp(r"(^[0-9]{6,14}$)");

  // static final RegExp password = RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$");
  static final RegExp password = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()\-_=+{};:,<.>]){1,}.*$");

  static final RegExp url = RegExp(r"^(?:http|https)://[\w\-_]+(?:\.[\w\-_]+)+[\w\-.,@?^=%&:/~\\+#]*$");

  static final RegExp textOnly = RegExp(r"\p{L}", unicode: true);

  static final RegExp alphanumericOnly = RegExp(r"[a-zA-Z0-9]");
}
