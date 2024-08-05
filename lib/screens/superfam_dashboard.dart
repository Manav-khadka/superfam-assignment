import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superfam_assignment/constants/dimensions.dart';
import 'package:superfam_assignment/constants/text_styles.dart';
import 'package:superfam_assignment/models/key_value_model.dart';
import 'package:superfam_assignment/providers/superfam_dashboard_provider.dart';

class SuperfamDashboard extends StatefulWidget {
  final String title;
  const SuperfamDashboard({super.key, required this.title});

  @override
  State<SuperfamDashboard> createState() => _SuperfamDashboardState();
}

class _SuperfamDashboardState extends State<SuperfamDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer<SuperfamDashboardProvider>(
        builder: (context, provider, child) {
          List<KeyValue> keyValueList = provider.keyValueList;
          if (provider.isNoKeyValue) {
            return Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: Dimensions.width(300),
                        height: Dimensions.height(300),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/empty.webp'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.height(10)),
                      Text(
                        'No key value pairs found, Please add some',
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: Dimensions.height(20),
                  right: Dimensions.width(20),
                  child: FloatingActionButton(
                    onPressed: () {
                      _showBottomSheet(context);
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            );
          }
          return Stack(
            children: [
              ListView.builder(
                itemCount: keyValueList.length,
                itemBuilder: (context, index) {
                  KeyValue keyValue = keyValueList[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Key: ',
                              style: AppTextStyles.bodyMedium
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: keyValue.key,
                              style: AppTextStyles.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Value: ',
                              style: AppTextStyles.bodyMedium
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: keyValue.value,
                              style: AppTextStyles.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // Handle delete action
                              provider.deleteKeyValue(keyValue.id ?? 0);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: Dimensions.height(20),
                right: Dimensions.width(20),
                child: FloatingActionButton(
                  onPressed: () {
                    _showBottomSheet(context);
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Consumer<SuperfamDashboardProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Container(
                  width: Dimensions.screenWidth,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: provider.getKeyController,
                              decoration: const InputDecoration(
                                labelText: 'Key',
                                prefixIcon: Icon(Icons.vpn_key),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextField(
                              controller: provider.getValueController,
                              decoration: const InputDecoration(
                                labelText: 'Value',
                                prefixIcon: Icon(Icons.label),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 245, 153, 146),
                              ),
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.black,
                              ),
                              label: Text(
                                'Cancel',
                                style: AppTextStyles.bodyMedium,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                if (provider.getKeyController.text.isNotEmpty &&
                                    provider
                                        .getValueController.text.isNotEmpty) {
                                  provider.addKeyValue(KeyValue(
                                    key: provider.getKeyController.text,
                                    value: provider.getValueController.text,
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Please enter key and value'),
                                    ),
                                  );
                                }
                                provider.getKeyController.clear();
                                provider.getValueController.clear();
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 197, 232, 198),
                              ),
                              icon: const Icon(
                                Icons.save,
                                color: Colors.black,
                              ),
                              label: Text(
                                'Save',
                                style: AppTextStyles.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
