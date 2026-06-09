package com.gpssoftware
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.app.Service
import android.os.Build
import android.util.Log
import androidx.core.app.NotificationCompat
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import com.gpssoftware.AlarmScreenActivity 
import android.app.Notification
import android.app.ActivityManager
import org.json.JSONObject

class MyFirebaseMessagingService : FirebaseMessagingService() {
    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        super.onMessageReceived(remoteMessage)
    if (remoteMessage.data["type"] == "safe_alert") {
        Log.d("MyFirebaseMessagingService", "notifiaction initalted")
        showFullScreenNotification()
        Log.d("MyFirebaseMessagingService", "Alarm notification received")
    } else {
        // showStandardNotification(remoteMessage)  // for other notifiactions
        Log.d("MyFirebaseMessagingService", "Notification received: ${remoteMessage.data}")
    }

    }

    private fun showFullScreenNotification() {
    val intent = Intent(this, AlarmScreenActivity::class.java).apply {
        flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
        putExtra("safe_alert", "true")
        putExtra("deviceid", "863656047679514")
    }

    val pendingIntent = PendingIntent.getActivity(
        this, 0, intent,
        PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
    )

    val channelId = "alarm_channel"
    val notificationManager =
        getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

    // ✅ Create notification channel (required for Android 8+)
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
        val channel = NotificationChannel(
            channelId,
            "Alarm Channel",
            NotificationManager.IMPORTANCE_HIGH
        ).apply {
            description = "For alarm-style full-screen notifications"
            lockscreenVisibility = Notification.VISIBILITY_PUBLIC
        }
        notificationManager.createNotificationChannel(channel)
    }

    // ✅ Build full-screen notification
    val builder = NotificationCompat.Builder(this, channelId)
        .setSmallIcon(R.mipmap.ic_launcher)
        .setContentTitle("Safe Alert!")
        .setContentText("Tap to stop the alarm")
        .setPriority(NotificationCompat.PRIORITY_HIGH)
        .setCategory(NotificationCompat.CATEGORY_ALARM)
        .setAutoCancel(true)
        .setFullScreenIntent(pendingIntent, true)
        .setContentIntent(pendingIntent)

    val notification = builder.build()
    notificationManager.notify(1001, notification)

    // ✅ Optional: If you want to force activity to open when app is not visible
    if (!isAppInForeground(this)) {
        Log.d("MyFirebaseMessagingService", "App in background, starting alarm activity manually")
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        startActivity(intent)
    } else {
        Log.d("MyFirebaseMessagingService", "App is in foreground, showing full-screen notification only")
    }
}

private fun isAppInForeground(context: Context): Boolean {
    val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
    val appProcesses = activityManager.runningAppProcesses ?: return false
    val packageName = context.packageName
    for (appProcess in appProcesses) {
        if (appProcess.importance == ActivityManager.RunningAppProcessInfo.IMPORTANCE_FOREGROUND
            && appProcess.processName == packageName) {
            return true
        }
    }
    return false
}

}
