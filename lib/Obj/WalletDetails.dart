/// timestamp : "2023-09-26T10:15:00Z"
/// title : "Office supplies"
/// description : "Office supplies"
/// category : "Office"
/// calculation_process : "add"
/// extra_process : "yes"
/// extra_process_details : "Vat"
/// extra_process_value : 12
/// amount : 50.00
/// currency : "USD"

class WalletDetails {
  WalletDetails({
    String? timestamp,
    String? title,
    String? description,
    String? category,
    String? calculationProcess,
    String? extraProcess,
    String? extraProcessDetails,
    num? extraProcessValue,
    num? amount,
    String? currency,
  }) {
    _timestamp = timestamp;
    _title = title;
    _description = description;
    _category = category;
    _calculationProcess = calculationProcess;
    _extraProcess = extraProcess;
    _extraProcessDetails = extraProcessDetails;
    _extraProcessValue = extraProcessValue;
    _amount = amount;
    _currency = currency;
  }

  WalletDetails.fromJson(dynamic json) {
    _timestamp = json['timestamp'];
    _title = json['title'];
    _description = json['description'];
    _category = json['category'];
    _calculationProcess = json['calculation_process'];
    _extraProcess = json['extra_process'];
    _extraProcessDetails = json['extra_process_details'];
    _extraProcessValue = json['extra_process_value'];
    _amount = json['amount'];
    _currency = json['currency'];
  }
  String? _timestamp;
  String? _title;
  String? _description;
  String? _category;
  String? _calculationProcess;
  String? _extraProcess;
  String? _extraProcessDetails;
  num? _extraProcessValue;
  num? _amount;
  String? _currency;
  WalletDetails copyWith({
    String? timestamp,
    String? title,
    String? description,
    String? category,
    String? calculationProcess,
    String? extraProcess,
    String? extraProcessDetails,
    num? extraProcessValue,
    num? amount,
    String? currency,
  }) =>
      WalletDetails(
        timestamp: timestamp ?? _timestamp,
        title: title ?? _title,
        description: description ?? _description,
        category: category ?? _category,
        calculationProcess: calculationProcess ?? _calculationProcess,
        extraProcess: extraProcess ?? _extraProcess,
        extraProcessDetails: extraProcessDetails ?? _extraProcessDetails,
        extraProcessValue: extraProcessValue ?? _extraProcessValue,
        amount: amount ?? _amount,
        currency: currency ?? _currency,
      );
  String? get timestamp => _timestamp;
  String? get title => _title;
  String? get description => _description;
  String? get category => _category;
  String? get calculationProcess => _calculationProcess;
  String? get extraProcess => _extraProcess;
  String? get extraProcessDetails => _extraProcessDetails;
  num? get extraProcessValue => _extraProcessValue;
  num? get amount => _amount;
  String? get currency => _currency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['timestamp'] = _timestamp;
    map['title'] = _title;
    map['description'] = _description;
    map['category'] = _category;
    map['calculation_process'] = _calculationProcess;
    map['extra_process'] = _extraProcess;
    map['extra_process_details'] = _extraProcessDetails;
    map['extra_process_value'] = _extraProcessValue;
    map['amount'] = _amount;
    map['currency'] = _currency;
    return map;
  }
}
