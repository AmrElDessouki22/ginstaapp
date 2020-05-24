import 'dart:convert';


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RegisterLogin
{
  String url_local = 'https://ginsta.herokuapp.com';
  String url_local_local = 'http://192.168.1.8:3000';
  Future<http.Response> signup(email,name,password,phone)async
  {
  var url = url_local+'/register';
  print(email.toString());
  var _body = json.encode({'name': name.toString(), 'password': password.toString(),'email':email.toString(),'phone':phone.toString()});
  Map<String,String> headers = {"content-type": "application/json"};
  var response = await http.post(url, body:_body,headers: headers );
  return response;  
  }



  Future signin(password,email) async
  {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = url_local+'/login';
  var _body = json.encode({'password': password.toString(),'email':email.toString()});
  Map<String,String> headers = {"content-type": "application/json"};
  var response = await http.post(url, body:_body,headers: headers );
    if(response.statusCode == 200)
    {
    
      await prefs.setString('token', response.body);
    }
  
  return response;
    
  }



  Future<int> checkuser() async
  {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = url_local+'/checkuser';
  if(prefs.getString('token')==null)
  {
    return 400;
  }
  Map<String,String> headers = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  var response = await http.get(url,headers: headers );
  print(response.statusCode);
  return response.statusCode;
  }

   Future<List> Home() async
  {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = url_local+'/gethome';
  Map<String,String> headers = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  var response = await http.get(url,headers: headers );
  var listy = json.decode(response.body);
  return listy ;
  }
  Future GetUserInfo(user) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = url_local+'/userinfo/'+user;
  Map<String,String> headers = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  var response = await http.get(url,headers: headers );
  var listy = json.decode(response.body);
  return listy ;
  }

  Future Like(user,post) async
  {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = url_local+'/like/'+user+'/'+post;
  Map<String,String> headers = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  var response = await http.post(url,headers: headers );
  return response.statusCode ;
  }
  Future unLike(user,post) async
  {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = url_local+'/unlike/'+user+'/'+post;
  Map<String,String> headers = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  var response = await http.post(url,headers: headers );
  return response.statusCode ;
  }
  Future<List> get_comment(user,post) async
  {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = url_local+'/comment/'+user+'/'+post;
  Map<String,String> headers = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  var response = await http.get(url,headers: headers );
  return json.decode(response.body) ;
  }
  Future add_comment(user,post,comment) async
  {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = url_local+'/comment/'+user+'/'+post;
  Map<String,String> headers = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  var response = await http.post(url,body: json.encode({'comment':comment}),headers: headers );
  return response.statusCode ;
  }
 Future my_info() async
  {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = url_local+'/myinfo';
  Map<String,String> headers = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  var response = await http.get(url,headers: headers );
  return json.decode(response.body) ;
  }
  Future is_my_follow_this(user) async
  {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = url_local+'/checkfollow/'+user;
  Map<String,String> headers = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  var response = await http.get(url,headers: headers );

  return json.decode(response.body) ;
  }
  
  
  Future<List> get_stories() async
  {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = url_local+'/getstories';
  Map<String,String> headers = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  var response = await http.get(url,headers: headers );
  return json.decode(response.body) ;
  }
  Future<List> search(name) async
  {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = url_local+'/search/'+name;
  Map<String,String> headers = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  var response = await http.get(url,headers: headers );
  return json.decode(response.body) ;
  }

   Future get_single_post(post,user) async
  {
   
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = url_local+'/postsingle/'+post+'/'+user;
  Map<String,String> headers = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  var response = await http.get(url,headers: headers );
    print('pooooooost '+post);
    print('pooooooost '+user);
  return json.decode(response.body) ;
  }




   Future<List> friendprofile(user) async
  {
    
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url1 = url_local+'/userinfo/'+user;
  Map<String,String> headers1 = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  var response_user_info = await http.get(url1,headers: headers1 );
  

  var url2 = url_local+'/following/'+user;
  Map<String,String> headers2 = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  var response_user_following = await http.get(url2,headers: headers2 );


   var url3 = url_local+'/followers/'+user;
  Map<String,String> headers3 = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  var response_user_followers = await http.get(url3,headers: headers3 );
  


  var url4 = url_local+'/userposts/'+user;
  Map<String,String> headers4 = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  var response_posts = await http.get(url4,headers: headers4 );

   List full_response = [
     await json.decode(response_user_info.body)
   ,await json.decode(response_user_following.body).length
   ,await json.decode(response_user_followers.body).length
   ,await json.decode(response_posts.body)];
  return full_response ;
  }
   Future<int> unfollow(user) async
  {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = url_local+'/unfollow/'+user;
  Map<String,String> headers = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  var response = await http.post(url,headers: headers );
  return response.statusCode ;
  }
   Future<int> follow(user) async
  {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = url_local+'/follow/'+user;
  Map<String,String> headers = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  var response = await http.post(url,headers: headers );
  return response.statusCode ;
  }

  Future<List> myprofile_info() async
  {
    
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url1 = url_local+'/myinfo';
  Map<String,String> headers1 = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  var response_user_info = await http.get(url1,headers: headers1 );
  

  var url2 = url_local+'/myfollowing';
  Map<String,String> headers2 = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  var response_user_following = await http.get(url2,headers: headers2 );


   var url3 = url_local+'/myfollowers';
  Map<String,String> headers3 = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  var response_user_followers = await http.get(url3,headers: headers3 );
  


  var url4 = url_local+'/myposts';
  Map<String,String> headers4 = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  var response_posts = await http.get(url4,headers: headers4 );

   List full_response = [
     await json.decode(response_user_info.body)
   ,await json.decode(response_user_following.body).length
   ,await json.decode(response_user_followers.body).length
   ,await json.decode(response_posts.body)];
  return full_response ;
  }
  Future<int> addpost(file,caption) async
  {
  Dio dio = new Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = url_local+'/addpost/'+caption;
var photoname = file.path.split('/');
  print(photoname[photoname.length-1]);
    Map<String,dynamic> photo = {"avatar": await MultipartFile.fromFile(file.path,filename: photoname[photoname.length-1],
  contentType: new MediaType("image", "jpg"))};
  FormData formData = FormData.fromMap(photo);
  Map<String,String> headers = {"Content-Type": "multipart/form-data","Authorization": "Bearer "+prefs.getString('token')};
  var response = await dio.post(url, data: formData,options: Options(headers:headers));
  print('here : '+response.statusCode.toString());
  return response.statusCode ;
  }
  Future<int> addstorie(file) async
  {
  Dio dio = new Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = url_local+'/addstorie';
  var photoname = file.path.split('/');
  print(photoname[photoname.length-1]);
  Map<String,dynamic> photo = {"avatar": await MultipartFile.fromFile(file.path,filename: photoname[photoname.length-1],
  contentType: new MediaType("image", "jpeg"))};
  FormData formData = FormData.fromMap(photo);
  Map<String,String> headers = {"Content-Type": "multipart/form-data","Authorization": "Bearer "+prefs.getString('token')};
  var response = await dio.post(url, data: formData,options: Options(headers:headers));
  print('here : '+response.statusCode.toString());
  return response.statusCode ;
  }
  Future<int> logout() async
  {

  var url = url_local+'/logout';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String,String> headers = {"content-type": "application/json","Authorization": "Bearer "+prefs.getString('token')};
  http.Response response = await http.post(url,headers: headers );
  if(response.statusCode==200)
  {
    await prefs.setString('token', '');
  }
  print(response.statusCode);
  return response.statusCode ;
  }
  Future<int> profilepic (file)async
  {
    Dio dio = new Dio();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = url_local+'/addphoto';
  var photoname = file.path.split('/');
  print(photoname[photoname.length-1]);
  Map<String,dynamic> photo = {"avatar": await MultipartFile.fromFile(file.path,filename: photoname[photoname.length-1],
  contentType: new MediaType("image", "jpeg"))};
  FormData formData = FormData.fromMap(photo);
  Map<String,String> headers = {"Content-Type": "multipart/form-data","Authorization": "Bearer "+prefs.getString('token')};
  var response = await dio.post(url, data: formData,options: Options(headers:headers));
  print('here : '+response.statusCode.toString());
  return response.statusCode ;
  }
}
