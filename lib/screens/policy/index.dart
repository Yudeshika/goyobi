import 'package:flutter/material.dart';
import '../../components/controls/ListingState.dart';

import '../user/auth.dart';

class Policies extends StatefulWidget {

  final BaseAuth auth;

  Policies({this.auth});

  var list = ['name','policyname','commenceddate']; 
   @override
  _CustomersState<Policies> createState() => new _CustomersState<Policies>('POLICIES', 'policies', list);


}

class _CustomersState<T extends StatefulWidget>  extends ListingState<T>{

    _CustomersState(String title, String table, List columns): super.more(title, table, columns) ;
    
}

