import 'package:flutter/material.dart';
import '../../components/controls/ListingState.dart';

class Appointments extends StatefulWidget {

  Appointments();

  var list = ['name','start','place']; 
   @override
  _AppointmentsState<Appointments> createState() => new _AppointmentsState<Appointments>('APPOINTMENTS', 'appointments', list);


}

class _AppointmentsState<T extends StatefulWidget>  extends ListingState<T>{

    _AppointmentsState(String title, String table, List columns): super.more(title, table, columns) ;
    
}
