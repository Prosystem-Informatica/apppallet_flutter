abstract class IHomeRepository {
  Future<void> checkUrl();
  Future<void> home(String  totalviagens, String totalnormal, String totalxtra, String totaldev );
}
