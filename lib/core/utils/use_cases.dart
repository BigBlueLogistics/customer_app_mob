abstract class UseCases<Response, Params> {
  Future<Response> call(Params? params);
}
