class Patterns {
  static const String PATTERN_EMAIL =
      r"^[a-zA-Z0-9\+\.\_\%\-\+]{3,256}@[a-zA-Z0-9\-]{2,64}(\.[a-zA-Z\-]{2,25}){0,64}\.[a-zA-Z\-]{2,25}$";
  static const String PATTERN_USERNAME = r"^([a-zA-Z0-9.\-_]+){3,255}$";
  static const String PATTERN_NAME = r"^([a-zA-Z .\-_]+){3,255}$";
  static const String PATTERN_PASSWORD =
      r"^(?:(?=.*[a-z])(?=.*\W)(?=.*[A-Z])(?=.*\d)).{8,}$";
  static const String PATTERN_NUMBER = r"^-?\d+(\.\d+)?$";
  static const String PATTERN_POSITIVE_NUMBER = r"^\d+(\.\d+)?$";
  static const String PATTERN_FLOAT = r"^-?\d+\.\d+$";
  static const String PATTERN_POSITIVE_FLOAT = r"^\d+\.\d+$";
  static const String PATTERN_CNIC = r"^\d{5}-?\d{7}-?\d$";
  static const String PATTERN_MOBILE = r"^((\+92)|(0092)|(0))-?3\d{2}-?\d{7}$";
  static const String PATTERN_LAND_LINE = r"^0\d{2}-?\d{7}$";
  static const String PATTERN_NTN = r"^\d{7}-?\d$";
  static const String PATTERN_GST =
      r"^[0-9]{2}-?[0-9]{2}-?[0-9]{4}-?[0-9]{3}-?[0-9]{2}$";
  static const String PATTERN_DOUBLE = PATTERN_FLOAT;
  static const String PATTERN_POSITIVE_DOUBLE = PATTERN_POSITIVE_FLOAT;
}

class Validator {
  String _text;
  bool _valid = true;
  String _errorMsg = '';

  bool requiredField = false;
  bool optionalField = false;

  bool checkUsernameField = false;
  bool checkEmailField = false;
  bool checkUsernameEmailField = false;
//	bool checkPasswordField = false;
//	bool checkPositiveNumberField = false;
//	bool checkNegativeNumberField = false;
//	bool checkPositiveFloatField = false;
//	bool checkNegativeFloatField = false;
  int minLengthField = 0;
  bool checkMinLengthField = false;
  int maxLengthField = 500;
  bool checkMaxLengthField = false;

  Validator();

  Validator validate(String text) {
    this._text = text;
    return this;
  }

  Validator required() {
    if (this._text.isEmpty) {
      this._valid = false;
      this._errorMsg += "Required! \n";
    }
    return this;
  }

  Validator optional() {
    optionalField = true;
    return this;
  }

  Validator minLength(int min, {String error}) {
    if (_isOptional()) return this;
    var v = this._text.length < min;
    if (v) {
      this._valid = false;
      if (error == null) {
        _errorMsg += "Required min length is $min \n";
      } else {
        _errorMsg += "$error  \n";
      }
    }
    return this;
  }

  Validator maxLength(int max, {String error}) {
    var v = this._text.length > max;
    if (v) {
      this._valid = false;
      if (error == null) {
        _errorMsg += "Allow max length is $max \n";
      } else {
        _errorMsg += "$error  \n";
      }
    }
    return this;
  }

  Validator username({String error}) {
    if (_isOptional()) return this;
    RegExp regExp = new RegExp(Patterns.PATTERN_USERNAME);
    var v = regExp.hasMatch(this._text);
    if (!v) {
      this._valid = v;
      if (error == null) {
        _errorMsg += "Invalid username \n";
      } else {
        _errorMsg += "$error  \n";
      }
    }
    return this;
  }

  Validator email({String error}) {
    if (_isOptional()) return this;
    RegExp regExp = new RegExp(Patterns.PATTERN_EMAIL);
    var v = regExp.hasMatch(this._text);
    if (!v) {
      this._valid = v;
      if (error == null) {
        _errorMsg += "Invalid email \n";
      } else {
        _errorMsg += "$error  \n";
      }
    }
    return this;
  }

  Validator usernameOrEmail({String error}) {
    if (_isOptional()) return this;

    RegExp regExp = new RegExp(Patterns.PATTERN_EMAIL);
    var v = regExp.hasMatch(this._text);

    RegExp regExp2 = new RegExp(Patterns.PATTERN_USERNAME);
    var v2 = regExp2.hasMatch(this._text);

    if (!(v || v2)) {
      this._valid = v;
      if (error == null) {
        _errorMsg += "Invalid username/email \n";
      } else {
        _errorMsg += "$error  \n";
      }
    }
    return this;
  }

  Validator number({bool negative = false, String error}) {
    bool v = Validator.isValidNumber(_text, negative: negative);
    if (!v) {
      this._valid = v;
      if (error == null) {
        _errorMsg += "Invalid number \n";
      } else {
        _errorMsg += "$error  \n";
      }
    }
    return this;
  }

  Validator float({bool negative = false, String error}) {
    bool v = Validator.isValidFloat(_text, negative: negative);
    if (!v) {
      this._valid = v;
      if (error == null) {
        _errorMsg += "Invalid decimal number \n";
      } else {
        _errorMsg += "$error  \n";
      }
    }
    return this;
  }

  Validator double({bool negative = false, String error}) {
    bool v = Validator.isValidFloat(_text, negative: negative);
    if (!v) {
      this._valid = v;
      if (error == null) {
        _errorMsg += "Invalid decimal number \n";
      } else {
        _errorMsg += "$error  \n";
      }
    }
    return this;
  }

  bool _isOptional() => optionalField && this._text.isEmpty;

  bool isValid() => this._valid;

  String getErrorMessage() => this._errorMsg.substring(
      0, (this._errorMsg.length - 3) < 0 ? 0 : this._errorMsg.length - 2);

  /*
	* ********************************************************************************************************************
	* With validator
	* ********************************************************************************************************************
	*/

  Validator withValidator(Validator validator) {
    if (validator.requiredField) this.required();
    if (validator.optionalField) this.optional();
    if (validator.checkUsernameField) this.username();
    if (validator.checkEmailField) this.email();
    if (validator.checkUsernameEmailField) this.usernameOrEmail();
    if (validator.checkMinLengthField) this.minLength(validator.minLengthField);
    if (validator.checkMaxLengthField) this.maxLength(validator.maxLengthField);

    return this;
  }

  Validator checkRequired() {
    requiredField = true;
    return this;
  }

  Validator checkMinLength(int minLength) {
    minLengthField = minLength;
    checkMinLengthField = true;
    return this;
  }

  Validator checkMaxLength(int maxLength) {
    maxLengthField = maxLength;
    checkMaxLengthField = true;
    return this;
  }

  Validator checkUsername() {
    checkUsernameField = true;
    return this;
  }

  Validator checkEmail() {
    checkEmailField = true;
    return this;
  }

  Validator checkUsernameOrEmail() {
    checkUsernameEmailField = true;
    return this;
  }

  /*
	* ********************************************************************************************************************
	* Static functions
	* ********************************************************************************************************************
	*/

  static bool isValidUsername(String text) {
    RegExp regExp = new RegExp(Patterns.PATTERN_USERNAME);
    return regExp.hasMatch(text);
  }

  static bool isValidEmail(String text) {
    RegExp regExp = new RegExp(Patterns.PATTERN_EMAIL);
    return regExp.hasMatch(text);
  }

  static bool isValidUsernameOrEmail(String text) {
    return isValidUsername(text) || isValidEmail(text);
  }

  static bool isValidPassword(String text) {
    RegExp regExp = new RegExp(Patterns.PATTERN_PASSWORD);
    return regExp.hasMatch(text);
  }

  static bool isValidNumber(String text, {bool negative = false}) {
    RegExp regExp = new RegExp(
        negative ? Patterns.PATTERN_NUMBER : Patterns.PATTERN_POSITIVE_NUMBER);
    return regExp.hasMatch(text);
  }

  static bool isValidFloat(String text, {bool negative = false}) {
    RegExp regExp = new RegExp(
        negative ? Patterns.PATTERN_FLOAT : Patterns.PATTERN_POSITIVE_FLOAT);
    return regExp.hasMatch(text);
  }

  static bool isValidDouble(String text, {bool negative = false}) {
    return isValidFloat(text, negative: negative);
  }

  static bool isValidCnic(String text) {
    RegExp regExp = new RegExp(Patterns.PATTERN_CNIC);
    return regExp.hasMatch(text);
  }

  static bool isValidMobile(String text) {
    RegExp regExp = new RegExp(Patterns.PATTERN_MOBILE);
    return regExp.hasMatch(text);
  }

  static bool isValidLandLine(String text) {
    RegExp regExp = new RegExp(Patterns.PATTERN_LAND_LINE);
    return regExp.hasMatch(text);
  }

  static bool isValidNTN(String text) {
    RegExp regExp = new RegExp(Patterns.PATTERN_NTN);
    return regExp.hasMatch(text);
  }

  static bool isValidGST(String text) {
    RegExp regExp = new RegExp(Patterns.PATTERN_GST);
    return regExp.hasMatch(text);
  }
}
