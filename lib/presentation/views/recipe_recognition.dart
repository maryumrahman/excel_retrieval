import 'package:flutter/material.dart';

class RecipeRecognitionScreen extends StatefulWidget {
  @override
  _RecipeRecognitionScreenState createState() => _RecipeRecognitionScreenState();
}

class _RecipeRecognitionScreenState extends State<RecipeRecognitionScreen> with TickerProviderStateMixin {
  bool imageUploaded = false;
  late AnimationController _controller1;
  late Animation<double> _scaleAnimation;


  late AnimationController _controller2;
  late Animation<double> _fadeInAnimation;


  @override
  void initState() {

    _controller2 = AnimationController(duration: Duration(seconds: 2), vsync: this);
    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller2);
    _controller2.forward();


    super.initState();
    _controller1 = AnimationController(vsync: this, duration: Duration(milliseconds: 4000))..repeat(reverse: true);
    _scaleAnimation = Tween<double>(begin: 1, end: 1.1).animate(_controller1);
  }

  void uploadImage() {
    setState(() => imageUploaded = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

        body:    Stack(
          children: [
            Positioned.fill(
              child: Image.asset('assets/background.jpg',fit: BoxFit.contain
                ,
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,),
                GestureDetector(
                  onTap: uploadImage,
                  child: AnimatedBuilder(
                    animation: _controller1,
                    builder: (context, child) {
                      return Transform.scale(scale: _scaleAnimation.value, child: child);
                    },
                    child: Icon(Icons.camera_alt, size: 80, color: Colors.orange),
                  ),
                ),
                if (imageUploaded)
                  TweenAnimationBuilder(
                    tween: Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)),
                    duration: Duration(milliseconds: 500),
                    builder: (context, Offset offset, child) {
                      return Transform.translate(offset: offset, child: child);
                    },
                    child: Text("🍕 Detected: Pizza", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                if (imageUploaded)
                  Expanded(
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (_, index) {
                        return ScaleTransition(
                          scale: _controller1,
                          child: Card(
                            child: ListTile(
                              title: Text(["Margherita", "Pepperoni", "BBQ Chicken"][index]),
                              trailing: Icon(Icons.arrow_forward),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ],
        ),
            );
  }
}
