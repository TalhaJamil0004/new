import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: "Services".text.xl2.bold.color(context.primaryColor).make(),
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
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Row(children: [
                Expanded(
                    child: Image(
                            image: AssetImage("assets/images/servicestop.webp"))
                        .hThreeForth(context)),
              ]),
              SizedBox(height: 150,),
              Row(
                children: [
                  //1st
                  Expanded(
                      child:
                          Image(image: AssetImage("assets/images/services.jpg"))
                              ),
                  SizedBox(width: 14), // Optional
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Surgery"
                            .text
                            .bold
                            .color(context.primaryColor)
                            .xl5
                            .make(),
                        Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ).pOnly(top: 2),
                        SizedBox(
                            height:
                                8), // Optional, for spacing between heading and content

                        RichText(
                          text: TextSpan(
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                            children: [
                              TextSpan(text: 'At our '),
                              TextSpan(
                                text: 'Pet Vet Clinic',
                                style: TextStyle(
                                    color: context.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Vx.dp20),
                              ),
                              TextSpan(
                                text:
                                    ', we specialize in a wide range of veterinary surgeries to ensure the health and well-being of your beloved pets. Our experienced veterinary doctors perform routine procedures such as spaying and neutering, which help control the pet population and prevent certain health issues. We also offer',
                              ),
                              TextSpan(
                                text: ' advanced surgical interventions',
                                style: TextStyle(
                                    color: context.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Vx.dp20),
                              ),
                              TextSpan(
                                text:
                                    ', including orthopedic surgeries for fractures and joint problems, soft tissue surgeries for tumor removals, and emergency surgeries to address urgent health crises. Utilizing state-of-the-art equipment and the ',
                              ),
                              TextSpan(
                                text: 'latest medical technique',
                                style: TextStyle(
                                    color: context.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Vx.dp20),
                              ),
                              TextSpan(
                                text:
                                    ', we ensure that each surgery is performed with the utmost care and precision, prioritizing the safety and comfort of your pet throughout the entire process. Our compassionate team provides thorough post-operative care and guidance, ensuring a smooth and ',
                              ),
                              TextSpan(
                                text: 'speedy recovery',
                                style: TextStyle(
                                    color: context.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Vx.dp20),
                              ),
                              TextSpan(
                                text: '  for your furry friends. ',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 80,),

//2nd
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Vaccinations"
                            .text
                            .bold
                            .color(context.primaryColor)
                            .xl5
                            .make(),
                        Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ).pOnly(top: 2),
                        SizedBox(
                            height:
                                8), // Optional, for spacing between heading and content

                        RichText(
                          text: TextSpan(
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                            children: [
                              TextSpan(text: 'At our '),
                              TextSpan(
                                text: 'Pet Vet Clinic',
                                style: TextStyle(
                                    color: context.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Vx.dp20),
                              ),
                              TextSpan(
                                text:
                                    ',we prioritize the health and well-being of your furry companions by offering a comprehensive range of vaccinations. As veterinary doctors, we administer core vaccines such as those for rabies, distemper, parvovirus, and adenovirus to protect dogs from life-threatening diseases. For cats, we provide ',
                              ),
                              TextSpan(
                                text: 'essential vaccinations',
                                style: TextStyle(
                                    color: context.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Vx.dp20),
                              ),
                              TextSpan(
                                text:
                                    " against feline viral rhinotracheitis, calicivirus, and panleukopenia. Additionally, we offer non-core vaccines tailored to your pet's specific needs and lifestyle, including those for bordetella, Lyme disease, and feline leukemia. Our goal is to ensure that your pets receive the best ",
                              ),
                              TextSpan(
                                text: 'preventive care',
                                style: TextStyle(
                                    color: context.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Vx.dp20),
                              ),
                              TextSpan(
                                text:
                                    ', safeguarding them from common and potentially severe illnesses.',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 14), // Optional
                  Expanded(
                      child: Image(
                              image: AssetImage("assets/images/services1.webp"))
                          ),
                ],
              ),
       SizedBox(height: 80,),
//3rd
              Row(
                children: [
                  Expanded(
                      child: Image(
                              image: AssetImage("assets/images/services2.png"))
                          .hThreeForth(context)),
                  SizedBox(width: 14), // Optional
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Ultrasound"
                            .text
                            .bold
                            .color(context.primaryColor)
                            .xl5
                            .make(),
                        Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ).pOnly(top: 2),
                        SizedBox(
                            height:
                                8), // Optional, for spacing between heading and content

                        RichText(
                          text: TextSpan(
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                            children: [
                              TextSpan(text: 'At our '),
                              TextSpan(
                                text: 'Pet Vet Clinic',
                                style: TextStyle(
                                    color: context.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Vx.dp20),
                              ),
                              TextSpan(
                                text:
                                    ' we utilize advanced ultrasound technology to provide comprehensive diagnostic imaging for our patients. As veterinary doctors, we rely on ultrasound to gain detailed insights into the internal structures of pets, enabling us to ',
                              ),
                              TextSpan(
                                text:
                                    'accurately diagnose a wide range of conditions',
                                style: TextStyle(
                                    color: context.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Vx.dp20),
                              ),
                              TextSpan(
                                text:
                                    ". This non-invasive procedure allows us to examine the heart, liver, kidneys, and other vital organs, as well as to monitor pregnancies and detect abnormalities. Our ",
                              ),
                              TextSpan(
                                text: 'skilled team',
                                style: TextStyle(
                                    color: context.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Vx.dp20),
                              ),
                              TextSpan(
                                text:
                                    'ensures that each ultrasound is conducted with the utmost care and precision, ensuring the comfort and safety of our furry patients while delivering critical information for their treatment plans.',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
SizedBox(height: 80,),
//4th
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Grooming"
                            .text
                            .bold
                            .color(context.primaryColor)
                            .xl5
                            .make(),
                        Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ).pOnly(top: 2),
                        SizedBox(
                            height:
                                8), // Optional, for spacing between heading and content

                        RichText(
                          text: TextSpan(
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.black),
                            children: [
                              TextSpan(text: 'At our '),
                              TextSpan(
                                text: 'Pet Vet Clinic',
                                style: TextStyle(
                                    color: context.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Vx.dp20),
                              ),
                              TextSpan(
                                text:
                                    'grooming is an essential part of the comprehensive care we provide to our furry patients. Our skilled veterinary team ensures that each pet receives top-notch grooming services tailored to their specific needs. From thorough ',
                              ),
                              TextSpan(
                                text:
                                    'bathing and gentle brushing to precise haircuts and nail trimming,',
                                style: TextStyle(
                                    color: context.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Vx.dp20),
                              ),
                              TextSpan(
                                text:
                                    " we take pride in making pets look and feel their best. We also offer specialized treatments like ",
                              ),
                              TextSpan(
                                text:
                                    'ear cleaning, teeth brushing, and skin care',
                                style: TextStyle(
                                    color: context.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Vx.dp20),
                              ),
                              TextSpan(
                                text:
                                    ' to maintain overall health and hygiene. Our compassionate approach ensures that every pet feels comfortable and stress-free during their grooming session, leaving them happy and refreshed.',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                      child: Image(
                              image: AssetImage("assets/images/services3.png"))
                          .hThreeForth(context)),
                ],
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
                          TextSpan(
                              text:
                                  ' us on '),
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
                          TextSpan(
                              text:
                                  '© 2024 | Pet Vet Animal Clinic | Veterinary Marketing & Websites by '),
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

            ]
            ).px16())));
  }
}
