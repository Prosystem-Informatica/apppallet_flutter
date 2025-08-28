abstract class IHomeRepository {
  Future<void> checkUrl();
  Future<void> home(String totalViagens, String totalNormal, String totalExtra, String totalDev);
}
