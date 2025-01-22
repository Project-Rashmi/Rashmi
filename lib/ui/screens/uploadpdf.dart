import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rashmi/ui/widgets/bottom_navigation.dart';
import 'package:rashmi/ui/widgets/drawer.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:http_parser/http_parser.dart';

class UploadPdf extends StatefulWidget {
  const UploadPdf({super.key});

  @override
  State<UploadPdf> createState() => _UploadPdfState();
}

class _UploadPdfState extends State<UploadPdf> {
  List<PlatformFile?> selectedFiles = [];
  PlatformFile? fileToUpload;
  bool isPrivate = true;
  bool isLoading = false;
  final TextEditingController _filenameController = TextEditingController();
  final TextEditingController _customPromptController = TextEditingController();


  @override
  void dispose() {
    _filenameController.dispose();
    _customPromptController.dispose();
    super.dispose();
  }

  void selectFileForUpload(PlatformFile? file) {
    setState(() {
      fileToUpload = file;
      if (file != null) {
        // Automatically set the filename in the text field
        _filenameController.text = file.name;
      }
    });
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'txt', 'doc', 'docx'],
        allowMultiple: true,
      );
      debugPrint('FilePicker result: ${result?.toString()}');

      if (!mounted) return;

      if (result != null) {
        setState(() {
          selectedFiles.addAll(result.files.where((file) {
            // Exclude files that exceed size limit
            if (file.size > 25 * 1024 * 1024) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${file.name} exceeds 25MB size limit')),
              );
              return false;
            }
            return true;
          }));
        });

        debugPrint('Selected files: ${selectedFiles.map((e) => e).join(", ")}');
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error selecting files')),
      );
    }
  }

  Future<void> uploadPdfToServer() async {
    if (fileToUpload == null || fileToUpload!.path == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a file first')),
      );
      return;
    }

    if (_filenameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a filename')),
      );
      return;
    }
    setState(() {
      isLoading = true;
    });

    try {

      // Create multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://needed-narwhal-charmed.ngrok-free.app/card/generate'),
      );
      request.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhZG1pbjExIiwiZXhwIjoxNzM4MDc2NDY4LCJpYXQiOjE3Mzc0NzY0Njh9.oeS6PQJaCMY6I63-XE9jhLxUcG4G--NxyZ45gKuZRbA';
      request.headers['Content-Type'] = 'application/json';

     
      // Add additional data as form fields
      request.fields['name'] = _filenameController.text;
      request.fields['prompt'] = _customPromptController.text;
      //request.fields['availability'] = isPrivate ? 'true' : 'false' ; // Convert boolean to string


       // Attach the PDF file
      request.files.add(
        await http.MultipartFile.fromPath(
          'files', // This is the field name expected by the server
          fileToUpload!.path!,
          filename: fileToUpload!.path!.split('/').last,
          contentType: MediaType('application', 'pdf'),
        ),
      );

      // Send the request
      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      debugPrint('Response: $responseData');

      if (!mounted) return;

      if (response.statusCode == 200) {
        // Handle successful response
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('File uploaded successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      debugPrint('$e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading file: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1E6FC),
      
      drawer: const DrawerWidget(),
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Create Cards Title
                Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: Text(
                      "Create Cards",
                      style: GoogleFonts.nunito(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    )),

                const SizedBox(height: 25),
                // Upload Box
                GestureDetector(
                  onTap: pickFile,
                  child: Container(
                    margin: const EdgeInsets.only(left: 35, right: 35),
                    height: 150,
                    width: 500,
                    decoration: BoxDecoration(
                      border: const DashedBorder.fromBorderSide(
                          dashLength: 10,
                          side: BorderSide(
                            color: Color.fromRGBO(20, 20, 32, 0.7),
                            width: 3,
                          )),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            SolarIconsBold.file,
                            color: Colors.black45,
                            size: 50,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Upload .pdf, .txt or .doc",
                            style: GoogleFonts.nunito(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "Preferred file size is less than 25 MB",
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color.fromARGB(70, 20, 20, 32),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Selected Files Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Selected Files: ",
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(10, 31, 62, 1),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: selectedFiles.isNotEmpty ? 100 : 50,
                        child: selectedFiles.isNotEmpty
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: selectedFiles.map((file) {
                                    final isSelected = file == fileToUpload;
                                    return GestureDetector(
                                      onTap: () => selectFileForUpload(file),
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 20),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colors.white.withOpacity(0.9)
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          boxShadow: isSelected
                                              ? [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    spreadRadius: 1,
                                                    blurRadius: 5,
                                                    offset: const Offset(0, 2),
                                                  )
                                                ]
                                              : [],
                                        ),
                                        child: Column(
                                          children: [
                                            Icon(
                                              SolarIconsBold.file,
                                              size: 48,
                                              color: isSelected
                                                  ? const Color.fromRGBO(
                                                      103, 124, 251, 1)
                                                  : const Color.fromRGBO(
                                                      103, 124, 251, 0.7),
                                            ),
                                            const SizedBox(height: 8),
                                            SizedBox(
                                              width: 75,
                                              child: Text(
                                                file?.name ?? "No Name",
                                                style: GoogleFonts.nunito(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700,
                                                  color: const Color.fromRGBO(
                                                      10, 31, 62, 0.5),
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            : Center(
                                child: Text(
                                  "No Files Selected",
                                  style: GoogleFonts.nunito(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color:
                                        const Color.fromRGBO(10, 31, 62, 0.5),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),

                // Filename
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Set the card name: ",
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(10, 31, 62, 1),
                        ),
                      ),
                      const SizedBox(height: 8), 
                      TextField(
                        controller: _filenameController,
                        decoration: InputDecoration(
                          hintText: 'Enter filename',
                          hintStyle: GoogleFonts.nunito(
                            fontSize: 14,
                            color: const Color.fromRGBO(10, 31, 62, 0.5),
                          ),
                          filled: true,
                          fillColor: const Color.fromRGBO(202, 212, 255, 1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: const Color.fromRGBO(10, 31, 62, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // custom prompt
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Custom Prompt:",
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromRGBO(10, 31, 62, 1),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _customPromptController,
                        decoration: InputDecoration(
                          hintText: 'Enter prompt',
                          hintStyle: GoogleFonts.nunito(
                            fontSize: 14,
                            color: const Color.fromRGBO(10, 31, 62, 0.5),
                          ),
                          filled: true,
                          fillColor: const Color.fromRGBO(202, 212, 255, 1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                        ),
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          color: const Color.fromRGBO(10, 31, 62, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                // availability toggle 
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Choose Availability:",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: const Color.fromRGBO(10, 31, 62, 1),
                        ),
                      ),
                      const SizedBox(
                          height: 8), // Spacing between the text and buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isPrivate = true; // Set to Private
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isPrivate
                                  ? const Color.fromRGBO(103, 124, 251, 1)
                                  : const Color.fromRGBO(202, 212, 255, 1),
                              foregroundColor: isPrivate
                                  ? Colors.white
                                  : const Color.fromRGBO(10, 31, 62, 0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: Text(
                              "Private",
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isPrivate = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: !isPrivate
                                  ? const Color.fromRGBO(103, 124, 251, 1)
                                  : const Color.fromRGBO(202, 212, 255, 1),
                              foregroundColor: !isPrivate
                                  ? Colors.white
                                  : const Color.fromRGBO(10, 31, 62, 0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                            child: Text(
                              "Public",
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Submit Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 105, vertical: 15),
                      ),
                      onPressed: isLoading ? null : uploadPdfToServer,
                      child: isLoading
                          ? const SizedBox(
                              child: CircularProgressIndicator(
                                color: Color.fromRGBO(103, 124, 251, 1),
                                strokeWidth: 3,
                              ),
                            )
                          : Text(
                              "Generate Cards",
                              style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: const Color.fromRGBO(245, 245, 245, 1)),
                            ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBarCreate(),
      );
  }
}
