import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:chatbot/data/models/course.dart';
import 'package:chatbot/data/models/models.dart';
import 'package:chatbot/data/models/responses.dart';
import 'package:chatbot/data/services/courses/courses_service.dart';
import 'package:chatbot/data/services/storage/storage_service.dart';
import 'package:chatbot/presentation/screens/home/chat/start_using_chatbot.dart';
import 'package:chatbot/presentation/widgets/course_card.dart';
import 'package:chatbot/presentation/widgets/filter_card.dart';
import 'package:chatbot/presentation/widgets/widgets.dart';
import 'package:chatbot/utils/utils.dart';
import 'package:dialogflow_grpc/dialogflow_grpc.dart';
import 'package:dialogflow_grpc/generated/google/cloud/dialogflow/v2beta1/session.pbgrpc.dart';
import 'package:dialogflow_grpc/v2beta1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sound_stream/sound_stream.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  UserState _userState = StorageService().getUserState();

  List<Widget> _chatMessages = [];
  String _message = '';
  TextEditingController _controller;

  bool _isRecording = false;
  bool _showFilters = false;

  RecorderStream _recorder = RecorderStream();
  StreamSubscription _recorderStatus;
  StreamSubscription<List<int>> _audioStreamSubscription;
  BehaviorSubject<List<int>> _audioStream;
  List<Course> _qualifiedCourses = [];

  // TODO DialogflowGrpc class instance
  DialogflowGrpcV2Beta1 dialogflow;

  @override
  void initState() {
    super.initState();
    initPlugin();

    _controller = TextEditingController();
    _chatMessages.addAll(
      [
        // SentChatMessage(message: "Hey"),
        // ReceivedChatMessage(message: "Hi"),
        // ReceivedChatMessage(message: "How are you?"),
        // SentChatMessage(message: "I am great how are you doing?"),
        // ReceivedChatMessage(message: "I am okay"),
        // SentChatMessage(message: "Can we meet tomorrow?"),
        // ReceivedChatMessage(message: "I will think about it"),
        // SentChatMessage(message: "Lmao. Okay o."),
        // ReceivedChatMessage(message: "I will think about it"),
        // SentChatMessage(message: "Lmao. Okay o."),
      ],
    );
  }

  void _handleSubmitted(String text) async {
    // DetectIntentResponse data =
    //     await dialogflow.detectIntent(text.trim(), 'en-US');
    // String fulfillmentText = data.queryResult.fulfillmentText;

    if (text.isNotEmpty) {
      // add to listview
      _sendMessage();
    }
  }

  void _sendMessage() async {
    _message.trim();
    DetectIntentResponse data =
        await dialogflow.detectIntent(_message, 'en-US');
    // log('dialog flow response is here $data');
    // print('dialog flow response ended');
    String fulfillmentText = data.queryResult.fulfillmentText;
    log('fulfiment text is here $fulfillmentText');
    if (fulfillmentText.isNotEmpty) {
      _chatMessages.add(
        SentChatMessage(
          message: _message,
        ),
      );
      _chatMessages.add(
        ReceivedChatMessage(
          message: fulfillmentText,
        ),
      );

      // here for the grades aftermath
      if (AgentResponses.getQualifiedCoursesYesResponse
          .any((response) => response == fulfillmentText)) {
        _chatMessages.add(
          ReceivedChatMessage(
            message: 'Please choose your preferred faculty to study in.',
          ),
        );

        setState(() {
          _showFilters = true;
        });
        // log('the agent parameters are ${data.queryResult.parameters}');
        // log('the agent parameters json map is ${data.queryResult.parameters.writeToJsonMap()}');
        // log('the agent parameters json is ${data.queryResult.parameters.writeToJson()}');
        // log('the agent parameters string is ${data.queryResult.parameters.toString()}');
        // log('the agent parameters fields are ${data.queryResult.parameters.fields}');

        Map resultFromGradesAndSubjects =
            jsonDecode(data.queryResult.parameters.writeToJson());
        List<FieldParameter> fieldParameters = [];

        for (int i = 0; i < resultFromGradesAndSubjects['1'].length; i++) {
          fieldParameters.add(
              FieldParameter.fromJson(resultFromGradesAndSubjects['1'][i]));
          // log('here subject ${FieldParameter.fromJson(resultFromGradesAndSubjects['1'][i]).key}');
          // log('here grade ${FieldParameter.fromJson(resultFromGradesAndSubjects['1'][i]).value.result}');
        }

        _qualifiedCourses =
            await CoursesService().getQualifiedCourses(fieldParameters);
        log('qualified courses list is $_qualifiedCourses');
        log('qualified courses length is ${_qualifiedCourses.length}');
      }
    }
    _controller.clear();

    _message = '';
    setState(() {});
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin() async {
    _recorderStatus = _recorder.status.listen((status) {
      if (mounted)
        setState(() {
          _isRecording = status == SoundStreamStatus.Playing;
        });
    });

    await Future.wait([_recorder.initialize()]);

    // TODO Get a Service account
    // Get a Service account
    final serviceAccount = ServiceAccount.fromString(
      '${(await rootBundle.loadString('assets/jsons/final-project-chatbot-51194fc7f621.json'))}',
    );
    // Create a DialogflowGrpc Instance
    dialogflow = DialogflowGrpcV2Beta1.viaServiceAccount(serviceAccount);
  }

  void stopStream() async {
    await _recorder.stop();
    await _audioStreamSubscription?.cancel();
    await _audioStream?.close();
  }

  void handleStream() async {
    _recorder.start();

    _audioStream = BehaviorSubject<List<int>>();
    _audioStreamSubscription = _recorder.audioStream.listen((data) {
      // print('$data');
      _audioStream.add(data);
    });

    // TODO Create SpeechContexts
    var biasList = SpeechContextV2Beta1(phrases: [
      'Dialogflow CX',
      'Dialogflow Essentials',
      'Action Builder',
      'HIPAA'
    ], boost: 20.0);

    // Create an audio InputConfig
    // See: https://cloud.google.com/dialogflow/es/docs/reference/rpc/google.cloud.dialogflow.v2#google.cloud.dialogflow.v2.InputAudioConfig
    var config = InputConfigV2beta1(
        encoding: 'AUDIO_ENCODING_LINEAR_16',
        languageCode: 'en-US',
        sampleRateHertz: 16000,
        singleUtterance: false,
        speechContexts: [biasList]);

    // TODO Make the streamingDetectIntent call, with the InputConfig and the audioStream
    final responseStream =
        dialogflow.streamingDetectIntent(config, _audioStream);

    // TODO Get the transcript and detectedIntent and show on screen
    responseStream.listen((data) {
      //print('----');
      setState(() {
        //print(data);
        String transcript = data.recognitionResult.transcript;
        String queryText = data.queryResult.queryText;
        String fulfillmentText = data.queryResult.fulfillmentText;

        if (fulfillmentText.isNotEmpty) {
          SentChatMessage sentChatMessage = new SentChatMessage(
            message: queryText,
          );

          ReceivedChatMessage botMessage = new ReceivedChatMessage(
            message: fulfillmentText,
          );

          _chatMessages.add(sentChatMessage);
          _chatMessages.add(botMessage);
          _controller.clear();
        }
        if (transcript.isNotEmpty) {
          _controller.text = transcript;
        }
      });
    }, onError: (e) {
      //print(e);
    }, onDone: () {
      //print('done');
    });
  }

  bool _enableSendButton() => _message.trim().isNotEmpty && _message != null;

  void _filterResults(String label) {
    _qualifiedCourses =
        _qualifiedCourses.where((course) => course.faculty == label).toList();

    log('qualified courses are ${_qualifiedCourses.length}');

    setState(() {
      _showFilters = false;
    });

    _chatMessages.add(
      ReceivedChatMessage(
        message:
            'You choose the $label Faculty, Showing available courses in the faulty based on your subjects combinations and grades.',
      ),
    );
    if (_qualifiedCourses.isEmpty)
      _chatMessages.add(
        ReceivedChatMessage(
          message:
              'There are no available courses you can study in the $label faculty based on your subject combinations and grades.',
        ),
      );

    if (_qualifiedCourses.isNotEmpty)
      _chatMessages.add(
        SizedBox(
          height: 130,
          width: double.infinity,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              ..._qualifiedCourses.map(
                (course) => CourseCard(
                  course: _qualifiedCourses[_qualifiedCourses.indexOf(course)],
                ),
              ),
            ],
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return !_userState.hasStartedConvoWithBot
        ? StartUsingChatbot(
            onStartUsingTapped: () {
              StorageService storageService = StorageService();
              _userState.copyWith(hasStartedConvoWithBot: true);
              storageService.saveUserState(userState: _userState);
            },
          )
        : Column(
            children: [
              Expanded(
                child: Container(
                  color: lightColors.lightBackground,
                  child: ListView(
                    reverse: true,
                    children: [
                      ..._chatMessages.reversed,
                    ],
                  ),
                ),
              ),
              if (_showFilters)
                SizedBox(
                  height: 10,
                ),
              if (_showFilters)
                SizedBox(
                  height: 55,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    physics: BouncingScrollPhysics(),
                    children: [
                      FilterCard(
                        label: 'SCIENCES',
                        onTap: () {
                          _filterResults('Sciences');
                        },
                      ),
                      SizedBox(width: 20),
                      FilterCard(
                        label: 'SOCIAL SCIENCES',
                        onTap: () {
                          _filterResults('Social Sciences');
                        },
                      ),
                      SizedBox(width: 20),
                      FilterCard(
                        label: 'ARTS',
                        onTap: () {
                          _filterResults('Arts');
                        },
                      ),
                    ],
                  ),
                ),
              if (_showFilters)
                SizedBox(
                  height: 10,
                ),
              Container(
                height: 85,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: lightColors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -10),
                      color: lightColors.primary.withOpacity(.05),
                      blurRadius: 26,
                      spreadRadius: 7,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: lightColors.subText.withOpacity(.2),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextField(
                          controller: _controller,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type a message...',
                            suffixIcon: InkWell(
                              onTap: _enableSendButton()
                                  ? () {
                                      _sendMessage();
                                    }
                                  : null,
                              child: Icon(
                                Icons.send_rounded,
                                color: lightColors.text,
                              ),
                            ),
                          ),
                          onSubmitted: _handleSubmitted,
                          onChanged: (val) {
                            setState(() {
                              _message = val;
                            });
                          },
                        ),
                      ),
                    ),
                    XBox(10),
                    InkWell(
                      onTap: _isRecording ? stopStream : handleStream,
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: lightColors.primary,
                        ),
                        child: Center(
                          child: Icon(
                            _isRecording
                                ? Icons.mic_off_rounded
                                : Icons.mic_rounded,
                            color: lightColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
