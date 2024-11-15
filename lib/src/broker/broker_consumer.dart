import 'package:kafkabr/kafka.dart';

class BrokerConsumer {
  void consume() async {
    var host = ContactPoint('192.168.0.99', 9092);
    var session = KafkaSession([host]);
    var group = ConsumerGroup(session, 'flutter');
    var topics = {
      'services': {0} // list of partitions to consume from.
    };

    var consumer = Consumer(session, group, topics, 1000, 1);
    try {
      print('consumer.consume');
      await for (MessageEnvelope envelope in consumer.consume()) {
        print('inside for');
        try {
          // Assuming that messages were produces by Producer from previous example.
          var value = String.fromCharCodes(envelope.message.value);
          print('Got message: ${envelope.offset}, ${value}');
          envelope.commit('metadata'); // Important.
        } catch (e) {
          print('');
          print('ERRO LOOP');
          print(e);
          print('');
        }
      }
    } catch (e) {
      print('');
      print('ERRO TRY');
      print(e);
      print('');
    }
    print('fechando sessão');
    await session
        .close(); // make sure to always close the session when the work is done.
  }
}
