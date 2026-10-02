enum FieldType { text, number, date }

/// One input on a vehicle management form
class ManagementField {
  const ManagementField(this.key, this.label, [this.type = FieldType.text]);

  final String key;
  final String label;
  final FieldType type;
}

const _issueDate = ManagementField('issueDate', 'Issue Date', FieldType.date);
const _validDate = ManagementField('validDate', 'Valid Date', FieldType.date);
const _alertDays =
    ManagementField('alertDays', 'Send Alert before days', FieldType.number);

/// Tabs of the Vehicle Management screen and the fields each one edits
enum ManagementSection {
  pollution('Pollution', [
    ManagementField('state', 'State'),
    _issueDate,
    _validDate,
    _alertDays,
  ]),
  insurance('Insurance', [
    ManagementField('companyName', 'Insurance Company Name'),
    ManagementField('price', 'Insurance Price', FieldType.number),
    _issueDate,
    _validDate,
    _alertDays,
  ]),
  fitness('Fitness', [
    ManagementField('certificate', 'Certificate'),
    _issueDate,
    _validDate,
    _alertDays,
  ]),
  permit('Permit', [
    ManagementField('certificate', 'Permit Certificate'),
    _issueDate,
    _validDate,
    _alertDays,
  ]),
  tax('Tax', [
    ManagementField('receipt', 'Tax Receipt Number'),
    ManagementField('amount', 'Tax Amount', FieldType.number),
    _issueDate,
    _validDate,
    _alertDays,
  ]),
  battery('Battery', [
    ManagementField('company', 'Battery Company'),
    ManagementField('model', 'Battery Model'),
    ManagementField('number', 'Battery Number'),
    ManagementField('warrantyMonth', 'Warranty Month', FieldType.number),
    ManagementField('ampere', 'Ampere', FieldType.number),
  ]),
  tyre('Tyre', [
    ManagementField('type', 'Tyre Type'),
    ManagementField('company', 'Tyre Company'),
    ManagementField('number', 'Tyre Number'),
    ManagementField('manufacturerDate', 'manufacturer Date', FieldType.date),
    ManagementField('purchaseDate', 'Purchase Date', FieldType.date),
  ]);

  const ManagementSection(this.label, this.fields);

  final String label;

  /// For [tyre] these are the fields of a single tyre
  final List<ManagementField> fields;
}

/// Saved values of one form plus when they were last saved
class ManagementRecord {
  const ManagementRecord({required this.values, this.lastUpdate});

  final Map<String, String> values;
  final DateTime? lastUpdate;

  static const empty = ManagementRecord(values: {});

  Map<String, dynamic> toJson() => {
        'values': values,
        'lastUpdate': lastUpdate?.toIso8601String(),
      };

  factory ManagementRecord.fromJson(Map<String, dynamic> json) =>
      ManagementRecord(
        values: Map<String, String>.from(json['values'] as Map),
        lastUpdate: json['lastUpdate'] == null
            ? null
            : DateTime.parse(json['lastUpdate'] as String),
      );
}
