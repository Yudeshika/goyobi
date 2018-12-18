package com.shynsoft.goyobi;


import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.NotificationCompat;
import android.telephony.PhoneStateListener;
import android.telephony.TelephonyManager;
import android.util.Log;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.ListView;
import android.content.pm.PackageManager;

public class IncomingCall extends BroadcastReceiver {

    public void onReceive(Context context, Intent intent) {

        try {
            // TELEPHONY MANAGER class object to register one listner
            TelephonyManager tmgr = (TelephonyManager) context
                    .getSystemService(Context.TELEPHONY_SERVICE);

            //Create Listner
            IncomingCall.MyPhoneStateListener PhoneListener = new IncomingCall.MyPhoneStateListener(context);

            // Register listener for LISTEN_CALL_STATE
            tmgr.listen(PhoneListener, PhoneStateListener.LISTEN_CALL_STATE);

        } catch (Exception e) {
            Log.e("Phone Receive Error", " " + e);
        }

    }

    private class MyPhoneStateListener extends PhoneStateListener {

        Context context;
        public MyPhoneStateListener(Context context){
            this.context = context;
        }


        public void onCallStateChanged(int state, String incomingNumber) {

            Log.d("MyPhoneListener",state+"   incoming no:"+incomingNumber);

            if (state == 1) {

                String msg = "Incomming Number : "+incomingNumber;
               
                PackageManager pm = context.getPackageManager();
                Intent launchIntent = pm.getLaunchIntentForPackage("com.shynsoft.goyobi");
                launchIntent.putExtra("number", incomingNumber);
                launchIntent.setAction(Intent.ACTION_SEND);
                //launchIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_RESET_TASK_IF_NEEDED);

                launchIntent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                context.startActivity(Intent.createChooser(launchIntent, "TEXT="+incomingNumber));
                //addNotification(msg);
            }
        }

        private void addNotification(String no) {
            NotificationCompat.Builder builder =
                    new NotificationCompat.Builder(this.context)
                            .setSmallIcon(R.drawable.launch_background)
                            .setContentTitle("Are You want an Analize Report for")
                            .setContentText(no);
        
            Intent notificationIntent = new Intent(this.context, MainActivity.class);
            PendingIntent contentIntent = PendingIntent.getActivity(this.context, 0, notificationIntent,
                    PendingIntent.FLAG_UPDATE_CURRENT);
            builder.setContentIntent(contentIntent);
        
            // Add as notification
            NotificationManager manager = (NotificationManager) this.context.getSystemService(Context.NOTIFICATION_SERVICE);
            manager.notify(0, builder.build());
        }
    }


    



  }