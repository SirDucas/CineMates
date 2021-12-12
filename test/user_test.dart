import 'package:flutter_test/flutter_test.dart';
import 'package:cinemates/database_model/user.dart';

void main () {

  test('User Registration Empty Username String: should be false', () async {
    final bool result = await User().userRegistration('', 'test123@cinemates.com', 'unitTestPassword');

    expect(result, false);
  });

  test('User Registration Empty  String: should be false', () async {
    final bool result = await User().userRegistration('test123', '', 'unitTestPassword');

    expect(result, false);
  });

  test('User Registration Empty Password String: should be false', () async {
    final bool result = await User().userRegistration('test123', 'test123@unitTest.com', '');

    expect(result, false);
  });

  test('User Registration Incorrect Username: should be false', () async {
    final bool result = await User().userRegistration('10', 'test123@unitTest.com', 'unitTestPassword');

    expect(result, false);
  });

  test('User Registration Incorrect Email: should be false', () async {
    final bool result = await User().userRegistration('10', 'email%%673553', 'unitTestPassword');

    expect(result, false);
  });

  test('User Registration Incorrect Password: should be false', () async {
    final bool result = await User().userRegistration('10', 'email%%673553', '123'); //password too short

    expect(result, false);
  });

  test('User Registration Correct Parameters: should be true', () async {
    final bool result = await User().userRegistration('test123', 'test123@unitTest.com', 'unitTestPassword'); //password too short

    expect(result, true);
  });

  test('User Login Empty Username String: should be false', () async {
    final bool result = await User().userLogin('', 'unitTestPassword');

    expect(result, false);
  });

  test('User Login Empty Password String: should be false', () async {
    final bool result = await User().userLogin('test123@unitTest.com', '');

    expect(result, false);
  });

  test('User Login Incorrect Username String: should be false', () async {
    final bool result = await User().userLogin('testdoesnotexists', 'unitTestPassword');

    expect(result, false);
  });

  test('User Login Incorrect Password String: should be false', () async {
    final bool result = await User().userLogin('test123@unitTest.com', 'testdoesnotexists');

    expect(result, false);
  });

  test('User Login Correct Parameters: should be true', () async {
    final bool result = await User().userLogin('test123@unitTest.com', 'unitTestPassword');

    expect(result, true);
  });

  test('User Removing Movie From Favorites List with invalid User ID: shouls be false', () async {
    final bool result = await User().removeMovieFavorite(512195, -5); // id for movie Red Notice from tmdb

    expect(result, false);
  });

  test('User Removing Movie From Favorites List with invalid Movie ID: shouls be true', () async {
    final bool result = await User().removeMovieFavorite(-5, 8); // id of a created test user in our database
    // this test is true because in case of correct USER ID the query will always find something,
    // it just does not remove nothing, in fact there is nothing to remove so it's safe to say that
    // this test and the method implemented can return true in this scenario
    expect(result, true);
  });

  test('User Removing Movie From Favorites List with invalid params: shouls be false', () async {
    final bool result = await User().removeMovieFavorite(-5, -2); //

    expect(result, false);
  });

  test('User Removing Movie From Favorites List Correct Params: shouls be true', () async {
    final bool result = await User().removeMovieFavorite(512195, 8); // id for movie Red Notice from tmdb

    expect(result, true);
  });

  test('Retrieve Multiple Movies Id From Favorites List with invalid User ID: should be empty', () async {
    final List<dynamic> result = await User().retrieveMoviesIdFromFavorites(-7);

    expect(result.isEmpty, true);
  });

  test('Retrieve Multiple Movies Id From Favorites List Correct Params: should contains something', () async {
    final List<dynamic> result = await User().retrieveMoviesIdFromFavorites(8);

    expect(result.isEmpty, false);
  });
}