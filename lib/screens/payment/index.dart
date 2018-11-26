import 'package:flutter/material.dart';
import '../../components/controls/ListingState.dart';

import '../user/auth.dart';

class Payments extends StatefulWidget {

  final BaseAuth auth;

  Payments({this.auth});

  var list = ['name','amount']; 
   @override
  _PaymentsState<Payments> createState() => new _PaymentsState<Payments>('PAYMENTS', 'payments', list);


}

class _PaymentsState<T extends StatefulWidget>  extends ListingState<T>{

    _PaymentsState(String title, String table, List columns): super.more(title, table, columns) ;
    
}

