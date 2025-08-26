abstract class ILoginRepository {
  Future<void> checkUrl();
  Future<void> login(String login, String password);
}
