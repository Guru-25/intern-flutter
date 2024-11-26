import 'package:http/http.dart' as http;

import 'package:kathiravan_fireworks/imports.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<ProductModel>>? futureProduct;
  String _searchQuery = '';
  String? _selectedCategory;
  final List<String> categories = ['All', 'Ground Chakkers','Candles','Sound Crackers','Rockets','Gift Box','Bombs','Sparklers','Flowerpots', 'MultiShots' , 'Atom Bomb' , 'Wala Crackers'];

  Future<List<ProductModel>> fetchProducts() async {
    List<ProductModel> products = [];
    const baseUrl = 'https://santhosh-1608.github.io/ProductData/products.json';
    var request = http.Request('GET', Uri.parse(baseUrl));

    http.StreamedResponse response = await request.send();
    var responseBody = await response.stream.bytesToString(); // Store the response body

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(responseBody);
      }
      final jsonData = jsonDecode(responseBody);
      products = jsonData.map<ProductModel>((e) => ProductModel.fromJson(e)).toList();
      setState(() {}); // Assuming this is within a Stateful widget

      return products;
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    futureProduct = fetchProducts();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  Widget _buildSearchAndFilter() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: FilterChip(
                  selected: _selectedCategory == category,
                  label: Text(category),
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = selected ? category : null;
                    });
                  },
                  selectedColor: Colors.red.withOpacity(0.2),
                  checkmarkColor: Colors.red,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  List<ProductModel> getFilteredProducts(List<ProductModel> products) {
    return products.where((product) {
      final matchesSearch = product.title!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == null || 
                            _selectedCategory == 'All' || 
                            product.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: const DrawerMenu(),
      appBar: AppBar(
        title: Center(
  child: const AppNameWidget(),
),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const Cart()));
            },
            icon: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: cart.itemCount != 0 ? 8 : 0, right: cart.itemCount != 0 ? 8 : 0),
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                if (cart.itemCount != 0)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                      child: TextBuilder(
                        text: cart.itemCount.toString(),
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                  )
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<List<ProductModel>>(
          future: futureProduct,
          builder: (context, data) {
            if (data.hasData) {
              final products = data.data!;
              return Column(
                children: [
                  _buildSearchAndFilter(),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(15),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.5 / 4,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                      ),
                      itemCount: getFilteredProducts(products).length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (BuildContext context, int i) {
                        final product = getFilteredProducts(products)[i];
                        return ProductCard(product: product);
                      },
                    ),
                  ),
                ],
              );
            } else if (data.hasError) {
              return Text("${data.error}");
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
