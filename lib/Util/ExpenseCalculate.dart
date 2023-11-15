import 'package:droptel/Obj/Activity.dart';
import 'package:droptel/Obj/Wallet.dart';

import '../Obj/Statement.dart';

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

double EventExpense(Wallet wallet) {
  double total = 0;

  wallet.activityList?.forEach((element) {
    if (element.type == "Statement") {
      if ((element as Statement).statementType == "Expenditure") {
        total += element.totalWithMembers!;
      }
    } else if (element.type == "Activity") {
      total += ActivityExpense(element as Activity);
    }
  });
  total = double.parse(total.toStringAsFixed(2));
  return total;
}

double EventPayment(Wallet wallet) {
  double total = 0;

  wallet.activityList?.forEach((element) {
    if (element.type == "Statement") {
      if ((element as Statement).statementType == "Payment") {
        total += element.totalWithMembers!;
      }
    } else if (element.type == "Activity") {
      total += ActivityPayment(element as Activity);
    }
  });
  total = double.parse(total.toStringAsFixed(2));
  return total;
}

double EventDue(Wallet wallet) {
  double total = 0;
  total = EventExpense(wallet) - EventPayment(wallet);
  total = double.parse(total.toStringAsFixed(2));
  return total;
}

double EventExpenseIndividual(Wallet wallet, int index) {
  double total = 0;

  wallet.activityList?.forEach((element) {
    if (element.type == "Statement") {
      if ((element as Statement).statementType == "Expenditure") {
        if (element.members.any((element) => element?.member?.index == index)) {
          total += element.totalPerPerson!;
        }
      }
    } else if (element.type == "Activity") {
      total += ActivityIndividualExpense(element as Activity, index);
    }
  });
  total = double.parse(total.toStringAsFixed(2));
  return total;
}

double EventPaymentIndividual(Wallet wallet, int index) {
  double total = 0;

  wallet.activityList?.forEach((element) {
    if (element.type == "Statement") {
      if ((element as Statement).statementType == "Payment") {
        if (element.members.any((element) => element?.member?.index == index)) {
          total += element.totalPerPerson!;
        }
      }
    } else if (element.type == "Activity") {
      total += ActivityIndividualPayment(element as Activity, index);
    }
  });
  total = double.parse(total.toStringAsFixed(2));
  return total;
}

double EventDueIndividual(Wallet wallet, int index) {
  double total = 0;
  total = EventExpenseIndividual(wallet, index) -
      EventPaymentIndividual(wallet, index);
  total = double.parse(total.toStringAsFixed(2));
  return total;
}
