class recipeModel {
  // late means that these parameters can be assigned later on
  late String? appUrl;
  late String? label;
  late String? appImageurl;
  late double? appCalories;

  recipeModel(
      {this.label,
      this.appCalories,
      this.appImageurl,
      this.appUrl}); // { when you use this it means these paramters are not neccassary to be provided } in case you want any paramter to always provided use required

// a factory constructor is invoked using the class name itself. Factory constructors are responsible for creating and returning an instance of the class, but they might not always create a new instance. They could reuse an existing instance, return a subclass instance, or perform other custom logic.

// The fromMap function you mentioned earlier appears to be a factory constructor used to create an instance of a class from a Map of data. This is commonly used when working with data serialization and deserialization, especially when converting data between different formats, such as JSON or database records, and class instances.

// The purpose of a fromMap factory constructor is to take the data in the form of a Map and use it to initialize the properties of an instance of the class. This is particularly useful when you want to create instances of a class from data that is received from an external source, like an API response.
  factory recipeModel.fromMap(Map recipe) {
    return recipeModel(   // return instance of class without creating 
        label: recipe['label'],
        appCalories: recipe['calories'],
        appImageurl: recipe['image'],
        appUrl: recipe['url']);
  }
}
