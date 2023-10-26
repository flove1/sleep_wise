import 'package:flutter/material.dart';
import 'package:sleep_wise/helpers/config.dart';

class Field {
  Field({
    required this.icon,
    required this.title, 
    required this.child
  });

  IconData icon;
  String title;
  Widget child;
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late List<Field> fields;

  @override 
  void initState() {
    fields = [
      Field(
        icon: Icons.notifications_outlined,
        title: "Notifications",
        child: Container(),
      ),
      Field(
        icon: Icons.notes,
        title: "Contact developers",
        child: Container(),
      ),
      Field(
        icon: Icons.report_outlined,
        title: "Report about the problem",
        child: Container(),
      ),
      Field(
        icon: Icons.remove_circle_outline_outlined,
        title: "Clear my data",
        child: Container(),
      ),
    ];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppConfig.spacing),
      child: ListView(
        children: List<Widget>.from(
          [
            Padding(
              padding: EdgeInsets.only(bottom: AppConfig.spacing),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Alarms:",
                    style: TextStyle(
                      fontSize: 24 * AppConfig.fontScaling, 
                      fontWeight: FontWeight.w700, 
                      letterSpacing: 0.0
                    )
                  ),
                  IconButton(
                    onPressed: () => {}, 
                    icon: const Icon(Icons.question_mark_outlined),
                    padding: const EdgeInsets.all(0.0),
                    iconSize: 24 * AppConfig.fontScaling,
                  )
                ],
              )
            )
          ].toList()
        ).followedBy(
          fields.map((field) {
            return TextButton.icon(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  useRootNavigator: true,
                  isScrollControlled: true,
                  useSafeArea: true,
                  enableDrag: false,
                  isDismissible: false,
                  context: context,
                  clipBehavior: Clip.antiAlias,
                  shape: const Border(),
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context,setState) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: AppConfig.spacing / 4, horizontal: AppConfig.spacing),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    iconSize: 28 * AppConfig.fontScaling,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 28 / 2 * AppConfig.fontScaling),
                                    child: Text(
                                      field.title,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 20 * AppConfig.fontScaling, 
                                        fontWeight: FontWeight.w700, 
                                        letterSpacing: 0.0
                                      )
                                    ),
                                  )
                                ],  
                              ),
                            ),
                            const Divider(),
                            field.child
                          ],
                        );
                      },
                    );
                  }
                );
              }, 
              icon: Icon(field.icon), 
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              label: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(vertical: AppConfig.spacing / 2),
                child: Text(
                  field.title,
                  style: TextStyle(
                    fontSize: 16 * AppConfig.fontScaling, 
                    fontWeight: FontWeight.w400, 
                    letterSpacing: 0.0
                  )
                ),
              )
            );
          })
        ).toList()
        
        // fields.map((e) {
        //   return
        // }).
        
        // [
          
        //   TextButton.icon(
        //     onPressed: () {}, 
        //     icon: const Icon(Icons.notes),
        //     style: TextButton.styleFrom(
        //       foregroundColor: Colors.white,
        //     ),
        //     label: Container(
        //       alignment: Alignment.centerLeft,
        //       padding: EdgeInsets.symmetric(vertical: spacing / 2),
        //       child: Text(
        //         "Contact developers",
        //         style: TextStyle(
        //           fontSize: 16 * fontScaling, 
        //           fontWeight: FontWeight.w400, 
        //           letterSpacing: 0.0
        //         )
        //       ),
        //     )
        //   ),
        // ]
      )
    );
  }
}