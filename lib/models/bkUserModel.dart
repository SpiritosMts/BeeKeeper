

class BkUser {

  String? id;
  String? email;
  String? name ;
  String? pwd;
  String? joinDate;
  String? coins;
  bool verified;
  bool isAdmin;





  BkUser({
    this.id = 'no-id',
    this.email = 'no-email',
    this.name = 'no-name',
    this.coins = 'no-coins',
    this.isAdmin = false,
    this.joinDate = 'no-join',
    this.verified = false,
    this.pwd  = 'no-pwd',
  });
}


BkUser BkUserFromMap(userDoc){

  BkUser user =BkUser();

  user.id = userDoc.get('id');
  user.isAdmin = userDoc.get('isAdmin');
  user.name = userDoc.get('name');
  user.email = userDoc.get('email');
  user.coins = userDoc.get('coins');
  user.pwd = userDoc.get('pwd');
  user.verified = userDoc.get('verified');
  user.joinDate = userDoc.get('joinDate');

  print('## User_Props_loaded');


  return user;
}

printUser(BkUser user){
  print(
      '#### USER ####'
          '--id: ${user.id} \n'
          '--email: ${user.email} \n'
          '--pwd: ${user.pwd} \n'
          '--name: ${user.name} \n'
          '--isAdmin: ${user.isAdmin} \n'
          '--verified: ${user.verified} \n'
          '--coins: ${user.coins} \n'
          '--joinDate: ${user.joinDate} \n'
  );
}

