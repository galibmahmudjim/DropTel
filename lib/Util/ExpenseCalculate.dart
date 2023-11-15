import 'package:droptel/Obj/Activity.dart';

double ActivityExpense(Activity activity) {
  double total = 0;
  activity.statements?.forEach((element) {
    if (element.statementType == "Payment") {
    } else {
      total += element.totalWithMembers!;
    }
  });
  total = double.parse(total.toStringAsFixed(2));
  return total;
}

double ActivityPayment(Activity activity) {
  double total = 0;
  activity.statements?.forEach((element) {
    if (element.statementType == "Payment") {
      total += element.totalWithMembers!;
    } else {}
  });
  total = double.parse(total.toStringAsFixed(2));
  return total;
}

double ActivityDueExpense(Activity activity) {
  double total = 0;
  activity.statements?.forEach((element) {
    if (element.statementType == "Payment") {
      total -= element.totalWithMembers!;
    } else {
      total += element.totalWithMembers!;
    }
  });
  total = double.parse(total.toStringAsFixed(2));
  return total;
}

double ActivityIndividualExpense(Activity activity, int index) {
  double total = 0;
  activity.statements?.forEach((element) {
    if (element.statementType == "Expenditure") {
      if (element.members.any((element) {
        return element?.member?.index == index;
      })) {
        total += element.totalPerPerson!;
      }
    }
  });
  total = double.parse(total.toStringAsFixed(2));
  return total;
}

double ActivityIndividualPayment(Activity activity, int index) {
  double total = 0;
  activity.statements?.forEach((element) {
    if (element.statementType == "Payment") {
      if (element.members.any((element) {
        return element?.member?.index == index;
      })) {
        total += element.totalPerPerson!;
      }
    }
  });
  total = double.parse(total.toStringAsFixed(2));
  return total;
}

double ActivityIndividualDue(Activity activity, int index) {
  double total = 0;
  total = ActivityIndividualExpense(activity, index) -
      ActivityIndividualPayment(activity, index);
  total = double.parse(total.toStringAsFixed(2));
  return total;
}
