import 'response.dart';

class TrucksVansEntity extends ResponseEntity<List<TResponseData>> {
  const TrucksVansEntity({super.data, super.message, super.status});
}

class TrucksVansStatusDetailsEntity extends ResponseEntity<TResponseData> {
  const TrucksVansStatusDetailsEntity(
      {super.data, super.message, super.status});
}
