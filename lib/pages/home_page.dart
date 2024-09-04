import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:veterinary_application/components/mycard.dart';
// import 'package:veterinary_application/components/routes.dart';
import 'package:veterinary_application/widgets/drawer.dart';
// import 'package:veterinary_application/widgets/star_rating_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String email = "";

  @override
  void initState() {
    getEmail();
    super.initState();
  }

  Future<void> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString("userEmail");

    setState(() {
      email = userEmail ?? "hi"; // Update email and trigger a rebuild
    });

    debugPrint("Email in function: ------>>> $email");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            "Veterinary Clinic"
                .text
                .xl2
                .bold
                .color(context.primaryColor)
                .make(),
            const SizedBox(width: 20),
            const Image(image: AssetImage("assets/images/mainimg.png"))
                .h8(context),
          ],
        ),
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
              Row(
                children: [
                  Expanded(
                    child: const Image(
                      image: AssetImage("assets/images/mainimg1.png"),
                    ).hThreeForth(context),
                  ),
                  const SizedBox(width: 14), // Optional
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "About Clinic"
                            .text
                            .bold
                            .color(context.primaryColor)
                            .xl5
                            .make(),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                        ).pOnly(top: 2),
                        const SizedBox(
                          height: 8,
                        ), 
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                            children: [
                              const TextSpan(text: 'At '),
                              TextSpan(
                                text: 'Pet Vet Clinic',
                                style: TextStyle(
                                  color: context.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Vx.dp20,
                                ),
                              ),
                              const TextSpan(
                                text:
                                    ', our mission is to provide exceptional and compassionate veterinary care to every furry family member that walks through our doors. We are dedicated to fostering a healthier and happier pet community by promoting responsible pet ownership and strengthening the ',
                              ),
                              TextSpan(
                                text: 'human-animal bond.',
                                style: TextStyle(
                                  color: context.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Vx.dp20,
                                ),
                              ),
                              const TextSpan(
                                text:
                                    ' Pets Vets animal clinic takes great pride in making sure he is treated like a member of the family. Pet and Vets Clinic lead by combining compassionate care with the latest in',
                              ),
                              TextSpan(
                                text: ' medical technology and treatment.',
                                style: TextStyle(
                                  color: context.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Vx.dp20,
                                ),
                              ),
                              const TextSpan(
                                text:
                                    ' With unwavering dedication, we vow to be advocates for the well-being of your furry companions, treating them with the same love and care as we would our own pets. ',
                              ),
                              TextSpan(
                                text: 'Our commitment to animal care',
                                style: TextStyle(
                                  color: context.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Vx.dp20,
                                ),
                              ),
                              const TextSpan(
                                text:
                                    ' is not just a profession but a heartfelt passion, and we are honored to be a part of your pet\'s health and happiness throughout their life journey. Our friendly experienced staff will provide your pet with both general pet care services and advanced medical care. Services include vaccinations, dentistry, grooming, weight management, microchip, soft tissue surgery, critical care management, and pet supplies. Please contact us for more details about your pet needs or to schedule an appointment. ',
                              ),
                              TextSpan(
                                text: 'We look forward to serving you!',
                                style: TextStyle(
                                  color: context.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Vx.dp20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(
                height: 80,
              ),
              "Doctors".text.bold.color(context.primaryColor).xl5.make(),
              const SizedBox(
                height: 20,
              ),
              "At our clinic, our dedicated team of veterinary doctors is committed to providing the highest standard of care for your beloved pets. With a passion for animal health and well-being, our veterinarians bring a wealth of experience and expertise to every consultation and procedure. Whether it's a routine check-up, a complex surgical procedure, or compassionate end-of-life care, our veterinarians approach each case with compassion, professionalism, and a deep understanding of the unique bond between pets and their owners. We strive to ensure that every pet receives personalized attention and treatment tailored to their individual needs, promoting a lifetime of health and happiness."
                  .text
                  .xl
                  .make(),
                  const SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                     Mycard(imgPath: "assets/images/doctor1.png", docName:"Dr. Faizan", docDetail:'Veterinary Surgeon\n10 years experience' ),
                  Mycard(imgPath: "assets/images/doctor2.png", docName:"Dr. Talha", docDetail:'Veterinary Surgeon\n10 years experience' ),
                  Mycard(imgPath: "assets/images/doctor3.png", docName:"Dr. Ahmad", docDetail:'Veterinary Surgeon\n10 years experience' ),  
                    Mycard(imgPath: "assets/images/doctor4.png", docName:"Dr. Hafsa", docDetail:'Veterinary Surgeon\n10 years experience' ),
                     Mycard(imgPath: "assets/images/doctor5.png", docName:"Dr. Ali", docDetail:'Veterinary Surgeon\n10 years experience' ),
                      Mycard(imgPath: "assets/images/doctor6.png", docName:"Dr. Khuzama", docDetail:'Veterinary Surgeon\n10 years experience' ), 
                  ],),
                   const SizedBox(
                height: 80,
              ),
                  
           "Pet Care Tips".text.bold.color(context.primaryColor).xl5.make(),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: context.canvasColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Keep Your Pet Healthy".text.bold.color(context.primaryColor).xl3.make(),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: const Image(
                            image: AssetImage("assets/images/pethealth.png"),
                          ).h32(context),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: "Ensure your pet is up to date on vaccinations and regular check-ups."
                              .text
                              .xl
                              
                              .make(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    "Proper Nutrition".text.bold.color(context.primaryColor).xl3.make(),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: const Image(
                            image: AssetImage("assets/images/properNuter.png"),
                          ).h32(context),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: "Feed your pet a balanced diet suitable for their age, size, and health needs."
                              .text
                              .xl
                              
                              .make(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    "Regular Exercise".text.bold.color(context.primaryColor).xl3.make(),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: const Image(
                            image: AssetImage("assets/images/petwalk.png"),
                          ).h32(context),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: "Exercise your pet regularly to maintain their physical and mental health."
                              .text
                              .xl
                             
                              .make(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    "Grooming".text.bold.color(context.primaryColor).xl3.make(),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: const Image(
                            image: AssetImage("assets/images/grooming.png"),
                          ).h32(context),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: "Regular grooming helps to keep your pet clean and comfortable."
                              .text
                              .xl
                             
                              .make(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    "Love and Attention".text.bold.color(context.primaryColor).xl3.make(),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: const Image(
                            image: AssetImage("assets/images/petcare.png"),
                          ).h32(context),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: "Spend quality time with your pet to strengthen your bond."
                              .text
                              .xl
                            
                              .make(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
             
              const SizedBox(
                height: 80,
              ),
              Column(
                children: [
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            "Opening Timing"
                                .text
                                .bold
                                .color(context.primaryColor)
                                .xl5
                                .make(),
                            "Monday to Saturday : 11am to 9pm"
                                .text
                                .bold
                                .color(context.primaryColor)
                                .xl2
                                .make(),
                            "Sunday : 4am to 9pm"
                                .text
                                .bold
                                .color(context.primaryColor)
                                .xl2
                                .make(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            "Address"
                                .text
                                .bold
                                .color(context.primaryColor)
                                .xl5
                                .make(),
                            SizedBox(
                              height: 12,
                            ),
                            GestureDetector(
                              onTap: () {
                                openGoogleMaps(31.5064987, 74.3148799,"Pet Vet Clinic","assets/images/services.jpg");
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  "Google Map"
                                      .text
                                      .bold
                                      .color(context.primaryColor)
                                      .xl2
                                      .make(),
                                  Icon(Icons.location_on_outlined)
                                      .iconSize(40)
                                      .iconColor(Colors.blueAccent),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            "Doctors Availability"
                                .text
                                .bold
                                .color(context.primaryColor)
                                .xl5
                                .make(),
                            "For consultation "
                                .text
                                .bold
                                .color(context.primaryColor)
                                .xl2
                                .make(),
                            "Available: 24/7"
                                .text
                                .bold
                                .color(context.primaryColor)
                                .xl2
                                .make(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
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
            ],
          ).p16(),
        ),
      ),
      drawer: MyDrawer(
        email: email,
      ),
    );
  }

  Future<void> openGoogleMaps(
    double lat,
    double lng,
    String title,
    String imageUrl,
  ) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng&query_place_id=$title';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
