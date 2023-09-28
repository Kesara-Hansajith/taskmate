import 'package:flutter/material.dart';
import 'package:taskmate/components/attachment_card.dart';
import 'package:taskmate/components/dark_main_button.dart';
import 'package:taskmate/components/freelancer/user_data_gather_textfield.dart';
import 'package:taskmate/components/freelancer/user_data_gather_title.dart';
import 'package:taskmate/components/light_main_button.dart';
import 'package:taskmate/constants.dart';
import 'package:file_picker/file_picker.dart';

class AddPortfolioItem extends StatefulWidget {
  const AddPortfolioItem({super.key});

  @override
  State<AddPortfolioItem> createState() => _AddPortfolioItemState();
}

class _AddPortfolioItemState extends State<AddPortfolioItem> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> openFilePicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType
            .any, // You can specify the file types to allow (e.g., FileType.image, FileType.pdf, etc.)
        allowMultiple:
            true, // Set to true if you want to allow multiple file selection
      );

      if (result != null) {
        List<String> filePaths = result.paths.map((path) => path!).toList();
        // You now have the selected file paths in the `filePaths` list
      } else {
        // User canceled the file picker
      }
    } catch (e) {
      // Handle any exceptions that may occur during file picking
    }
  }

  void _navigateBackwards() {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add Portfolio Item',
            style: kHeadingTextStyle,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 4,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.navigate_before,
              color: kDeepBlueColor,
            ),
          ),
          flexibleSpace: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  'images/noise_image.webp',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/noise_image.webp'),
            ),
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 20.0,
                  ),
                  const UserDataGatherTitle(title: 'Portfolio Title'),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: UserDataGatherTextField(
                      controller: titleController,
                      hintText: 'Enter Title',
                      validatorText: 'Field can\'t be empty',
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const UserDataGatherTitle(title: 'Item Description'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      controller: descriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        hintText: 'Enter Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 1.0,
                            color: kDarkGreyColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            width: 2.0,
                            color: kDeepBlueColor,
                          ),
                        ),
                        filled: true,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field can\'t be empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const UserDataGatherTitle(title: 'Upload Files'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Material(
                      child: InkWell(
                        onTap: () {
                          openFilePicker();
                          //TODO Implement add file functionality
                        },
                        child: AttachmentCard(
                          cardChild: Text('+ Add'),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: LightMainButton(
                            title: 'Cancel',
                            process: _navigateBackwards,
                          ),
                        ),
                        Expanded(
                          child: DarkMainButton(
                            title: 'Submit',
                            process: () {
                              if (_formKey.currentState!.validate()) {
                                // Form is valid, proceed with submission or other actions
                                _navigateBackwards();
                              }
                              //TODO Implement submit functionality
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
