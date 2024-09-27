class AppEndpoints {
  static const baseUrl = 'https://coventiltestapi.pingpong.university/api/mobile/v1/';
  static const login = 'Authorization/Login';
  static const forgotPassword = 'Authorization/SendPasswordResetLink';
  static const refreshToken = 'Authorization/RefreshToken';
  static const validateMainDevice = 'Device/ValidateParentDevice';
  static const validateSubDevice = 'Device/ValidateSubDevice';
  static const createMainDevice = 'Device/CreateParentDevice';
  static const getDeviceDetail = 'Device/GetDeviceDetailOnMap';
  static const getNotifications = 'Notification/GetAllNotification';
  static const updateDeviceStatus = 'Device/UpdateDeviceStatus';
  static const readNotification = 'NotificationRead/Create';
  static const notificationState = 'NotificationRead/AnyUnRead';
  static const updateValveStatus = 'Valve/UpdateValveStatus';
  static const createSubDevice = 'Device/CreateSubDevice';
  static const getAllDevices = 'Device/GetAllDeviceOnMap';
  static const allCities = 'Parameter/GetAllCity';
  static const allDistricts = 'Parameter/GetAllCountry';
  static const allDevices = 'Parameter/GetAllParentDevice';
  static const allConducting = 'Parameter/GetAllCheftaincy';
  static const allParks = 'Parameter/GetAllParkAndGarden';
  static const search = 'Parameter/GetAllDevice';
}
