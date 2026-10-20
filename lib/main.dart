import 'package:flutter/material.dart';

void main() => runApp(const BrainKingApp());

const royalBlack = Color(0xFF0B0B0F);
const panelBlack = Color(0xFF17171D);
const royalGold = Color(0xFFFFC857);
const mutedGold = Color(0xFFB88A2E);

class BrainKingApp extends StatelessWidget {
  const BrainKingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brain King',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: royalBlack,
        colorScheme: const ColorScheme.dark(
          primary: royalGold,
          secondary: mutedGold,
          surface: panelBlack,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: royalBlack,
          foregroundColor: royalGold,
          centerTitle: true,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: panelBlack,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF3A3020)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: royalGold, width: 1.5),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const AuthScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF282016), royalBlack, royalBlack],
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.workspace_premium, size: 86, color: royalGold),
            SizedBox(height: 16),
            Text(
              'BRAIN KING',
              style: TextStyle(
                color: royalGold,
                fontSize: 32,
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'THINK • PLAY • CONQUER',
              style: TextStyle(color: Colors.white70, letterSpacing: 1.3),
            ),
            SizedBox(height: 28),
            SizedBox(
              width: 26,
              height: 26,
              child: CircularProgressIndicator(strokeWidth: 2, color: royalGold),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  bool _loginMode = true;
  bool _hidePassword = true;

  @override
  void dispose() {
    _phone.dispose();
    _password.dispose();
    super.dispose();
  }

  void _continueDemo() {
    if (!_formKey.currentState!.validate()) return;
    // Demo navigation only. Firebase authentication is not connected yet.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => HomeScreen(
          displayName: 'Player ${_phone.text.trim()}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.workspace_premium, color: royalGold, size: 60),
                  const SizedBox(height: 8),
                  const Text(
                    'BRAIN KING',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: royalGold,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _loginMode ? 'Welcome back, King' : 'Create your account',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 28),
                  TextFormField(
                    controller: _phone,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Mobile number',
                      prefixIcon: Icon(Icons.phone_android),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().length < 7) {
                        return 'Enter a valid mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _password,
                    obscureText: _hidePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => _hidePassword = !_hidePassword),
                        icon: Icon(_hidePassword ? Icons.visibility : Icons.visibility_off),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.length < 8) {
                        return 'Use at least 8 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: royalGold,
                        foregroundColor: royalBlack,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: _continueDemo,
                      child: Text(
                        _loginMode ? 'LOGIN (DEMO)' : 'SIGN UP (DEMO)',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => setState(() => _loginMode = !_loginMode),
                    child: Text(
                      _loginMode
                          ? "Don't have an account? Sign up"
                          : 'Already have an account? Login',
                      style: const TextStyle(color: royalGold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Prototype screen only — real accounts are not connected yet.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final String displayName;
  const HomeScreen({super.key, required this.displayName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BRAIN KING 👑'),
        actions: [
          IconButton(
            tooltip: 'Profile',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            ),
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF342817), panelBlack],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: mutedGold),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('WELCOME TO THE KINGDOM',
                    style: TextStyle(color: royalGold, fontSize: 12, letterSpacing: 1.2)),
                const SizedBox(height: 8),
                Text(displayName,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 14),
                const Row(
                  children: [
                    Icon(Icons.monetization_on, color: royalGold),
                    SizedBox(width: 8),
                    Text('0 Coins', style: TextStyle(fontWeight: FontWeight.bold)),
                    Spacer(),
                    Icon(Icons.bolt, color: royalGold),
                    SizedBox(width: 4),
                    Text('Level 1'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const Text('PLAY & EXPLORE',
              style: TextStyle(color: royalGold, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _FeatureTile(
            icon: Icons.quiz_outlined,
            title: 'Daily Quiz',
            subtitle: 'Test your knowledge',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const QuizScreen()),
            ),
          ),
          const _FeatureTile(
            icon: Icons.emoji_events_outlined,
            title: 'Leaderboards',
            subtitle: 'Compete with other players',
            onTap: null,
          ),
          const _FeatureTile(
            icon: Icons.people_outline,
            title: 'Friends & Families',
            subtitle: 'Play together and build your team',
            onTap: null,
          ),
          const _FeatureTile(
            icon: Icons.card_giftcard,
            title: 'Gifts & Rewards',
            subtitle: 'Rewards will be connected in a later phase',
            onTap: null,
          ),
          const SizedBox(height: 12),
          const Text(
            'Development prototype: online services and rewards are not active.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: panelBlack,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Color(0xFF332A1C)),
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF332817),
          child: Icon(icon, color: royalGold),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white60)),
        trailing: const Icon(Icons.chevron_right, color: mutedGold),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MY PROFILE')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: Color(0xFF332817),
              child: Icon(Icons.person, size: 52, color: royalGold),
            ),
            SizedBox(height: 14),
            Text('Player', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text('Profile editing will be added in the next phase.',
                style: TextStyle(color: Colors.white60)),
          ],
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, Object>> _questions = const [
    {
      'question': 'Which planet is known as the Red Planet?',
      'options': ['Venus', 'Mars', 'Jupiter', 'Mercury'],
      'answer': 1,
    },
    {
      'question': 'How many sides does a hexagon have?',
      'options': ['Five', 'Six', 'Seven', 'Eight'],
      'answer': 1,
    },
    {
      'question': 'Which is the largest ocean on Earth?',
      'options': ['Atlantic', 'Indian', 'Arctic', 'Pacific'],
      'answer': 3,
    },
  ];

  int _index = 0;
  int _score = 0;
  bool _answered = false;
  int? _selected;

  void _choose(int option) {
    if (_answered) return;
    setState(() {
      _selected = option;
      _answered = true;
      if (option == _questions[_index]['answer']) _score++;
    });
  }

  void _next() {
    if (!_answered) return;
    if (_index == _questions.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => QuizResultScreen(score: _score, total: _questions.length),
        ),
      );
      return;
    }
    setState(() {
      _index++;
      _selected = null;
      _answered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_index];
    final options = q['options'] as List<String>;
    final answer = q['answer'] as int;

    return Scaffold(
      appBar: AppBar(title: const Text('DAILY QUIZ')),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: (_index + 1) / _questions.length,
              color: royalGold,
              backgroundColor: panelBlack,
            ),
            const SizedBox(height: 18),
            Text('QUESTION ${_index + 1} OF ${_questions.length}',
                style: const TextStyle(color: royalGold, letterSpacing: 1.2)),
            const SizedBox(height: 12),
            Text(q['question'] as String,
                style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ...List.generate(options.length, (i) {
              Color? bg;
              if (_answered && i == answer) bg = Colors.green.shade800;
              if (_answered && i == _selected && i != answer) bg = Colors.red.shade800;
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bg ?? panelBlack,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                      side: const BorderSide(color: Color(0xFF3A3020)),
                    ),
                  ),
                  onPressed: () => _choose(i),
                  child: Align(alignment: Alignment.centerLeft, child: Text(options[i])),
                ),
              );
            }),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: royalGold,
                foregroundColor: royalBlack,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: _answered ? _next : null,
              child: Text(_index == _questions.length - 1 ? 'FINISH QUIZ' : 'NEXT QUESTION'),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizResultScreen extends StatelessWidget {
  final int score;
  final int total;
  const QuizResultScreen({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QUIZ RESULT')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.emoji_events, color: royalGold, size: 82),
              const SizedBox(height: 18),
              const Text('WELL PLAYED!',
                  style: TextStyle(color: royalGold, fontSize: 24, fontWeight: FontWeight.w900)),
              const SizedBox(height: 12),
              Text('$score / $total correct',
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('This demo quiz does not issue real coins or XP.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white60)),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: royalGold,
                  foregroundColor: royalBlack,
                ),
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                child: const Text('BACK TO HOME'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
