

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../myConstants.dart';



/// add request to fireStore
Future<void> addDocument({required fieldsMap ,required collName , bool addID=true}) async {
  CollectionReference coll = FirebaseFirestore.instance.collection(collName);

  coll.add(fieldsMap).then((value) async {
    print("### DOC ADDED");

    //add id to doc
    if(addID){
      String docID = value.id;
      //set id
      usersColl.doc(docID).update({
        'id': docID,
      },
      );
    }

  }).catchError((error) {
    print("## Failed to add document: $error");
  });
}


/// delete by url
Future<void> deleteFileByUrlFromStorage(String url) async {
  try {
    await FirebaseStorage.instance.refFromURL(url).delete();
  } catch (e) {
    print("Error deleting file: $e");
  }
}

Future<void> addElementsToList(List newElements, String fieldName, String docID, String collName,{bool canAddExistingElements=true}) async {
  print('## start adding list <$newElements> TO <$fieldName>_<$docID>_<$collName>');

  CollectionReference coll = FirebaseFirestore.instance.collection(collName);

  coll.doc(docID).get().then((DocumentSnapshot documentSnapshot) async {
    if (documentSnapshot.exists) {
      // export existing elements
      List<dynamic>  oldElements = documentSnapshot.get(fieldName);
      print('## oldElements: $oldElements');
      // element to add
      List<dynamic>  elementsToAdd = [] ;
      if(canAddExistingElements){
        elementsToAdd = newElements;
      }else{
        for (var element in newElements) {
          if(!oldElements.contains(element)){
            elementsToAdd.add(element);
          }
        }
      }

      print('## elementsToAdd: $elementsToAdd');
      // add element
      List<dynamic> newElementList = oldElements + elementsToAdd;
      print('## newElementListMerged: $newElementList');

      //save elements
      await coll.doc(docID).update(
        {
          fieldName: newElementList,
        },
      ).then((value) async {
        print('## successfully added list <$elementsToAdd> TO <$fieldName>_<$docID>_<$collName>');
      }).catchError((error) async {
        print('## failure to add list <$elementsToAdd> TO <$fieldName>_<$docID>_<$collName>');
      });
    }else if (!documentSnapshot.exists) {
      print('## docID not existing');
    }
  });
}
Future<void>  removeElementsFromList(List elements, String fieldName, String docID, String collName) async {
  print('## start deleting list <$elements>_<$fieldName>_$docID>_<$collName>');

  CollectionReference coll = FirebaseFirestore.instance.collection(collName);

  coll.doc(docID).get().then((DocumentSnapshot documentSnapshot) async {
    if (documentSnapshot.exists) {
      // export existing elements
      List<dynamic>  oldElements = documentSnapshot.get(fieldName);
      print('## oldElements:(before delete) $oldElements');

      // remove elements from oldElements
      List<dynamic>  elementsRemoved = [];

      for (var element in elements) {
        if(oldElements.contains(element)){
          oldElements.removeWhere((e) => e==element);
          elementsRemoved.add(element);
          //print('# removed <$element> from <$oldElements>');

        }
      }

      print('## oldElements:(after delete) $oldElements');
      await coll.doc(docID).update(
        {
          fieldName: oldElements,
        },
      ).then((value) async {
        print('## successfully deleted list <$elementsRemoved> FROM <$fieldName>_<$docID>_<$collName>');
      }).catchError((error) async {
        print('## failure to delete list <$elementsRemoved> FROM  <$fieldName>_<$docID>_<$collName>');
      });
    }else if (!documentSnapshot.exists) {
      print('## docID not existing');
    }
  });
}

Future<void> emptyItemStringFromCloud(String fieldName, String docID, String collName)async{
  CollectionReference coll = FirebaseFirestore.instance.collection(collName);

  coll.doc(docID).update(
    {
      fieldName: '',
    },
  );
}


addDoc(CollectionReference coll) async {

  Map<String, dynamic> mapToAdd = {
    'null': null,
    'string': 'hajime',
    'number': 4.5,
    'geopoint': const GeoPoint(0.1,4.5),
    //'reference': 'ref',
    'map': {
      'key0':'value0',
      'key1':'value1',
      'key2':'value2',
    },
    'list':[
      'item0',
      'item1',
      'item2',
    ]
  };

  coll.add(mapToAdd).then((value) async {
    String docID = value.id;
    coll.doc(docID).update({
      'id': docID,
    });
    print("### doc added with id:<$docID>");
  }).catchError((e) async {
    print("## Failed to add document: $e");
  });
}

getDocProps(CollectionReference coll,docID)async{
  await coll.doc(docID).get().then((docSnap) {
    num number = docSnap.get('number');
    GeoPoint geoPoint = docSnap.get('geopoint');
    String string = docSnap.get('string');
    Map<String,dynamic> map = docSnap.get('map');
    List list = docSnap.get('list');
    var nullVar = docSnap.get('null');

  }).catchError((e)=>print('## error getting doc with id <$docID>'));




}

clearCollection(CollectionReference coll)async{
  var snapshots = await coll.get();
  for (var doc in snapshots.docs) {
    print('# delete doc<${doc.id}>');
    await doc.reference.delete();
  }
}



Future<List<String>> getDocumentsIDsByFieldName(String fieldName, String filedValue,CollectionReference coll) async {
  QuerySnapshot snap = await coll
      .where(fieldName, isEqualTo: filedValue) //condition
      .get();

  List<String> docsIDs = [];
  final List<DocumentSnapshot> documentsFound = snap.docs;
  for (var doc in documentsFound) {
    docsIDs.add(doc.id);
  }
  print('## docs has [$fieldName=$filedValue] =>$docsIDs');

  return docsIDs;
}

Future<List<DocumentSnapshot>> getDocumentsByColl(CollectionReference coll) async {
  QuerySnapshot snap = await coll.get();

  final List<DocumentSnapshot> documentsFound = snap.docs;

  print('## collection:<${coll.path}> docs length =(${documentsFound.length})');

  return documentsFound;
}

Future<List<DocumentSnapshot>> getDocumentsByCollCondition(CollectionReference coll) async {
  QuerySnapshot snap = await coll.where('accepted',isEqualTo: 'yes').get();

  final List<DocumentSnapshot> documentsFound = snap.docs;

  print('## collection:<${coll.path}> docs length =(${documentsFound.length})');

  return documentsFound;
}

Future<bool> checkDocExist(String docID, coll) async {
  var docSnapshot = await coll.doc(docID).get();

  if(docSnapshot.exists){
    print('## docs with id=<$docID> exists');
  }
  else{
    print('## docs with <id=$docID> NOT exists');

  }
  return docSnapshot.exists;
}
