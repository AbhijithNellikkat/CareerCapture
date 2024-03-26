import 'package:career_capture/views/widgets/multichips_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateNewPdfView extends StatefulWidget {
  const CreateNewPdfView({super.key});

  @override
  State<CreateNewPdfView> createState() => _CreateNewPdfViewState();
}

class _CreateNewPdfViewState extends State<CreateNewPdfView> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  List<String> requiredSkills = [];

  List<String> preferredSkills = [];

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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Job Title',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            FormBuilderTextField(
                              name: 'job_title',
                              decoration: InputDecoration(
                                hintText: 'Enter the job title',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Company Overview',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            FormBuilderTextField(
                              maxLines: null,
                              name: 'company_overview',
                              decoration: InputDecoration(
                                hintText: 'Enter the company overview',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Role Summary',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            FormBuilderTextField(
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
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Key Responsibilities',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            FormBuilderTextField(
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
                          ],
                        ),

                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                          ],
                        ),

                        const SizedBox(height: 40),
                        FormBuilderDropdown(
                          name: 'employment_type',
                          decoration: const InputDecoration(
                            labelText: 'Employment Type',
                            border: OutlineInputBorder(),
                          ),
                          items: ['Full-time', 'Internship', 'Both']
                              .map((type) => DropdownMenuItem(
                                    value: type,
                                    child: Text(type),
                                  ))
                              .toList(),
                        ),
                        // Show/hide fields based on employment type using visibility widget
                        Visibility(
                          visible: _formKey.currentState
                                  ?.fields['employment_type']?.value ==
                              'Internship',
                          child: FormBuilderTextField(
                            name: 'duration_of_internship',
                            decoration: InputDecoration(
                                labelText: 'Duration of Internship (Months)'),
                          ),
                        ),
                        Visibility(
                          visible: _formKey.currentState
                                  ?.fields['employment_type']?.value ==
                              'Internship',
                          child: FormBuilderTextField(
                            name: 'stipend_of_internship',
                            decoration: InputDecoration(
                                labelText: 'Stipend of Internship'),
                          ),
                        ),
                        Visibility(
                          visible: _formKey.currentState
                                      ?.fields['employment_type']?.value ==
                                  'Full-time' ||
                              _formKey.currentState?.fields['employment_type']
                                      ?.value ==
                                  'Both',
                          child: FormBuilderTextField(
                            name: 'ctc_for_full_time',
                            decoration:
                                InputDecoration(labelText: 'CTC for Full Time'),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Submit'),
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
