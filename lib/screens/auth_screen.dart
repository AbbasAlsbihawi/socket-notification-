
import 'dart:math';

import 'package:e_shopping/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const routeName = '/auth';
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //   colors: [
            //     const Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
            //     const Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
            //   ],
             
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   stops: const [0, 1],
            // )),
        
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 94),
                    transform: Matrix4.rotationZ(-8 * pi / 100)
                      ..translate(-10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 8,
                              color: Colors.black26,
                              offset: Offset(0, 2))
                        ]),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Theme.of(context).backgroundColor,
                          fontSize: 50,
                          fontFamily: 'Anton'),
                    ),
                  )),
                 
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: const AuthCard(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

enum AuthMode { Login, SignUp }

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _passwordFocusNode = FocusNode();
  AuthMode _authMode = AuthMode.Login;
  final Map<String, String> _authDate = {'email': '', 'password': ''};

  var _isLoading = false;
  final _passwordController = TextEditingController();
  AnimationController? _controller;
  Animation<Offset>? _slideAnimation;
  Animation<double>? _opacityAnimation;

  final _emailController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  double _formProgress = 0;

  void _updateFormProgress() {
    var progress = 0.0;
    final controllers = [
      _emailController,
      _passwordController,
      _confirmPasswordController
    ];

    for (final controller in controllers) {
      if (controller.value.text.isNotEmpty) {
        progress += 1 / controllers.length;
      }
    }

    setState(() {
      _formProgress = progress;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.15), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.fastOutSlowIn,
    ));
    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeIn,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false).login(
            _authDate['email'].toString(), _authDate['password'].toString());
      } else {
        await Provider.of<Auth>(context, listen: false).signUP(
            _authDate['email'].toString(), _authDate['password'].toString());
      }
    } catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'The email address is already in use by another account';
      } else if (error.toString().contains('OPERATION_NOT_ALLOWED')) {
        errorMessage = 'Password sign-in is disabled for this project';
      } else if (error.toString().contains('TOO_MANY_ATTEMPTS_TRY_LATER')) {
        errorMessage =
            'We have blocked all requests from this device due to unusual activity. Try again later';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage =
            'There is no user record corresponding to this identifier. The user may have been deleted';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage =
            'The password is invalid or the user does not have a password.';
      } else if (error.toString().contains('USER_DISABLED')) {
        errorMessage =
            'The user account has been disabled by an administrator.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is invalid or the user does not have a email.';
      }

      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _showErrorDialog(String errorMessage) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
      _controller!.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller!.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 8.0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: _authMode == AuthMode.SignUp ? 520 : 460,
        constraints:
            BoxConstraints(minHeight: _authMode == AuthMode.SignUp ? 520 : 460),
        width: deviceSize.width * 0.85,
        padding: EdgeInsets.all(16),
        child: Form(
            onChanged: _updateFormProgress,
            key: _formKey,
            child: Column(
              children: [
                AnimatedProgressIndicator(value: _formProgress),
                TextFormField(
                  
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'E-Mail',
                    hintText: 'Enter your email address',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val!.isEmpty || !val.contains('@')) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _authDate['email'] = val!;
                  },
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                  ),
                  obscureText: true,
                  controller: _passwordController,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: _passwordFocusNode,
                  onFieldSubmitted: (_) => _submit(),
                  validator: (val) {
                    if (val!.isEmpty || val.length < 5) {
                      return 'Password is too short';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    _authDate['password'] = val!;
                  },
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.SignUp ? 60 : 0,
                    maxHeight: _authMode == AuthMode.SignUp ? 120 : 0,
                  ),
                  curve: Curves.easeIn,
                  child: FadeTransition(
                    opacity: _opacityAnimation!,
                    child: SlideTransition(
                      position: _slideAnimation!,
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            labelText: 'Confirm Password'),
                        obscureText: true,
                        enabled: _authMode == AuthMode.SignUp,
                        keyboardType: TextInputType.emailAddress,
                        validator: _authMode == AuthMode.SignUp
                            ? (val) {
                                if (val != _passwordController.text) {
                                  return 'Password do not match';
                                }
                                return null;
                              }
                            : null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color.fromARGB(255, 189, 38, 164),
                                      Color.fromARGB(255, 104, 18, 126),
                                      Color.fromARGB(255, 85, 61, 153),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 16),
                                primary: Colors.white,
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              onPressed: _submit,
                              child: Text(_authMode == AuthMode.Login
                                  ? 'LOGIN'
                                  : 'SIGNUP'),
                            ),
                          ],
                        ),
                      ),
                Flexible(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      // padding: const EdgeInsets.all(16.0),
                      primary: Theme.of(context).primaryColor,
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    onPressed: _switchAuthMode,
                    child: Text(
                        '${_authMode == AuthMode.SignUp ? 'LOGIN' : 'SIGNUP'} INSTEAD'),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class AnimatedProgressIndicator extends StatefulWidget {
  final double value;

  const AnimatedProgressIndicator({
    required this.value,
  });

  @override
  State<StatefulWidget> createState() {
    return _AnimatedProgressIndicatorState();
  }
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _curveAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    final colorTween = TweenSequence([
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.red, end: Colors.orange),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.orange, end: Colors.yellow),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.yellow, end: Colors.green),
        weight: 1,
      ),
    ]);

    _colorAnimation = _controller.drive(colorTween);
    _curveAnimation = _controller.drive(CurveTween(curve: Curves.easeIn));
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.animateTo(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => LinearProgressIndicator(
        value: _curveAnimation.value,
        valueColor: _colorAnimation,
        backgroundColor: _colorAnimation.value?.withOpacity(0.4),
      ),
    );
  }
}