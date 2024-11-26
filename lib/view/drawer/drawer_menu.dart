import 'package:kathiravan_fireworks/imports.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 170.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(RawString.appLogoURL),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextBuilder(text: RawString.appName, fontSize: 15.0, fontWeight: FontWeight.bold),
                            TextBuilder(text: RawString.dummyEmail, fontSize: 15.0, fontWeight: FontWeight.normal),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const Home()));
                          },
                          leading: const Icon(
                            Icons.home,
                            color: Colors.black,
                            size: 20,
                          ),
                          title: const TextBuilder(text: "Home", fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const Cart()));
                          },
                          leading: const Icon(
                            Icons.shopping_bag,
                            color: Colors.black,
                            size: 20,
                          ),
                          title: const TextBuilder(text: "Cart", fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                        ListTile(
                          onTap: () {
                            UrlLaunch.launchInBrowser(urlString: RawString.website);
                          },
                          leading: const Icon(Icons.source, color: Colors.black, size: 20),
                          title: const TextBuilder(text: "Website", fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                        ListTile(
                          onTap: () {
                            UrlLaunch.makeEmail(email: RawString.website, body: 'Hello,', subject: 'Can we Talk?');
                          },
                          leading: const Icon(
                            Icons.email,
                            color: Colors.black,
                            size: 20,
                          ),
                          title: const TextBuilder(text: "Contact", fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                        InkWell(
                          // Update the about dialog content in drawer_menu.dart
onTap: () {
  Navigator.pop(context);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('About Kathiravan Crackers'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Premium Quality, Unbeatable Prices',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Discover the best crackers online in India at unbelievable prices, exclusively at Kathiravan Crackers. We are committed to providing authentic Sivakasi fireworks, ensuring a spectacular celebration at exceptional value.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Nationwide Distribution',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Whether you\'re in Bangalore, Chennai, Hyderabad, Coimbatore, Salem, Kerala, or any part of Tamil Nadu or India, Kathiravan Crackers reaches you with our swift and efficient distribution network.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Years of Excellence',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'With a legacy spanning over 10+ years, Kathiravan Crackers stands tall as one of the leading manufacturers of crackers and fireworks in India. Our dedication lies in offering the finest products and services to our valued customers.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    ),
  );
},
                          child: const ListTile(
                            leading: Icon(
                              Icons.info,
                              color: Colors.black,
                              size: 20,
                            ),
                            title: TextBuilder(text: "About", fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 100,
              child: Column(
                children: [
                  const AppNameWidget(),
                  TextBuilder(
                    text: RawString.appDescription,
                    fontSize: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
