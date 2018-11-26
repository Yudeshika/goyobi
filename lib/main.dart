import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './screens/guide.dart' as _guidePage;
import './screens/about.dart' as _aboutPage;
import './screens/profile.dart' as _profilePage;
import './screens/support.dart' as _supportPage;
import './screens/settings.dart' as _settingsPage;

import './screens/user/login.dart' as _loginPage;
import './screens/user/register.dart' as _registerPage;
import './screens/todo/index.dart' as _todosPage;
import './screens/todo/create.dart' as _todoCreatePage;
import './screens/customer/create.dart' as _customerCreatePage;
import './screens/customer/index.dart' as _customerListPage;
import './screens/policy/index.dart' as _policyListPage;
import './screens/policy/life/create.dart' as _policyLifeCreatePage;
import './screens/policy/motor/create.dart' as _policyMotorCreatePage;
import './screens/policy/fire/create.dart' as _policyFireCreatePage;
import './screens/policy/title/create.dart' as _policyTitleCreatePage;
import './screens/policy/medical/create.dart' as _policyMedicalCreatePage;
import './screens/policy/dta/create.dart' as _policyDtaCreatePage;
import './screens/appointment/create.dart' as _appointmentCreatePage;
import './screens/appointment/index.dart' as _appointmentListPage;
import './screens/payment/index.dart' as _paymentListPage;
import './screens/claim/index.dart' as _claimsPage;


import './screens/tools/calc.dart' as _calcPage;
import './screens/tools/bmi.dart' as _bmiPage;
import './components/IM.dart';
import './screens/user/auth.dart';
import './screens/user/route.dart';

void main() => runApp(new MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Goyobi',
  theme: new ThemeData(
    primarySwatch: Colors.cyan,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.cyan, backgroundColor: Colors.white
  ),
  home: new RoutePage(auth: new Auth()),
  onGenerateRoute: (RouteSettings settings) {
    switch (settings.name) {
      case '/login': return new FromRightToLeft(
        builder: (_) => new _loginPage.Login(auth: new Auth()),
        settings: settings,
      );
      case '/register': return new FromRightToLeft(
        builder: (_) => new _registerPage.Register(auth: new Auth()),
        settings: settings,
      );
      case '/about': return new FromRightToLeft(
        builder: (_) => new _aboutPage.About(),
        settings: settings,
      );
      case '/profile': return new FromRightToLeft(
        builder: (_) => new _profilePage.Profile(),
        settings: settings,
      );
      case '/guide': return new FromRightToLeft(
        builder: (_) => new _guidePage.Guide(),
        settings: settings,
      );
      case '/support': return new FromRightToLeft(
        builder: (_) => new _supportPage.Support(),
        settings: settings,
      );
      case '/settings': return new FromRightToLeft(
        builder: (_) => new _settingsPage.Settings(),
        settings: settings,
      );
      case '/todos': return new FromRightToLeft(
        builder: (_) => new _todosPage.ToDos(),
        settings: settings,
      );

      case '/todocreate': return new FromRightToLeft(
        builder: (_) => new _todoCreatePage.TodoCreate(),
        settings: settings,
      );

      
      
      case '/customers': return new FromRightToLeft(
        builder: (_) => new _customerListPage.Customers(auth: new Auth()),
        settings: settings,
      );
      case '/customercreate': return new FromRightToLeft(
        builder: (_) => new _customerCreatePage.CustomerCreate(),
        settings: settings,
      );
      
      case '/appointments': return new FromRightToLeft(
        builder: (_) => new _appointmentListPage.Appointments(),
        settings: settings,
      );
      case '/appointmentcreate': return new FromRightToLeft(
        builder: (_) => new _appointmentCreatePage.AppointmentCreate(),
        settings: settings,
      );

      //Tools
      case '/calc': return new FromRightToLeft(
        builder: (_) => new _calcPage.Calc(),
        settings: settings,
      );
      case '/bmi': return new FromRightToLeft(
        builder: (_) => new _bmiPage.BMI(),
        settings: settings,
      );

      case '/policies': return new FromRightToLeft(
        builder: (_) => new _policyListPage.Policies(auth: new Auth()),
        settings: settings,
      );

      case '/policylifecreate': return new FromRightToLeft(
        builder: (_) => new _policyLifeCreatePage.LifeCreate(),
        settings: settings,
      );

      case '/policymotorcreate': return new FromRightToLeft(
        builder: (_) => new _policyMotorCreatePage.MotorCreate(),
        settings: settings,
      );
      case '/policyfirecreate': return new FromRightToLeft(
        builder: (_) => new _policyFireCreatePage.FireCreate(),
        settings: settings,
      );
      case '/policydtacreate': return new FromRightToLeft(
        builder: (_) => new _policyDtaCreatePage.DtaCreate(),
        settings: settings,
      );
      case '/policytitlecreate': return new FromRightToLeft(
        builder: (_) => new _policyTitleCreatePage.TitleCreate(),
        settings: settings,
      );

      case '/policymedicalcreate': return new FromRightToLeft(
        builder: (_) => new _policyMedicalCreatePage.MedicalCreate(),
        settings: settings,
      );

      case '/payments': return new FromRightToLeft(
        builder: (_) => new _paymentListPage.Payments(auth: new Auth()),
        settings: settings,
      );

      case '/claims': return new FromRightToLeft(
        builder: (_) => new _claimsPage.Claims(auth: new Auth()),
        settings: settings,
      );
    }
  },
  // routes: <String, WidgetBuilder> {
  //   '/about': (BuildContext context) => new _aboutPage.About(),
  // }
));

class FromRightToLeft<T> extends MaterialPageRoute<T> {
  FromRightToLeft({ WidgetBuilder builder, RouteSettings settings })
    : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {

    if (settings.isInitialRoute)
      return child;

    return new SlideTransition(
      child: new Container(
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black26,
              blurRadius: 25.0,
            )
          ]
        ),
        child: child,
      ),
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      )
      .animate(
        new CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        )
      ),
    );
  }
  @override Duration get transitionDuration => const Duration(milliseconds: 400);
}