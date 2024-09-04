import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:veterinary_application/components/mycard.dart';
import 'package:veterinary_application/widgets/aboutSection.dart';
import 'package:veterinary_application/widgets/star_rating_widget.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: "About Us".text.xl2.bold.color(context.primaryColor).make(),
      ),
       floatingActionButton: FloatingActionButton(
        onPressed: () async {
          const phoneNumber = '03241113337'; // Replace with your WhatsApp number
          const url = 'https://wa.me/$phoneNumber';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
        child:FaIcon(FontAwesomeIcons.whatsapp, color: context.canvasColor,),
        backgroundColor: context.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Image.asset(
                        'assets/images/aboutus1.jpg',
                        fit: BoxFit.contain,
                      ).hFull(context),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About Us',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: context.primaryColor,
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Pet Vet Clinic is a full-service animal hospital dedicated to providing the highest quality '
                            'veterinary care to pets in our community. We are a team of experienced and compassionate '
                            'veterinarians and staff who are committed to providing your pet with the best possible care. Our '
                            'goal is to provide your pet with the care they need to live a long and healthy life. We believe '
                            'that every pet deserves to be treated with love and respect, and we strive to create a warm and '
                            'welcoming environment for you and your furry friend. We invite you to visit Pet Vet Hospital and '
                            'see for yourself why we are the best choice for your pet\'s care. Call us today to schedule an '
                            'appointment!',
                          ).text.xl.make(),
                          SizedBox(height: 16),
                          buildSection('Experience',StarRating(rating: 5), Colors.blue, '100%'),
                         
                          buildSection('Patient Care',StarRating(rating: 5), Color(0xFF69D131), '100%'),
                          buildSection('Scientific Skills',StarRating(rating: 5), Color(0xFFF73041), '100%'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              Text(
                'Meet Our Team',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ).p16(),

              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Mycard(imgPath: "assets/images/doctor1.png", docName:"Dr. Faizan", docDetail:'Veterinary Surgeon\n10 years experience' ),
                  Mycard(imgPath: "assets/images/doctor2.png", docName:"Dr. Talha", docDetail:'Veterinary Surgeon\n10 years experience' ),
                  Mycard(imgPath: "assets/images/doctor3.png", docName:"Dr. Ahmad", docDetail:'Veterinary Surgeon\n10 years experience' ),  
                ]
              ),

SizedBox(height: 40,),
 Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Mycard(imgPath: "assets/images/doctor4.png", docName:"Dr. Hafsa", docDetail:'Veterinary Surgeon\n10 years experience' ),
                  Mycard(imgPath: "assets/images/doctor5.png", docName:"Dr. Ali", docDetail:'Veterinary Surgeon\n10 years experience' ),
                  Mycard(imgPath: "assets/images/doctor6.png", docName:"Dr. Khuzama", docDetail:'Veterinary Surgeon\n10 years experience' ),  
                ]
              ),


              const SizedBox(height: 80),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                        children: [
                          TextSpan(text: 'You can '),
                          TextSpan(
                            text: 'Follow',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: ' us on '),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () async {
                                const url = 'https://www.facebook.com/profile.php?id=61559484083313';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: Text(
                                'Facebook',
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                    ).centered(),
                    SizedBox(height: 16.0),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                        children: [
                          TextSpan(text: '© 2024 | Pet Vet Animal Clinic | Veterinary Marketing & Websites by '),
                          WidgetSpan(
                            child: GestureDetector(
                              onTap: () async {
                                const url = 'https://www.linkedin.com/in/talhajamil0004/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: Text(
                                'Talha & Basit',
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                    ).centered(),
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
