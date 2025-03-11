import 'package:flutter/material.dart';

class RecipeRecognitionScreen extends StatefulWidget {
  @override
  _RecipeRecognitionScreenState createState() => _RecipeRecognitionScreenState();
}

class _RecipeRecognitionScreenState extends State<RecipeRecognitionScreen> with SingleTickerProviderStateMixin {
  bool imageUploaded = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 600))..repeat(reverse: true);
    _scaleAnimation = Tween<double>(begin: 1, end: 1.1).animate(_controller);
  }

  void uploadImage() {
    setState(() => imageUploaded = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recipe Recognition")),
      body: Column(
        children: [
          GestureDetector(
            onTap: uploadImage,
            child: AnimatedBuilder(
              animation: _controller,
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
                    scale: _controller,
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
    );
  }
}
