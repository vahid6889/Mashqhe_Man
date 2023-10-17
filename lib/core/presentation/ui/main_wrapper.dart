import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mashgh/core/components/custom_text_field.dart';
import 'package:mashgh/core/presentation/widgets/bottom_tool_bar.dart';
import 'package:mashgh/core/utils/geometry/geometry.dart';
import 'package:mashgh/core/utils/storage_operator.dart';
import 'package:uuid/uuid.dart';
import 'package:mashgh/locator.dart';
import 'dart:math' as math;

class MainWrapper extends StatefulWidget {
  static const routeName = "/main_wrapper";

  const MainWrapper({Key? key}) : super(key: key);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final textInputCircleController = TextEditingController();
  // Map of widget positions
  Map<String, Offset> positions = {};
  Map<String, Offset> positionsCircle = {};
  String idCircle = const Uuid().v4();
// Generate unique id for each widget
  String id = const Uuid().v4();

  double prevScale = 1;
  double scale = 1;

  void updateScale(double zoom) => setState(() => scale = prevScale * zoom);
  void commitScale() => setState(() => prevScale = scale);
  void updatePosition(
      {required Offset newPosition, bool? newId, String? oldId}) {
    setState(() {
      // id = (oldId != '' ? oldId : id)!;
      // positions[id] = newPosition;
      positions[oldId!] = newPosition;
      oldId = '';

      if (newId == true) {
        id = const Uuid().v4();
        positions[id] = const Offset(5, 5);
      }
    });
  }

  void updatePositionCircle(Offset newPosition, {bool? newId, String? oldId}) {
    setState(() {
      idCircle = (oldId != '' ? oldId : idCircle)!;
      positionsCircle[idCircle] = newPosition;
      oldId = '';
      if (newId == true) {
        idCircle = const Uuid().v4();
        positionsCircle[idCircle] = const Offset(50, 100);
      }
    });
  }

  @override
  void initState() {
    // checkLoged();
    super.initState();

    // Set initial position
    positions[id] = const Offset(5, 5);
    print(id);
    positionsCircle[idCircle] = const Offset(50, 100);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // final themeData = Theme.of(context);
    // return Container(
    //   color: Colors.white,
    // );
    return Scaffold(
      floatingActionButton: ExpandableFabClass(
        distanceBetween: 80.0,
        subChildren: [
          IconButton(
            onPressed: () => print('ABC'),
            icon: const Icon(Icons.share),
            color: Colors.blue,
          ),
          IconButton(
            onPressed: () => print('TTTT'),
            icon: const Icon(Icons.save),
            color: Colors.blue,
          ),
          IconButton(
            onPressed: () => print('DEF'),
            icon: const Icon(Icons.favorite),
            color: Colors.blue,
          ),
        ],
      ),
      // floatingActionButton: AppFloatingActionButton(
      //   onPressed: () {
      //     // Navigator.push(
      //     //   context,
      //     //   PageRouteBuilder(
      //     //     transitionDuration: const Duration(milliseconds: 250),
      //     //     reverseTransitionDuration: const Duration(milliseconds: 250),
      //     //     pageBuilder: (context, animation, secondaryAnimation) =>
      //     //         const AddTodoPage(),
      //     //     transitionsBuilder:
      //     //         (context, animation, secondaryAnimation, child) {
      //     //       animation =
      //     //           CurvedAnimation(parent: animation, curve: Curves.linear);
      //     //       return SlideTransition(
      //     //         position: Tween<Offset>(
      //     //           begin: const Offset(0, 1),
      //     //           end: Offset.zero,
      //     //         ).animate(animation),
      //     //         child: child,
      //     //       );
      //     //     },
      //     //   ),
      //     // );
      //   },
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      // bottomNavigationBar: const BottomToolBox(),
      // body: const HomePage(),

      body: const BottomToolBar(),
    );
  }

  Future<void> checkLoged() async {
    StorageOperator storageOperator = locator();
    const sessionKey = 'rise_up_session';
    // storageOperator.destroyKey(sessionKey);
    final riseUpSession = storageOperator.pull(sessionKey);

    riseUpSession.then(
      (session) async {
        if (session.isEmpty) {
          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   LoginPage.routeName,
          //   (route) => false,
          // );
        } else {
          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   HomePage.routeName,
          //   (route) => false,
          // );
        }
      },
    );
  }
}

class AppFloatingActionButton extends StatelessWidget {
  const AppFloatingActionButton({Key? key, required this.onPressed})
      : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 100,
          ),
          child: FloatingActionButton(
            onPressed: onPressed,
            child: const Icon(
              Icons.settings_accessibility,
            ),
          ),
        ),
      ],
    );
  }
}

class ExpandableFabClass extends StatefulWidget {
  const ExpandableFabClass({
    Key? key,
    this.isInitiallyOpen,
    required this.distanceBetween,
    required this.subChildren,
  }) : super(key: key);

  final bool? isInitiallyOpen;
  final double distanceBetween;
  final List<Widget> subChildren;

  @override
  _ExpandableFabClassState createState() => _ExpandableFabClassState();
}

class _ExpandableFabClassState extends State<ExpandableFabClass>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _expandAnimationFab;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.isInitiallyOpen ?? false;
    _animationController = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimationFab = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _animationController,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 100,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          clipBehavior: Clip.none,
          children: [
            _buildTapToCloseFab(),
            ..._buildExpandingActionButtons(),
            _buildTapToOpenFab(),
          ],
        ),
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.subChildren.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distanceBetween,
          progress: _expandAnimationFab,
          child: widget.subChildren[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: const Icon(Icons.settings_accessibility),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  _ExpandingActionButton({
    Key? key,
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  }) : super(key: key);

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}
