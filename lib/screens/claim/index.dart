import 'package:flutter/material.dart';
import '../../components/controls/ListingState.dart';

import '../user/auth.dart';

class Claims extends StatefulWidget {

  final BaseAuth auth;

  Claims({this.auth});

  var list = ['policy_no','remark']; 
   @override
  _ClaimsState<Claims> createState() => new _ClaimsState<Claims>('CLAIMS', 'claims', list);


}

class _ClaimsState<T extends StatefulWidget>  extends ListingState<T>{

    _ClaimsState(String title, String table, List columns): super.more(title, table, columns) ;
    
}

