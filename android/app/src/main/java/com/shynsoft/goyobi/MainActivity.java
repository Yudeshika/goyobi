package com.shynsoft.goyobi;

import android.os.Bundle;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.util.Log;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import android.content.Intent;
import android.widget.Toast;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import 	android.content.ComponentName;



public class MainActivity extends FlutterActivity {

    public static final String TAG = "goyobi";
    public static final String STREAM = "com.shynsoft.goyobi/stream";
    public static final String STREAM2 = "com.shynsoft.goyobi/stream2";
    public static final String STREAM3 = "com.shynsoft.goyobi/stream3";
    public static String num1 = "";

    public String getNumber(){
        return num1;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        

    }

    @Override
    protected void onResume() {
        super.onResume();
        Intent intent = getIntent();
        Bundle extras = intent.getExtras();
        final String number;

        if (extras != null) {
            String numberNew = extras.getString("number");
            
            if(numberNew==null){
                number = intent.getStringExtra("number");
                //Toast.makeText(this, "Call from t1 1 "+number,Toast.LENGTH_LONG).show();
            }else{
                number = numberNew;
                //Toast.makeText(this, "Call from t1 2 "+number, Toast.LENGTH_LONG).show();
   
            }

            num1 = number;
            // and get whatever type user account id is
            
        }else{
            number = "-";
            Toast.makeText(this, "Number Not set ",
   Toast.LENGTH_LONG).show();
        }
        // final String number = intent.getStringExtra("number");
       // System.out.println("Number=" + number);

       

        final String num = number;
        new EventChannel(getFlutterView(), STREAM).setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object args, EventChannel.EventSink events) {
                Log.w(TAG, "adding listener");
                events.success(num);
                // IntentFilter mainFilter = new IntentFilter();
                
                // registerReceiver(receiver, mainFilter);
                Log.w(TAG, "added listener");
            }

            @Override
            public void onCancel(Object args) {
                Log.w(TAG, "cancelling listener");
                // unregisterReceiver(receiver); 
                Log.w(TAG, "cancelled listener"); 
            }
        });

        
        new EventChannel(getFlutterView(), STREAM2).setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object args, EventChannel.EventSink events) {
                // IncomingCall receiver = new IncomingCall();
                // IntentFilter mainFilter = new IntentFilter();
                // mainFilter.addAction("android.intent.action.PHONE_STATE");
                // registerReceiver(receiver, mainFilter);
                PackageManager pm  = MainActivity.this.getPackageManager();
                ComponentName componentName = new ComponentName(MainActivity.this, IncomingCall.class);
                pm.setComponentEnabledSetting(componentName,PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
                        PackageManager.DONT_KILL_APP);
                Toast.makeText(getApplicationContext(), "activated", Toast.LENGTH_LONG).show();
                Log.w(TAG, "REC 2 = added listener");
            }

            @Override
            public void onCancel(Object args) { 
                // IncomingCall receiver = new IncomingCall();
                // unregisterReceiver(receiver); 
                Log.w(TAG, "REC2 = cancelling listener"); 
                
            }
        });

        new EventChannel(getFlutterView(), STREAM3).setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object args, EventChannel.EventSink events) {
                // IncomingCall receiver = new IncomingCall();
                // IntentFilter mainFilter = new IntentFilter();
                // mainFilter.addAction("android.intent.action.PHONE_STATE");
                // registerReceiver(receiver, mainFilter);
                PackageManager pm  = MainActivity.this.getPackageManager();
                Log.w(TAG, "REC2 = cancelling listener2");
                ComponentName componentName = new ComponentName(MainActivity.this, IncomingCall.class);
                Log.w(TAG, "REC2 = cancelling listener3");
                pm.setComponentEnabledSetting(componentName,PackageManager.COMPONENT_ENABLED_STATE_DISABLED,
                        PackageManager.DONT_KILL_APP);
                Log.w(TAG, "REC2 = cancelling listener4");
                Toast.makeText(getApplicationContext(), "cancelled", Toast.LENGTH_LONG).show();
                Log.w(TAG, "REC2 = cancelled listener"); 
            }

            @Override
            public void onCancel(Object args) { 
                // IncomingCall receiver = new IncomingCall();
                // unregisterReceiver(receiver); 
                Log.w(TAG, "REC2 = cancelling listener"); 
               
            }
        });
    }

}
