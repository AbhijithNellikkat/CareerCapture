// ignore_for_file: use_build_context_synchronously, use_super_parameters

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
  String employmentType = '';
  late String pdfPath;

  final pdf = pw.Document();

  void generatePdf() async {
    final pdfPath = await _createPdfFile();
    if (pdfPath != null) {
      log('PDF generated and saved at: $pdfPath');
      Navigator.pop(context, pdfPath);
    } else {
      log('Failed to generate PDF');
    }
  }

  Future<String?> _createPdfFile() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final String path = directory.path;
      final String pdfName =
          'job_description_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final File file = File('$path/$pdfName');

      final pdf = pw.Document();

      pdf.addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return <pw.Widget>[
              pw.Header(
                level: 1,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: <pw.Widget>[
                    pw.Text(
                      'Job Description',
                      textScaleFactor: 2,
                      style: pw.TextStyle(
                          fontSize: 16, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 20),
                  ],
                ),
              ),
              pw.SizedBox(height: 40),
              pw.Text('Job Title: ${jobTitleController.text}'),
              pw.SizedBox(height: 20),
              pw.Text('Company Overview: ${companyOverviewController.text}'),
              pw.SizedBox(height: 20),
              pw.Text('Role Summary: ${roleSummaryController.text}'),
              pw.SizedBox(height: 20),
              pw.Text(
                  'Key Responsibilities: ${keyResponsibilitiesController.text}'),
              pw.SizedBox(height: 20),
              pw.Text(
                  'Required Skills and Qualifications: ${requiredSkills.join(", ")}'),
              pw.SizedBox(height: 20),
              pw.Text(
                  'Preferred Skills and Qualifications: ${preferredSkills.join(", ")}'),
              pw.SizedBox(height: 20),
              pw.Text(
                  'Salary Range and Benefits: ${salaryRangeAndBenefitsController.text}'),
              pw.SizedBox(height: 20),
              pw.Text('Employment Type: $employmentType'),
              pw.SizedBox(height: 20),
              if (employmentType == 'Internship' ||
                  employmentType == 'Both') ...[
                pw.Text(
                    'Duration of Internship (Months): ${durationOfInternshipController.text}'),
                pw.SizedBox(height: 20),
                pw.Text(
                    'Stipend of Internship: ${stipendOfInternshipController.text}'),
                pw.SizedBox(height: 20),
              ],
              if (employmentType == 'Full-time' ||
                  employmentType == 'Both') ...[
                pw.Text('CTC for Full Time: ${ctcForFullTimeController.text}'),
                pw.SizedBox(height: 20),
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
              const SizedBox(height: 20),
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
