import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scum_poker/app/data/firebase_repository.dart';
import 'package:scum_poker/app/models/session_model.dart';
import 'package:scum_poker/app/utilis/service_locator.dart';
import 'package:scum_poker/app/utilis/image_asset_path.dart';
import 'package:scum_poker/app/widgets/drop_list_session.dart';
import 'package:scum_poker/app/widgets/subit_name_button.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({Key? key}) : super(key: key);

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final TextEditingController myController = TextEditingController();
  SessionModel? selectedSession;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ImageAssets.avatar,
                height: 220,
                width: 220,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 18),

              // Card-like container for the input and submit area
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.blue.withOpacity(0.85)
                      : Colors.grey[900]!.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Enter your name',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: myController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        filled: true,
                        fillColor:
                            Theme.of(context).brightness == Brightness.light
                            ? Colors.grey[100]
                            : Colors.grey[800],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Your name',
                      ),
                    ),
                    SizedBox(height: 16),

                    // Center the submit button and keep its padding
                    Align(
                      alignment: Alignment.center,
                      child: SubmitNameButton(
                        controller: myController,
                        selectedSession: selectedSession,
                      ),
                    ),
                    SizedBox(height: 12),
                    StreamBuilder<List<Map<String, dynamic>>>(
                      stream: getIt<VoteRepository>().getSessionsStream(),
                      builder: (context, snapshot) {
                        final sessions = snapshot.hasData
                            ? snapshot.data!
                                  .map(
                                    (m) => SessionModel(
                                      id: m['id'].toString(),
                                      name: (m['name'] ?? 'Unnamed').toString(),
                                      createdAt: m['createdAt'] != null
                                          ? DateTime.tryParse(
                                                  (m['createdAt'] ?? '')
                                                      .toString(),
                                                ) ??
                                                DateTime.now()
                                          : DateTime.now(),
                                    ),
                                  )
                                  .toList()
                            : <SessionModel>[];

                        return DropListSession(
                          selectedSession: selectedSession,
                          sessionList: sessions,
                          onChanged: (value) {
                            setState(() {
                              selectedSession = value;
                            });
                          },
                          onSessionAdded: (newSession) {
                            setState(() {
                              // Clear selection after adding; user will manually select from updated list
                              selectedSession = null;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Session "${newSession.name}" created! Please select it from the dropdown.',
                                  ),
                                ),
                              );
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
