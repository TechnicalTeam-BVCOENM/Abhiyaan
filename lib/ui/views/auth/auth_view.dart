import 'package:darpan/file_exporter.dart';
part 'auth_view_model.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthViewModel>.reactive(
      viewModelBuilder: () => AuthViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: const Color.fromRGBO(236, 236, 255, 1),
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 130,
                  backgroundColor: Colors.white,
                ),
                const Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 35,
                      color: Color.fromRGBO(113, 110, 237, 1),
                      fontWeight: FontWeight.w900),
                ),
                const SizedBox(
                  height: 70,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        borderSide: BorderSide.none),
                    fillColor: Colors.white,
                    filled: true,
                    focusColor: Colors.white,
                    hintText: 'Student Email ID',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        borderSide: BorderSide.none),
                    fillColor: Colors.white,
                    filled: true,
                    focusColor: Colors.white,
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 10),
                    child: Text(
                      'Forget password?',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(113, 110, 237, 1)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
                  child: TextButton(
                    onPressed: () {
                      model.toHomePage(context);
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 50)),
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(113, 110, 237, 1),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Problem with sign in? ',
                      style: TextStyle(fontSize: 15, color: Colors.black54),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Report issue',
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(113, 110, 237, 1)),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
