# flutter_stylish

This project is assigment of the AppWorks School Flutter program.

## Week 1 Notes

### Error
Encounter the "INSTALL_FAILED_INSUFFICIENT_STORAGE" error, Stop the emulator in the Android Studio AVD Manager, wipe data, and increase the internal storage.

### Adding Image Assets
To add image assets, create a folder "assets/images" in the project, and add the following to the pubspec.yaml file:
```
flutter:
assets:
- assets/images
```

## State Manger

Flutter中有兩種類型的widget，即有狀態的Stateful Widget和無狀態的Stateless Widget。Stateful Widget允許畫面隨著狀態的改變而更新，而Stateless Widget則是靜態的，它們的內容不會改變。

當Stateful Widget的狀態改變時，Flutter框架會使用機制來自動更新widget，而此機制通常是使用setState()函數實現的。setState()函數會通知Flutter框架，要求重新構建widget。這樣，Flutter框架就會從頭到尾重新構建widget，以反映新的狀態。

然而，當擁有許多Stateful Widget和許多子widget時，使用setState()會變得很冗長和難以維護。在這種情況下，使用狀態管理工具可以更好地組織代碼和簡化應用程序的狀態管理。

Flutter中有兩種常見的狀態管理工具，分別是`ValueNotifier`和`Provider`。


---

### ValueNotifier

ValueNotifier是一個簡單的狀態管理工具，它繼承自ChangeNotifier並包含一個值和一個setvalue()函數。每當值改變時，它會通知所有訂閱該值的物件。ValueNotifier在小型應用程序或使用者數據較少的情況下非常有用。

ValueNotifier是一個繼承自ChangeNotifier的簡單狀態管理工具。

ValueNotifier包含一個值和一個setvalue()函數，每當值改變時，它會通知所有訂閱該值的物件。

可以在任何widget中使用ValueNotifier。

透過ValueListenableBuilder建構子，可以監聽ValueNotifier的值異動，並且自動重建UI。


```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // ValueNotifier 可以在任何 widget 中使用，這邊我們在 MyApp 中宣告一個 countNotifier，初始值為 0。
  final ValueNotifier<int> countNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ValueNotifier Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 透過 ValueListenableBuilder 建構子，可以監聽 countNotifier 的值異動，並且自動重建 UI。
              ValueListenableBuilder(
                valueListenable: countNotifier,
                builder: (BuildContext context, int value, Widget? child) {
                  return Text(
                    '$value',
                    style: TextStyle(fontSize: 24),
                  );
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Increment'),
                onPressed: () {
                  // 每當按下按鈕時，透過 setvalue() 函數更新 countNotifier 的值。
                  countNotifier.value++;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

```
* ValueNotifier的優點：
    * 簡單易用
    * 輕量級
    * 可以與ValueListenableBuilder一起使用，以自動更新widget
* ValueNotifier的缺點：
    * 無法將狀態在整個widget樹中傳遞，需要在每個使用ValueNotifier的widget中訂閱該值
    * 當狀態數據變得複雜時，管理它們變得困難



---


### Inherited Widget
Inherited Widget 是 Flutter 中另一個狀態管理工具，它是一種特殊的 Widget，它可以讓其子 Widget 獲取繼承自它的數據，`這些數據在整個 Widget 樹中是共享的`。通常，當應用程序中需要多個 Widget 共享相同的數據時，就可以使用 Inherited Widget。

使用Inherited Widget的基本步驟是：

1. 創建一個繼承自InheritedWidget的新類別。
1. 在該類別中定義您要共享的數據。
1. 實現該類別的of()方法，以便子Widget可以訪問該數據。
1. 將該類別插入到Widget樹中。
1. 在需要訪問該數據的子Widget中調用InheritedWidget.of()方法。
```dart
import 'package:flutter/material.dart';

// 定義一個MyInheritedWidget，繼承自InheritedWidget
class MyInheritedWidget extends InheritedWidget {
  // 定義一個變數，存儲MyInheritedWidget的值
  final String value;

  // 定義構造函數
  MyInheritedWidget({Key key, @required Widget child, @required this.value})
      : super(key: key, child: child);

  // 創建一個靜態的of方法，用於訪問MyInheritedWidget
  static MyInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }

  // 定義一個方法，用於檢查MyInheritedWidget是否需要更新
  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return value != oldWidget.value;
  }
}

// 定義一個MyWidget，繼承自StatelessWidget
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 使用MyInheritedWidget.of方法來訪問MyInheritedWidget
    final inheritedValue = MyInheritedWidget.of(context).value;

    return Container(
      child: Text(inheritedValue),
    );
  }
}

// 定義一個MyApp，繼承自StatefulWidget
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 定義一個變數，存儲MyInheritedWidget的值
  String value = 'Hello World';

  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(
      // 將value值傳入MyInheritedWidget
      value: value,
      child: MaterialApp(
        home: Scaffold(
          body: MyWidget(),
        ),
      ),
    );
  }
}

```

> 在某些情況下，我們可能需要結合使用 ValueNotifier 和 Inherited Widget 來進行狀態管理。例如，當我們需要在整個應用程序中共享一個單一數據模型時，可以使用 ValueNotifier 來管理數據模型，並將該模型傳遞給 Inherited Widget。這樣，在整個 Widget 樹中，我們都可以通過 Inherited Widget 獲取到該數據模型，並通過 ValueNotifier 來更新該模型，從而更新整個應用程序的畫面。
> 

```dart
import 'package:flutter/material.dart';

// 創建一個數據模型，這裡只包含一個數據欄位 count
class MyDataModel {
  int count;
  MyDataModel({required this.count});
}

// 創建一個 Inherited Widget 來傳遞數據模型
class MyInheritedWidget extends InheritedWidget {
  final MyDataModel dataModel;
  final ValueNotifier<int> valueNotifier;
  final Widget child;

  MyInheritedWidget({
    Key? key,
    required this.dataModel,
    required this.valueNotifier,
    required this.child,
  }) : super(key: key, child: child);

  // 用於判斷當前的 Widget 是否為要搜索的 Widget
  static MyInheritedWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();

  // 實現 InheritedWidget 必須實現的方法，這裡直接返回 true 即可
  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) => true;
}

// 創建一個 StatefulWidget，用於更新數據模型中的 count 欄位
class MyButton extends StatefulWidget {
  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    // 從 Inherited Widget 中獲取 ValueNotifier 對象
    final valueNotifier = MyInheritedWidget.of(context)!.valueNotifier;

    return ElevatedButton(
      child: Text("Increase Count"),
      onPressed: () {
        // 更新數據模型中的 count 欄位
        valueNotifier.value++;
      },
    );
  }
}

class InheritedValueNotifierDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 創建一個 ValueNotifier 對象來管理數據模型
    final valueNotifier = ValueNotifier<int>(0);
    // 創建數據模型對象
    final myDataModel = MyDataModel(count: 0);

    return MyInheritedWidget(
      dataModel: myDataModel,
      valueNotifier: valueNotifier,
      // 使用 Builder Widget，以便於獲取 ValueNotifier 對象
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("Inherited ValueNotifier Demo"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Count: ${valueNotifier.value}",
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 16),
                // 使用 MyButton Widget 更新數據模型中的 count 欄位
                MyButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

```



---

### Provider
Provider 是一個 Flutter 狀態管理套件，它可以在 Widget 樹中共享數據，並且適用於中大型 Flutter 應用程式的狀態管理。Provider 的運作方式是在 Widget 樹中建立一個 Provider 物件，該物件存儲著共享的數據模型。然後，我們可以通過 Consumer Widget 或 Provider.of(context) 方法來訪問 Provider 物件並獲取數據。

首先，安裝 Provider 套件。在 pubspec.yaml 文件中添加 provider：
```dart
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
```
在需要共享數據的 Widget 中建立 Provider。
```dart
class MyModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;
  
  void increment() {
    _count++;
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('My App'),
        ),
        body: Consumer<MyModel>(
          builder: (context, myModel, child) {
            return Center(
              child: Text('Count: ${myModel.count}'),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<MyModel>(context, listen: false).increment();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
```
> Provider通過使用“提供者”模式，使跨widget共享數據變得簡單而直觀。它還可以方便地管理不同widget之間的狀態更新，使代碼更加清晰和易於維護。

> 當應用程序變得越來越大時，使用Provider可能會導致代碼變得難以理解和維護。另外，Provider可能會導致過多的重建，從而影響應用程序的性能。



*Reference sources: https://www.kodeco.com/34552040-managing-state-in-flutter and ChatGPT*