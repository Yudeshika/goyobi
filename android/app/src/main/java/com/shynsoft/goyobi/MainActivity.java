package com.shynsoft.goyobi;

import android.os.Bundle;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.util.Log;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import android.content.Intent;
import android.widget.Toast;

public class MainActivity extends FlutterActivity {

    public static final String TAG = "goyobi";
    public static final String STREAM = "com.shynsoft.goyobi/stream";
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
            }

            @Override
            public void onCancel(Object args) {
                Log.w(TAG, "cancelling listener");

            }
        });
    }

}
