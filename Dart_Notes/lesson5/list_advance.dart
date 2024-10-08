// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../lesson4/class_extends.dart';

void main(List<String> args) {
  //? arabaları tutan carItems listesi:
  final carItems = [
    CarModel(
        category: CarModels.kia,
        name: 'Sportage',
        money: 100000,
        isSecondHand: false),
    CarModel(category: CarModels.mercedes, name: 'S450 d', money: 400000),
    CarModel(
        category: CarModels.bmw,
        name: '320',
        money: 200000,
        isSecondHand: false),
    CarModel(category: CarModels.audi, name: 'Q8', money: 500000),
    CarModel(
        category: CarModels.kia,
        name: 'Stonic',
        money: 150000,
        isSecondHand: false),
  ];

  //* Bu arabaların kac tanesi 2. el? Hesaplamak için farklı bir yöntem kullanalım:
  //! any (var mı için kullanılır) - where (kaç tane için kullanılır) - contains
  final resultCount =
      carItems.where((element) => element.isSecondHand == true).length;
  //!Bu kod listedeki isSecondHand == true sayısını döndürür.
  print(resultCount);

  //? *************************************************************************
  //? *************************************************************************
  //? *************************************************************************
  //? *************************************************************************

  //* Yeni bir araba geldi, bizde var mı kontrol edelim.

  //? Yeni bir araba ekleyelim
  final newCar = CarModel(
    category: CarModels.mercedes,
    name: 'S450 d',
    money: 400000,
  );

  final isHaveCar = carItems.contains(newCar);
  //! carItems içinde newCar'ın aynısından var mı?
  //! Fakat doğru sonuç için CarModel sınıfının equality'sini oluşturmamız gerekir.
  //! Bunu bir sınıf propertysi üzerinde ctrl/command + . ile yapabiliriz.

  if (isHaveCar) {
    print('Elimizde var');
  } else {
    print('Elimizde yok.');
  }

  //? *************************************************************************
  //? *************************************************************************
  //? *************************************************************************
  //? *************************************************************************

  //* Markası bmw olan money'i 20 den bürük olan arabaların modelini yazdır:

  final resultBmwMore20 = carItems.where((element) {
    return element.category == CarModels.bmw && element.money > 20;
  }).join();
  //? Join ile tostring'e çevirmiş oluruz.
  //! CarModel sınıfında ise tostring için override işlemini aşağıdaki ginbi yaparak,
  //! model ve fiyatın dönmesini sağlarız:
  //  @override
  // String toString() {
  //   return '$name - $money';
  // }

  print(resultBmwMore20);

  //? *************************************************************************
  //? *************************************************************************
  //? *************************************************************************
  //? *************************************************************************

  //* Sadece isimleri yan yana göstereim.

  //? map yapmak bundan yeni bir obje üretmek anlamına gelir.
  final carNames = carItems.map((e) => e.name).join(' - ');
  //! Burada map ile yeni bir obje oluşturduk ve join ile bunları toString'e çevirerek ekranda araç isimlerini yazdırdık.
  print(carNames);

  //? *************************************************************************
  //? *************************************************************************
  //? *************************************************************************
  //? *************************************************************************

  //* Elimizde mercedes var mı kontrol edelim:
  //? Bunun için where ve singleWhere kullanabiliriz.
  //! Where -> elimizde olanları kontrol eder.
  //! singleWhere -> elimizde olanları kontrol eder fakat 1 tane olması yeterlidir.
  try {
    final mercedesCar = carItems
        .singleWhere((element) => element.category == CarModels.mercedes);
    print('Elimizde Mercedes var. ( Mercedes $mercedesCar )');
  } catch (e) {
    print('Elimizde bu araç yok.');
  } finally {
    //? try catch'ten sonra çalışır.
    print('Bu islem tamamlandı (Finally)');
  }

  //! Şimdi elimizde mercedes araç olmaması durumunda hata alacağız.
  //! Bu tür hatalar için try catch kullanmamız gereklidir.

  //? *************************************************************************
  //? *************************************************************************
  //? *************************************************************************
  //? *************************************************************************

  //*Yeni gelen bir arabanın kaçıncı sırada olduğunu bulmak için:
  final index = carItems.indexOf(newCar);
  print(index); //! bize arabanın index numarasını verir.

  //? *************************************************************************
  //? *************************************************************************
  //? *************************************************************************
  //? *************************************************************************

//* yeni arabayı eklemek:

  carItems
      .add(CarModel(category: CarModels.audi, name: 'rs6', money: 50000000));

  //? *************************************************************************
  //? *************************************************************************
  //? *************************************************************************
  //? *************************************************************************

//* Arabalari küçükten büyüğe sıralama:
  carItems.sort((first, second) => first.money.compareTo(second.money));
  //! burada first ve second belirlenir. bunlar birbiri arasında kıyaslanır (compareTo).
  print(carItems);

  //? *************************************************************************
  //? *************************************************************************
  //? *************************************************************************
  //? *************************************************************************

  //* Bütün arabalari user listesinden yapalim: (Expand: buradaki işlevi iki listeyi biribirine ekleyip kullanma)

  final users = carItems.expand((element) => element.users).toList();
  //? burada carItems'i users'a expand ettik. artık user türünde
  print(users);

  //? *************************************************************************
  //? *************************************************************************
  //? *************************************************************************
  //? *************************************************************************

  //* Son ekleneni silme  (removeLast  metodu ile yapilir)
  //* bmw olan ve 30 dan düşük olanları silme
  // carItems.removeWhere(
  //   (element) => element.category == CarModels.bmw || element.money < 30,
  // );
  // print(carItems);

  //? *************************************************************************
  //? *************************************************************************
  //? *************************************************************************
  //? *************************************************************************

  print(carItems); //* metottan önce
  calculateToUser([...carItems]); //* ayrı bir liste yapar
  print(carItems); //* metottan sonra
  //! calculateToUser metodundan sonra bmw markalar yamaha ile degisir.
}

//* İtemleri düzelt bmw olanları yamaha yap, tüm ikinci elleri false yap
//* itemlerin core değeri üzerinde degisiklik yapar

void calculateToUser(List<CarModel> items) {
  final newItems = items.map((CarModel e) {
    if (e.category == CarModels.bmw) {
      e.category = CarModels.yamaha;
    }

    if (e.isSecondHand) {
      e.isSecondHand = false;
    }
    return e;
  }).toList();
  print('***************');
  print(newItems);
}

//! Model Sınıfı:

class CarModel {
  CarModels category;
  final String name;
  final double money;
  String? city;
  bool isSecondHand;

  List<User> users;
  CarModel(
      {required this.category,
      required this.name,
      required this.money,
      this.city,
      this.isSecondHand = true,
      this.users = const []});

  @override
  bool operator ==(covariant CarModel other) {
    if (identical(this, other)) return true;

    return other.category == category &&
        other.name == name &&
        other.money == money &&
        other.city == city &&
        other.isSecondHand == isSecondHand;
  }

  @override
  int get hashCode {
    return category.hashCode ^
        name.hashCode ^
        money.hashCode ^
        city.hashCode ^
        isSecondHand.hashCode;
  }

  @override
  String toString() {
    return '$name - $money';
  }
}

enum CarModels {
  bmw,
  mercedes,
  audi,
  kia,
  toyota,
  yamaha;
}
