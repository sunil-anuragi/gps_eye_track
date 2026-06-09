package com.gpssoftware
import android.media.MediaPlayer
import android.app.KeyguardManager
import android.os.Build
import android.os.Bundle
import android.view.WindowManager
import androidx.appcompat.app.AppCompatActivity
import android.view.MotionEvent
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.Handler
import android.os.Looper
import android.view.animation.AnimationUtils
import android.widget.ImageView
import android.widget.TextView

class AlarmScreenActivity : AppCompatActivity() {

    private var mediaPlayer: MediaPlayer? = null    
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_alarm_screen) 
        val bellIcon = findViewById<ImageView>(R.id.bellIcon)
        val pulseAnim = AnimationUtils.loadAnimation(this, R.anim.pulse)
        bellIcon.startAnimation(pulseAnim)

        // // Optional: auto-dismiss
        // Handler(Looper.getMainLooper()).postDelayed({
        //     finish()
        // }, 5000)

        val flutterEngine = FlutterEngine(this)
       
        mediaPlayer = MediaPlayer.create(this, R.raw.alarm_tone)
        mediaPlayer?.isLooping = true
        mediaPlayer?.start()

        // Turn screen on and show over lock screen
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O_MR1) {
            setShowWhenLocked(true)
            setTurnScreenOn(true)
        }

        window.addFlags(
            WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON or
            WindowManager.LayoutParams.FLAG_ALLOW_LOCK_WHILE_SCREEN_ON or
            WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED or
            WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON
        )

        val keyguardManager = getSystemService(KEYGUARD_SERVICE) as KeyguardManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            keyguardManager.requestDismissKeyguard(this, null)
        }

        setContentView(R.layout.activity_alarm_screen) // create layout
    }


     override fun onTouchEvent(event: MotionEvent?): Boolean {
        if (event?.action == MotionEvent.ACTION_DOWN) {
            stopSoundAndOpenFlutter()
            return true
        }
        return super.onTouchEvent(event)
    }

    private fun stopSoundAndOpenFlutter() {
        mediaPlayer?.stop()
        mediaPlayer?.release()
        mediaPlayer = null

       
    val intent = FlutterActivity
    .withNewEngine()
    .initialRoute("/") 
    .build(this)
    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    startActivity(intent)
    finish() 
    }
     override fun onDestroy() {
        super.onDestroy()
        mediaPlayer?.release()
        mediaPlayer = null
    }



}
