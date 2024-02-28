import 'package:flash_talk/router.dart';
import 'package:flash_talk/shared_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flash_talk/translation_page.dart';

@RoutePage()
class DecodingPage extends StatefulWidget {
  @override
  _DecodingPageState createState() => _DecodingPageState();
}

class _DecodingPageState extends State<DecodingPage> {
  String constantlyUpdatingText = 'Текст, который обновляется постоянно';
  bool isDecodingFlashesActive = false;
  bool isDecodingBlinksActive = false;
  double sensitivityValue = 25.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Декодирование'),
        automaticallyImplyLeading: false,
      ),
      body: buildDecodingBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: SharedVariables.currentIndex,  // Use the shared variable
        onTap: (index) {
          setState(() {
            SharedVariables.currentIndex = index;  // Update the shared variable
          });

          switch (index) {
            case 0:
              context.router.push(TranslationRoute());
              break;
            case 1:
              context.router.push(DecodingRoute());
              break;
            case 2:
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.translate),
            label: 'Перевод',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.code),
            label: 'Декодирование',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Настройки',
          ),
        ],
      ),
    );
  }

  Widget buildDecodingBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Плейсхолдер 4:3
          const AspectRatio(
            aspectRatio: 4 / 3,
            child: Placeholder(
              color: Colors.grey,
              strokeWidth: 2.0,
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        constantlyUpdatingText,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          // Обнулить constantlyUpdatingText
                          setState(() {
                            constantlyUpdatingText = "";
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.copy),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: constantlyUpdatingText));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Текст скопирован в буфер обмена'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: isDecodingBlinksActive
                    ? null
                    : () {
                  startDecodingBlinks();
                },
                child: Text('Моргания'),
              ),
              ElevatedButton(
                onPressed: isDecodingFlashesActive
                    ? null
                    : () {
                  startDecodingFlashes();
                },
                child: Text('Вспышки'),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          // Добавление слайдера
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Чувствительность ${sensitivityValue.toInt()}м',
              ),
              Slider(
                value: sensitivityValue,
                min: 1.0,
                max: 50.0,
                onChanged: (value) {
                  setState(() {
                    sensitivityValue = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void startDecodingBlinks() {
    setState(() {
      isDecodingBlinksActive = true;
      isDecodingFlashesActive = false; // Останавливаем другую функцию, если активна
    });
    // Добавьте вашу логику для Декодирования морганий
    // При окончании выполнения функции установите isDecodingBlinksActive = false
  }

  void startDecodingFlashes() {
    setState(() {
      isDecodingFlashesActive = true;
      isDecodingBlinksActive = false; // Останавливаем другую функцию, если активна
    });
    // Добавьте вашу логику для Декодирования вспышек
    // При окончании выполнения функции установите isDecodingFlashesActive = false
  }
}