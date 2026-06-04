class ApiUrl {
  static String _baseUrl = 'https://api.gpstrak.in';
  static String get baseUrl => "$_baseUrl/api/";
  static const String login = "login";

  static void setBaseUrl(String url) {
    _baseUrl = url;
  }

  static const String logout = "logout";
  static const String forgetPasswordOtpGet = "client_password_otp_send";
  static const String multiDashboard = "twings_multi_dashboard";
  static const String vehicleCount = "vehicle_count";
  static const String alertNotificationsList = "alert_notifications_list";
  static const String alertNotificationStore = "alert_notification/store";
  static const String allAlert = "all_alert";
  static const String geoFence = "geo_fence";
  static const String assignGeoFence = "assign_geo_fence";
  static const String liveAddress = "http://69.197.153.82:8080/reverse";
  static const String liveAddress2 =
      "https://nominatim.openstreetmap.org/reverse";
  static const String olaAddress2 =
      "https://api.olamaps.io/places/v1/reverse-geocode";
  static const String getTripReport = "get_trip_report";
  static const String idleReport = "get_idle_report";
  static const String temperatureAlertReport = "temperature_alert_report";
  static const String fuelFillDipReport = "fuel_fill_dip_report";
  static const String rpmReport = "rpm_report";
  static const String getElockReport = "get_elock_report";
  static const String getDistanceReport = "get_distance_report";
  static const String getParkingReport = "get_parking_report";
  static const String getInactiveReport = "get_inactive_report";
  static const String acReport = "ac_report";
  static const String getPlaybackReport = "get_playback_report";
  static const String geofenceReport = "geofence_report";
  static const String executiveReport = "executive_report_temp";
  static const String smartReport = "smart_report_temp";
  static const String configShow = "data_vehicle_config_show";
  static const String configStore = "data_vehicle_config_update";
  static const String dataVehicleEdit = "data_vehicle_edit";
  static const String userUpdate = "data_user_update";
  static const String userDelete = "data_user_delete";
  static const String contactAddress = "contact_address";
  static const String shareLinkSave = "share_link_save";
  static const String clientAnnouncement = "client_announcement";
  static const String shareLinkList = "share_link_list";
  static const String vehicleImageUpload = "vehicleimageUpload";
  static const String vehicleImageRetrieve = "vehicleimageRetrieve";
  static const String safeParking = "config/safe_parking";
  static const String fuelDipAlertStop = "fuel_dip_alert_stop";
  static const String dueVehicleList = "due_vehicle_list";
  static const String aboutUs = "about_us";
  static const String singleDashboard = "twings_single_dashboard";
  static const String vehicleHistoryDetails = "vehicle_history_details";
  static const String changeUserPassword = "change_user_password";
  static const String executiveReportCheckList = "executive_report_check_list";
  static const String executiveReportCheckUpdate =
      "executive_report_check_update";
  static const String executiveSummary = "executive_summary_temp";
  static const String immobilizerOption = "config/immobilizer_option/";
  static const String immoblizerData = "immobilizer_data";
  static const String shareLinkDelete = "share_link_delete/";
  static const String generateFcmToken = "generate_fcm_token";
  static const String country = "country";
  static const String vehicleType = "vehicle_type";
  static const String onlineUserSave = "online_user_save";
  static const String distanceSummary = "distance_summary";
  static const String parkSummary = "get_park_summary";
  static const String idleSummary = "get_idle_summary";
  static const String tripSummary = "get_trip_summary";
  static const String acSummary = "get_ac_summary";
  static const String speedSummary = "speed-summary";
  static const String getSpeedGraph = "get_speed_graph";
  static const String getAcDurationChartData = "ac_duration_chart_data";
  static const String addDevice = "online_vehicle_save";
  static const String validateUserDetails = "validate_user_details";
  static const String tripData = "vehicle_daily_activity";
  static const String vehicleTodayDistance = "vehicle_today_distance";
  static const String mileageReport = "mileage_report";
  static const String clientVehicleList = "client_vehicle_list";
  static const String vehicleTripDistance = "vehicle_trip_distance";
  static const String fuelAnalysisChart = "fuel_analysis_chart";
  static const String unlockELock = "unlock_elock";
  static const String tempAnalysisChart = "temp_analysis_chart";
  static const String getAlertReport = "get_alert_report";
  static const String getSpeedReport = "speed_report";
  static const String fuelSummary = "fuel_summary";
  static const String smartGenericAlerts = "smart_generic_alerts";
  static const String powerAlert = "power_alert";
  static const String reportsMenuList = "menu_access_new";
  static const String getLockPassword = "get_lock_password";
  static const String getDeviceCommand = "get_device_command";
  static const String getCallSettings = "get_call_settings";
  static const String updateCallSettings = "update_call_settings";
  static const String dashcameraPlaybackList = "dashcamera_playback_list";
  static const String dashcamPlayBackFile = "dashcamera_playback_file";
  static const String dashacamAlertTypeList = "dashacam_alert_type_list";
  static const String dashcamAiAlertFolderCount =
      "dashcam_ai_alert_folder_count";
  static const String dashcamAiAlertFolderData = "dashcam_ai_alert_folder_data";
  static const String assignFenceList = "assign_fence_list";
  static const String vehicleGeofenceList = "vehicle_geofence_list";
  static const String vehicleGeofenceSave = "vehicle_geofence_save";
  static String vehicleTodayPlayback({required int deviceImei}) =>
      "vehicle_today_playback/$deviceImei";

  static String liveStreaming({
    required String deviceImei,
    required String channel,
    required String deviceType,
    required String token,
  }) =>
      "${ApiUrl._baseUrl}/live_streaming/$deviceImei/$channel/$deviceType/$token";

  static String videoPlayback({
    required String deviceImei,
    required String startTime,
    required String endTime,
    required String channel,
    required String deviceType,
    required String token,
  }) =>
      "${ApiUrl._baseUrl}/video_playback/$deviceImei/$startTime/$endTime/$channel/$deviceType/$token";

  static String getParkingReportExport({
    required dynamic deviceImei,
    required String fromDate,
    required String toDate,
    required int type,
  }) =>
      "${baseUrl}get_parking_report_export?start_day=${fromDate}&end_day=${toDate}&device_imei=${deviceImei}&type=${type}";

 
  static String getInactiveReportExport({
    required dynamic deviceImei,
    required String fromDate,
    required String toDate,
    required int type,
  }) =>
      "${baseUrl}get_inactive_report_export?start_day=${fromDate}&end_day=${toDate}&device_imei=${deviceImei}&type=${type}";
  
  
  static String getIdleReportExport({
    required dynamic deviceImei,
    required String fromDate,
    required String toDate,
    required int type,
  }) =>
      "${baseUrl}get_idle_report_export?start_day=${fromDate}&end_day=${toDate}&device_imei=${deviceImei}&type=${type}";

  static String getTripReportExport({
    required dynamic deviceImei,
    required String fromDate,
    required String toDate,
    required int type,
  }) =>
      "${baseUrl}get_trip_report_export?start_day=${fromDate}&end_day=${toDate}&device_imei=${deviceImei}&type=${type}";

  static String getDistanceSummaryExport({
    required dynamic deviceImei,
    required String fromDate,
    required String toDate,
    required int type,
  }) =>
      "${baseUrl}get_distance_summary_export?start_day=${fromDate}&end_day=${toDate}&device_imei=${deviceImei}&type=${type}";

  static String getParkSummaryExport({
    required dynamic deviceImei,
    required String fromDate,
    required String toDate,
    required int type,
  }) =>
      "${baseUrl}get_park_summary_export?start_day=${fromDate}&end_day=${toDate}&device_imei=${deviceImei}&type=${type}";

  static String getIdleSummaryExport({
    required dynamic deviceImei,
    required String fromDate,
    required String toDate,
    required int type,
  }) =>
      "${baseUrl}get_idle_summary_export?start_day=${fromDate}&end_day=${toDate}&device_imei=${deviceImei}&type=${type}";

  static String getTripSummaryExport({
    required dynamic deviceImei,
    required String fromDate,
    required String toDate,
    required int type,
  }) =>
      "${baseUrl}get_trip_summary_export?start_day=${fromDate}&end_day=${toDate}&device_imei=${deviceImei}&type=${type}";

  static String getAcSummarypdfExcelExport({
    required dynamic deviceImei,
    required String fromDate,
    required String toDate,
    required int type,
  }) =>
      "${baseUrl}get_ac_summary_export?start_day=${fromDate}&end_day=${toDate}&device_imei=${deviceImei}&type=${type}";

  static String getGeofenceSummaryExport({
    required dynamic deviceImei,
    required String fromDate,
    required String toDate,
    required int type,
  }) =>
      "${baseUrl}get_geofence_report_export?start_day=${fromDate}&end_day=${toDate}&device_imei=${deviceImei}&geofence_id=All&type=${type}";

  static String getAcSummaryExport({
    required dynamic deviceImei,
    required String fromDate,
    required String toDate,
    required int type,
  }) =>
      "${baseUrl}get_ac_report_export?start_day=${fromDate}&end_day=${toDate}&device_imei=${deviceImei}&type=${type}";

  static String getDailySummaryExport({
    required dynamic deviceImei,
    required String fromDate,
    required String toDate,
    required int type,
  }) =>
      "${baseUrl}get_daily_report_export?start_day=${fromDate}&end_day=${toDate}&device_imei=${deviceImei}&type=${type}";

  static String getSpeedExport({
    required dynamic deviceImei,
    required String fromDate,
    required String toDate,
    required int type,
    required int speed,
  }) =>
      "${baseUrl}get_speed_report_export?start_day=${fromDate}&end_day=${toDate}&device_imei=${deviceImei}&speed=$speed&type=${type}";

  static String getAlertExport({
    required dynamic deviceImei,
    required String fromDate,
    required String toDate,
    required int type,
    required dynamic alertTypeId,
  }) =>
      "${baseUrl}get_alert_report_export?start_day=${fromDate}&end_day=${toDate}&device_imei=${deviceImei}&alert_type_id=$alertTypeId&type=${type}";

  static String getPlaybackExport({
    required dynamic deviceImei,
    required String fromDate,
    required String toDate,
    required int type,
  }) =>
      "${baseUrl}get_playback_report_export?start_day=${fromDate}&end_day=${toDate}&device_imei=${deviceImei}&type=${type}";

  static String getELockExport({
    required dynamic deviceImei,
    required String fromDate,
    required String toDate,
    required int type,
  }) =>
      "${baseUrl}get_elock_report_export?start_day=${fromDate}&end_day=${toDate}&device_imei=${deviceImei}&type=${type}";

  static String getFuelSummaryExport({
    required dynamic deviceImei,
    required String fromDate,
    required String toDate,
    required int type,
  }) =>
      "${baseUrl}get_fuel_summary_export?start_day=${fromDate}&end_day=${toDate}&device_imei=${deviceImei}&type=${type}";

  static String getFuelDipExport({
    required dynamic deviceImei,
    required String fromDate,
    required String toDate,
    required int type,
  }) =>
      "${baseUrl}get_fuel_fill_dip_export?start_day=${fromDate}&end_day=${toDate}&device_imei=${deviceImei}&type=${type}";

  static String liveTalk({
    required dynamic deviceImei,
    required String deviceType,
    required String accessToken,
  }) =>
      "${_baseUrl}/live_talk/${deviceImei}/${deviceType}/${accessToken}";
}
