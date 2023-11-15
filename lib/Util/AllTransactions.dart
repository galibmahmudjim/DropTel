import 'package:droptel/Obj/Statement.dart';

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
