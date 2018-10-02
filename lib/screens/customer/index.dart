import 'package:flutter/material.dart';
import '../../components/controls/ListingState.dart';

class Customers extends StatefulWidget {

  Customers();

  var list = ['name','nic']; 
   @override
  _CustomersState<Customers> createState() => new _CustomersState<Customers>('CUSTOMERS', 'customers', list);


}

class _CustomersState<T extends StatefulWidget>  extends ListingState<T>{

    _CustomersState(String title, String table, List columns): super.more(title, table, columns) ;
    
}

