import 'package:flutter/material.dart';
import 'package:material_design/login.dart';

const double _kFlingVelocity = 2.0;

class Backdrop extends StatefulWidget {
  final Widget backLayer;
  final Widget frontLayer;
  final Widget backTitle;
  final Widget frontTitle;
  const Backdrop(
      {required this.backLayer,
      required this.frontLayer,
      required this.backTitle,
      required this.frontTitle,
      Key? key})
      : super(key: key);

  @override
  State<Backdrop> createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');

  late AnimationController _controller;

  bool get _frontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _controller.fling(
        velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity);
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), value: 1.0, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;

    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
          0.0, layerTop, 0.0, layerTop - layerSize.height),
      end: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_controller.view);

    return Stack(key: _backdropKey, children: <Widget>[
      ExcludeSemantics(
        child: widget.backLayer,
        excluding: _frontLayerVisible,
      ),
      PositionedTransition(
          rect: layerAnimation, child: _FrontLayer(child: widget.frontLayer)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
        elevation: 0.0,
        titleSpacing: 0.0,
        title: _BackdropTitle(
          listenable: _controller.view,
          onPress: _toggleBackdropLayerVisibility,
          frontTitle: widget.frontTitle,
          backTitle: widget.backTitle,
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.search,
                semanticLabel: 'login',
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()));
              }),
          IconButton(
              icon: const Icon(
                Icons.tune,
                semanticLabel: 'login',
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginPage()));
              }),
        ]);

    return Scaffold(
      appBar: appBar,
      body: LayoutBuilder(builder: _buildStack),
    );
  }
}

class _FrontLayer extends StatelessWidget {
  final Widget child;
  const _FrontLayer({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16.0,
      shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(46.0))),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[Expanded(child: child)]),
    );
  }
}

class _BackdropTitle extends AnimatedWidget {
  final void Function() onPress;
  final Widget frontTitle;
  final Widget backTitle;

  const _BackdropTitle({
    required Animation<double> listenable,
    required this.onPress,
    required this.frontTitle,
    required this.backTitle,
    Key? key,
  })  : _listenable = listenable,
        super(key: key, listenable: listenable);

  final Animation<double> _listenable;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = _listenable;

    return DefaultTextStyle(
        style: Theme.of(context).textTheme.headline6!,
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        child: Row(children: <Widget>[
          SizedBox(
              width: 72.0,
              child: IconButton(
                  padding: const EdgeInsets.only(right: 8.0),
                  onPressed: onPress,
                  icon: Stack(children: <Widget>[
                    Opacity(
                        opacity: animation.value,
                        child: const ImageIcon(
                            AssetImage('assets/slanted_menu.png'))),
                    FractionalTranslation(
                        translation: Tween<Offset>(
                          begin: Offset.zero,
                          end: const Offset(1.0, 0.0),
                        ).evaluate(animation),
                        child:
                            const ImageIcon(AssetImage('assets/diamond.png')))
                  ]))),
          Stack(children: <Widget>[
            Opacity(
                opacity: CurvedAnimation(
                        parent: ReverseAnimation(animation),
                        curve: const Interval(0.5, 1.0))
                    .value,
                child: FractionalTranslation(
                    translation: Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(0.5, 0.0),
                    ).evaluate(animation),
                    child: backTitle)),
            Opacity(
                opacity: CurvedAnimation(
                        parent: animation, curve: const Interval(0.5, 1.0))
                    .value,
                child: FractionalTranslation(
                    translation: Tween<Offset>(
                      begin: const Offset(-0.25, 0.0),
                      end: Offset.zero,
                    ).evaluate(animation),
                    child: frontTitle))
          ])
        ]));
  }
}
