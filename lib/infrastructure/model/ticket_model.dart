
class Ticket {
  final int? id;
  final String? title;
  final String? description;
  final String? moduleName;
  final String? subModuleName;
  final String? type;
  final String? priority;
  final String? assignedTo;
  final String? developerRemarks;
  final DateTime? reportDt;
  final DateTime? dueDt;
  final DateTime? completionDt;
  final DateTime? entryDt;
  final DateTime? targetCompletionDt;
  final DateTime? modifiedDt;
  final String? enteredBy;
  final String? requestedBy;
  final String? modifiedBy;
  final String? defaultSchema;
  final String? status;
  final String? category;
  final dynamic documents;
  final bool? isBusy;
  final bool? isSelfBusy;

  Ticket({
    this.id,
    this.title,
    this.description,
    this.moduleName,
    this.subModuleName,
    this.type,
    this.priority,
    this.assignedTo,
    this.developerRemarks,
    this.reportDt,
    this.dueDt,
    this.completionDt,
    this.entryDt,
    this.targetCompletionDt,
    this.modifiedDt,
    this.enteredBy,
    this.requestedBy,
    this.modifiedBy,
    this.defaultSchema,
    this.status,
    this.category,
    this.documents,
    this.isBusy,
    this.isSelfBusy,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    moduleName: json["module_Name"],
    subModuleName: json["subModule_Name"],
    type: json["type"],
    priority: json["priority"],
    assignedTo: json["assigned_To"],
    developerRemarks: json["developer_Remarks"],
    reportDt: json["report_Dt"] == null
        ? null
        : DateTime.parse(json["report_Dt"]),
    dueDt: json["due_Dt"] == null ? null : DateTime.parse(json["due_Dt"]),
    completionDt: json["completion_Dt"] == null
        ? null
        : DateTime.parse(json["completion_Dt"]),
    entryDt:
    json["entry_Dt"] == null ? null : DateTime.parse(json["entry_Dt"]),
    targetCompletionDt: json["target_Completion_Dt"] == null
        ? null
        : DateTime.parse(json["target_Completion_Dt"]),
    modifiedDt: json["modified_Dt"] == null
        ? null
        : DateTime.parse(json["modified_Dt"]),
    enteredBy: json["entered_By"],
    requestedBy: json["requested_By"],
    modifiedBy: json["modified_By"],
    defaultSchema: json["default_Schema"],
    status: json["status"],
    category: json["category"],
    documents: json["documents"],
    isBusy: json["isBusy"],
    isSelfBusy: json["isSelfBusy"],
  );

  Map<String, dynamic> toJson() => {
    "id": id ?? 0,
    "title": title,
    "description": description,
    "module_Name": moduleName,
    "subModule_Name": subModuleName,
    "type": type,
    "priority": priority,
    "assigned_To": assignedTo,
    "developer_Remarks": developerRemarks,
    "report_Dt": reportDt?.toIso8601String(),
    "due_Dt": dueDt?.toIso8601String(),
    "completion_Dt": completionDt?.toIso8601String(),
    "entry_Dt": DateTime.now().toIso8601String(),
    "target_Completion_Dt": targetCompletionDt?.toIso8601String(),
    "modified_Dt": modifiedDt?.toIso8601String(),
    "entered_By": enteredBy,
    "requested_By": requestedBy,
    "modified_By": modifiedBy,
    "default_Schema": defaultSchema,
    "status": status,
    "category": category,
    "documents": documents,
  };
}
