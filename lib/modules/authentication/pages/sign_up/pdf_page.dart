// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

// class PdfPage {
//   static Future<File> generate() async {
//     final pdf = pw.Document();
    
//     pdf.addPage(
//       pw.MultiPage(
//         pageFormat: PdfPageFormat.a4,
//         build: (context) => <pw.Widget>[
//           pw.Padding(
//             padding: const pw.EdgeInsets.symmetric(horizontal: 24),
//             child: pw.Column(
//               crossAxisAlignment: pw.CrossAxisAlignment.start,
//               children: [
//                 pw.Paragraph(
//                   text: 'Udemy Terms of Use',
//                   style: const pw.TextStyle(fontSize: 24),
//                 ),
//                 pw.Paragraph(
//                   text: text1,
//                   style: const pw.TextStyle(fontSize: 15),
//                 ),
//                 pw.Paragraph(
//                   text: text2,
//                   style: const pw.TextStyle(fontSize: 15),
//                 ),
//                 pw.Paragraph(
//                   text: text3,
//                   style: const pw.TextStyle(fontSize: 15),
//                 ),
//                 pw.Paragraph(
//                   text: text4,
//                   style: const pw.TextStyle(
//                       fontSize: 15, color: PdfColors.blue600),
//                 ),
//                 pw.Paragraph(
//                   text: text5,
//                   style: const pw.TextStyle(fontSize: 15),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );

//     return saveDocument(name: 'policy_term.pdf', pdf: pdf);
//   }

//   static Future<File> saveDocument({
//     required String name,
//     required pw.Document pdf,
//   }) async {
//     final bytes = await pdf.save();

//     final dir = await getApplicationDocumentsDirectory();
//     final file = File('${dir.path}/$name');

//     await file.writeAsBytes(bytes);

//     return file;
//   }
// }

// String text1 =
//     'These Terms of Use ("Terms") were last updated on February 24, 2021.';
// String text2 =
//     "Udemy's mission is to improve lives through learning. We enable anyone "
//     "anywhere to create and share educational courses (instructors) and to enroll "
//     "in these educational courses to learn (students). We consider our marketplace model "
//     "the best way to offer valuable educational content to our users. We need rules to keep "
//     "our platform and services safe for you, us and our student and instructor community."
//     "These Terms apply to all your activities on the Udemy website, the Udemy mobile "
//     "applications, our TV applications, our APIs and other related services ("
//     "Services"
//     ").";
// String text3 =
//     "If you publish a course on the Udemy platform, you must also agree to "
//     "the Instructor Terms. We also provide details regarding our processing of "
//     "personal data of our students and instructors in our Privacy Policy. If you "
//     "are using Udemy as part of your employer's Udemy For Business learning and "
//     "development program, you can consult our.";
// String text4 = "Udemy for Business Privacy Statement.";
// String text5 =
//     "If you live in the United States or Canada, by agreeing to these "
//     "Terms, you agree to resolve disputes with Udemy through binding arbitration "
//     "(with very limited exceptions, not in court), and you waive certain rights to "
//     "participate in class actions, as detailed in the Dispute Resolution section.";
