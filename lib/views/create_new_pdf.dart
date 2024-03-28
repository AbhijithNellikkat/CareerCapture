import 'dart:developer';
import 'dart:io';

import 'package:career_capture/views/widgets/multichips_input_widget.dart';
import 'package:career_capture/views/widgets/submit_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CreateNewPdfView extends StatefulWidget {
  const CreateNewPdfView({Key? key}) : super(key: key);

  @override
  State<CreateNewPdfView> createState() => _CreateNewPdfViewState();
}

class _CreateNewPdfViewState extends State<CreateNewPdfView> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  TextEditingController jobTitleController = TextEditingController();
  TextEditingController companyOverviewController = TextEditingController();
  TextEditingController roleSummaryController = TextEditingController();
  TextEditingController keyResponsibilitiesController = TextEditingController();
  TextEditingController salaryRangeAndBenefitsController =
      TextEditingController();
  TextEditingController durationOfInternshipController =
      TextEditingController();
  TextEditingController stipendOfInternshipController = TextEditingController();
  TextEditingController ctcForFullTimeController = TextEditingController();

  List<String> requiredSkills = [];
  List<String> preferredSkills = [];
  List<String> errors = [];
  String employmentType = '';
  late String pdfPath;

  final pdf = pw.Document();

   void generatePdf() async {
    final pdfPath = await _createPdfFile();
    pdfPath != null
        ? log('PDF generated and saved at: $pdfPath')
        : log('Failed to generate PDF');
  }

  Future savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/example.pdf");
    file.writeAsBytesSync(pdf.save() as List<int>);
  }

  Future<String?> _createPdfFile() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final String path = directory.path;
      final String pdfName = 'job_description_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final File file = File('$path/$pdfName');
      
      final pdf = pw.Document();

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (pw.Context context) {
            return <pw.Widget>[
              pw.Header(
                level: 0,
                child: pw.Row(
                  children: <pw.Widget>[
                    pw.Text('Job Description', textScaleFactor: 2),
                  ],
                ),
              ),
              pw.Text('Job Title: ${jobTitleController.text}'),
              pw.Text('Company Overview: ${companyOverviewController.text}'),
              pw.Text('Role Summary: ${roleSummaryController.text}'),
              pw.Text('Key Responsibilities: ${keyResponsibilitiesController.text}'),
              pw.Text('Required Skills and Qualifications: ${requiredSkills.join(", ")}'),
              pw.Text('Preferred Skills and Qualifications: ${preferredSkills.join(", ")}'),
              pw.Text('Salary Range and Benefits: ${salaryRangeAndBenefitsController.text}'),
              pw.Text('Employment Type: $employmentType'),
              if (employmentType == 'Internship' || employmentType == 'Both') ...[
                pw.Text('Duration of Internship (Months): ${durationOfInternshipController.text}'),
                pw.Text('Stipend of Internship: ${stipendOfInternshipController.text}'),
              ],
              if (employmentType == 'Full-time' || employmentType == 'Both') ...[
                pw.Text('CTC for Full Time: ${ctcForFullTimeController.text}'),
              ],
            ];
          },
        ),
      );

      await file.writeAsBytes(await pdf.save());

      return file.path;
    } catch (e) {
      log('Error creating PDF: $e');
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                'Create a Job Description',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 13),
              Text(
                'Please fill the fields to create the JD',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(23.0),
                child: FormBuilder(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          controller: jobTitleController,
                          name: 'job_title',
                          validator: FormBuilderValidators.required(
                            errorText: 'Please enter the job title',
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter the job title',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        FormBuilderTextField(
                          controller: companyOverviewController,
                          maxLines: null,
                          name: 'company_overview',
                          validator: FormBuilderValidators.required(
                            errorText: 'Please enter the company overview',
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter the company overview',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        FormBuilderTextField(
                          controller: roleSummaryController,
                          validator: FormBuilderValidators.required(
                            errorText: 'Please enter the role summary',
                          ),
                          maxLines: null,
                          name: 'role_summary',
                          decoration: InputDecoration(
                            hintText: 'Enter the role summary',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        FormBuilderTextField(
                          controller: keyResponsibilitiesController,
                          validator: FormBuilderValidators.required(
                            errorText: 'Please enter the key responsibilities',
                          ),
                          maxLines: null,
                          name: 'key_responsibilities',
                          decoration: InputDecoration(
                            hintText: 'List the key responsibilities',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20),
                        MultiChipsInputWidget(
                          label: 'Required Skills and Qualifications',
                          initialValues: requiredSkills,
                          onSaved: (value) {
                            setState(() {
                              requiredSkills = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        MultiChipsInputWidget(
                          label: 'Preferred Skills and Qualifications',
                          initialValues: preferredSkills,
                          onSaved: (value) {
                            setState(() {
                              preferredSkills = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        FormBuilderTextField(
                          controller: salaryRangeAndBenefitsController,
                          validator: FormBuilderValidators.required(
                            errorText:
                                'Please enter the salary range and benefits',
                          ),
                          name: 'salary_range_and_benefits',
                          decoration: InputDecoration(
                            hintText: 'Salary Range and Benefits',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.only(right: 160),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Employment Type',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              FormBuilderDropdown(
                                name: 'employment_type',
                                validator: FormBuilderValidators.required(
                                  errorText:
                                      'Please select the employment type',
                                ),
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'Select Type',
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    employmentType = value!;
                                  });
                                },
                                items: ['Full-time', 'Internship', 'Both']
                                    .map((type) => DropdownMenuItem(
                                          value: type,
                                          child: Text(type),
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (employmentType == 'Internship' ||
                            employmentType == 'Both')
                          FormBuilderTextField(
                            controller: durationOfInternshipController,
                            validator: FormBuilderValidators.required(
                              errorText:
                                  'Please enter the duration of internship',
                            ),
                            name: 'duration_of_internship',
                            decoration: InputDecoration(
                              hintText: 'Duration of Internship (Months)',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        const SizedBox(height: 10),
                        if (employmentType == 'Internship' ||
                            employmentType == 'Both')
                          FormBuilderTextField(
                            controller: stipendOfInternshipController,
                            name: 'stipend_of_internship',
                            validator: FormBuilderValidators.required(
                              errorText:
                                  'Please enter the stipend of internship',
                            ),
                            decoration: InputDecoration(
                              hintText: 'Stipend of Internship',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        const SizedBox(height: 20),
                        if (employmentType == 'Full-time' ||
                            employmentType == 'Both')
                          FormBuilderTextField(
                            controller: ctcForFullTimeController,
                            name: 'ctc_for_full_time',
                            validator: FormBuilderValidators.required(
                              errorText: 'Please enter the CTC for full time',
                            ),
                            decoration: InputDecoration(
                              hintText: 'CTC for Full Time',
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.saveAndValidate()) {
                              generatePdf();

                             
                            }
                          },
                          child: const SubmitButtonWidget(),
                        ),
                        const SizedBox(height: 10),
                        if (errors.isNotEmpty)
                          Text(
                            'Please fix the following errors: ${errors.join(", ")}',
                            style: const TextStyle(color: Colors.red),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
