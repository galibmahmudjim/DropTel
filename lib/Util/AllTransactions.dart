import 'package:droptel/Obj/Statement.dart';
import 'package:droptel/Obj/Wallet.dart';

import '../Obj/Activity.dart';

FindAllActivityIndividualTransaction(Activity activity, int index) {
  List<Statement> statements = [];
  activity.statements?.forEach((element) {
    if (element.members.any((element) => element?.member?.index == index)) {
      statements.add(element);
    }
  });
  return statements;
}

FindAllEventIndividualTransaction(Wallet wallet, int index) {
  List<StatementWithParentsTitle> statementWithParentsTitle = [];

  wallet.activityList?.forEach((element) {
    if (element.type == "Statement") {
      if ((element as Statement)
          .members
          .any((element) => element?.member?.index == index)) {
        statementWithParentsTitle
            .add(StatementWithParentsTitle(element, wallet.title!));
      }
    } else {
      (element as Activity).statements?.forEach((e) {
        if (e.members.any((e1) => e1?.member?.index == index)) {
          statementWithParentsTitle
              .add(StatementWithParentsTitle(e, element.title!));
        }
      });
    }
  });
  return statementWithParentsTitle;
}

class StatementWithParentsTitle {
  Statement statement;
  String title;
  StatementWithParentsTitle(this.statement, this.title);
}
