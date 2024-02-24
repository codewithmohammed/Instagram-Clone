import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instragram_clone/resources/auth_method.dart';
import 'package:instragram_clone/responsive/mobile_screen_layout.dart';
import 'package:instragram_clone/responsive/responsive_layout_screen.dart';
import 'package:instragram_clone/responsive/web_screen_layout.dart';
import 'package:instragram_clone/utils/colors.dart';
import 'package:instragram_clone/utils/utils.dart';
import 'package:instragram_clone/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _bioController = TextEditingController();
  final _usernameController = TextEditingController();
  Uint8List? _image;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void signUpUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);
    if (res != 'success') {
      showSnackBar(context, res);
    } else {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout(),
        );
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(flex: 2, child: Container()),
            // svg image
            SvgPicture.asset(
              'assets/images/instagram-wordmark.svg',
              colorFilter:
                  const ColorFilter.mode(primaryColor, BlendMode.srcIn),
              height: 64,
            ),
            const SizedBox(height: 64),

            // circular widget to accept and show our selected file
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1555952517-2e8e729e0b44?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      ),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo)))
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            //Text Field input for username
            TextFieldInput(
              hintText: 'Enter Your Username',
              textInputType: TextInputType.emailAddress,
              textEditingController: _usernameController,
            ),
            const SizedBox(
              height: 24,
            ),
            //Text Field input for email
            TextFieldInput(
              hintText: 'Enter Your Email',
              textInputType: TextInputType.emailAddress,
              textEditingController: _emailController,
            ),
            const SizedBox(
              height: 24,
            ),
            // Text field input for password
            TextFieldInput(
              hintText: 'Enter Your Password',
              isPass: true,
              textInputType: TextInputType.text,
              textEditingController: _passwordController,
            ),
            const SizedBox(
              height: 24,
            ),
            //Text Field input for bio
            TextFieldInput(
              hintText: 'Enter Your Bio',
              textInputType: TextInputType.emailAddress,
              textEditingController: _bioController,
            ),
            const SizedBox(
              height: 24,
            ),
            const SizedBox(height: 24),
            // button login
            InkWell(
              onTap: signUpUser,
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          color: blueColor),
                      child: const Text('Sign up'),
                    ),
            ),
            const SizedBox(
              height: 12,
            ),
            Flexible(flex: 2, child: Container()),

            // Transitioning to signing up
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text("Don;t have an account"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Login in",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
