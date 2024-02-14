/*
 * Package : mqtt_client
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 31/05/2017
 * Copyright :  S.Hamblett
 */

import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class Mqtt {
  final client = MqttServerClient('test.mosquitto.org', '');

  /// The subscribed callback
  void onSubscribed(String topic) {}

  /// The unsolicited disconnect callback
  void onDisconnected() {
    if (client.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
    } else {
      exit(-1);
    }
  }

  /// The successful connect callback
  void onConnected() {}

  Future<int> connectToMqtt(Function callback) async {
    client.logging(on: true);
    client.setProtocolV311();
    client.keepAlivePeriod = 20;
    client.connectTimeoutPeriod = 2000;
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;
    await client.connect();
    subscribeToData("Blinky");
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      callback(pt);
    });
    return 0;
  }

  void publishData(String topic) {
    final builder = MqttClientPayloadBuilder();
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
  }

  void subscribeToData(String topic) {
    client.subscribe(topic, MqttQos.atLeastOnce);
  }
}

// final client = MqttServerClient('test.mosquitto.org', '');

// Future<int> main() async {
//   /// A websocket URL must start with ws:// or wss:// or Dart will throw an exception, consult your websocket MQTT broker
//   /// for details.
//   /// To use websockets add the following lines -:
//   /// client.useWebSocket = true;
//   /// client.port = 80;  ( or whatever your WS port is)
//   /// There is also an alternate websocket implementation for specialist use, see useAlternateWebSocketImplementation
//   /// Note do not set the secure flag if you are using wss, the secure flags is for TCP sockets only.
//   /// You can also supply your own websocket protocol list or disable this feature using the websocketProtocols
//   /// setter, read the API docs for further details here, the vast majority of brokers will support the client default
//   /// list so in most cases you can ignore this.

//   /// Set logging on if needed, defaults to off
//   client.logging(on: true);

//   /// Set the correct MQTT protocol for mosquito
//   client.setProtocolV311();

//   /// If you intend to use a keep alive you must set it here otherwise keep alive will be disabled.
//   client.keepAlivePeriod = 20;

//   /// The connection timeout period can be set if needed, the default is 5 seconds.
//   client.connectTimeoutPeriod = 2000; // milliseconds

//   /// Add the unsolicited disconnection callback
//   client.onDisconnected = onDisconnected;

//   /// Add the successful connection callback
//   client.onConnected = onConnected;

//   /// Add a subscribed callback, there is also an unsubscribed callback if you need it.
//   /// You can add these before connection or change them dynamically after connection if
//   /// you wish. There is also an onSubscribeFail callback for failed subscriptions, these
//   /// can fail either because you have tried to subscribe to an invalid topic or the broker
//   /// rejects the subscribe request.
//   client.onSubscribed = onSubscribed;

//   /// Create a connection message to use or use the default one. The default one sets the
//   /// client identifier, any supplied username/password and clean session,
//   /// an example of a specific one below.
//   // final connMess = MqttConnectMessage()
//   //     .withClientIdentifier('Mqtt_MyClientUniqueId')
//   //     .withWillTopic('willtopic') // If you set this you must set a will message
//   //     .withWillMessage('My Will message')
//   //     .startClean() // Non persistent session for testing
//   //     .withWillQos(MqttQos.atLeastOnce);
//   // print('EXAMPLE::Mosquitto client connecting....');
//   // client.connectionMessage = connMess;

//   /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
//   /// in some circumstances the broker will just disconnect us, see the spec about this, we however will
//   /// never send malformed messages.
//   try {
//     await client.connect();
//   } on NoConnectionException catch (e) {
//     // Raised by the client when connection fails.
//     print('NO CONNECTION :: client exception - $e');
//     client.disconnect();
//   } on SocketException catch (e) {
//     // Raised by the socket layer
//     print('SOCKET EXCEPTION :: socket exception - $e');
//     client.disconnect();
//   }

//   /// Check we are connected
//   if (client.connectionStatus!.state == MqttConnectionState.connected) {
//     print('TAMAGO :: Mosquitto client connected');
//   } else {
//     /// Use status here rather than state if you also want the broker return code.
//     print(
//         ' TAMAGO :: ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
//     client.disconnect();
//     exit(-1);
//   }

//   /// Ok, lets try a subscription
//   print('EXAMPLE::Subscribing to the test/lol topic');
//   const blinkyTopic = 'Blinky'; // Not a wildcard topic
//   client.subscribe(blinkyTopic, MqttQos.atMostOnce);

//   /// The client has a change notifier object(see the Observable class) which we then listen to to get
//   /// notifications of published updates to each subscribed topic.
//   /// In general you should listen here as soon as possible after connecting, you will not receive any
//   /// publish messages until you do this.
//   /// Also you must re-listen after disconnecting.
//   client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
//     final recMess = c![0].payload as MqttPublishMessage;
//     final pt =
//         MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

//     /// The above may seem a little convoluted for users only interested in the
//     /// payload, some users however may be interested in the received publish message,
//     /// lets not constrain ourselves yet until the package has been in the wild
//     /// for a while.
//     /// The payload is a byte buffer, this will be specific to the topic
//     print(
//         'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
//     print('');
//   });

//   /// If needed you can listen for published messages that have completed the publishing
//   /// handshake which is Qos dependant. Any message received on this stream has completed its
//   /// publishing handshake with the broker.
//   client.published!.listen((MqttPublishMessage message) {
//     print(
//         'EXAMPLE::Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
//   });

//   /// Lets publish to our topic
//   /// Use the payload builder rather than a raw buffer
//   /// Our known topic to publish to
//   const pubTopic = 'Blinky';
//   final builder = MqttClientPayloadBuilder();
//   builder.addString('Hello from titi');

//   /// Subscribe to it
//   print('EXAMPLE::Subscribing to the Dart/Mqtt_client/testtopic topic');
//   client.subscribe(pubTopic, MqttQos.exactlyOnce);

//   /// Publish it
//   print('EXAMPLE::Publishing our topic');
//   client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);

//   return 0;
// }

// /// The subscribed callback
// void onSubscribed(String topic) {
//   print('EXAMPLE::Subscription confirmed for topic $topic');
// }

// /// The unsolicited disconnect callback
// void onDisconnected() {
//   print('EXAMPLE::OnDisconnected client callback - Client disconnection');
//   if (client.connectionStatus!.disconnectionOrigin ==
//       MqttDisconnectionOrigin.solicited) {
//     print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
//   } else {
//     print(
//         'EXAMPLE::OnDisconnected callback is unsolicited or none, this is incorrect - exiting');
//     exit(-1);
//   }
// }

// /// The successful connect callback
// void onConnected() {
//   print(
//       'EXAMPLE::OnConnected client callback - Client connection was successful');
// }
