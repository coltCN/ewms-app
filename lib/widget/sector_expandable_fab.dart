import 'dart:math';

import 'package:flutter/material.dart';

class SectorExpandableFab extends StatefulWidget {
  const SectorExpandableFab({super.key, required this.children});

  final List<Widget> children;

  @override
  State<SectorExpandableFab> createState() => _SectorExpandableFabState();
}

class _SectorExpandableFabState extends State<SectorExpandableFab>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
      reverseDuration: const Duration(milliseconds: 275),
    );
    _animation = CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn);
    _controller?.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller?.forward();
      } else {
        _controller?.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [..._buildActionButtons(), _buildTapFab()],
      ),
    );
  }

  Widget _buildTapFab() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Transform.rotate(
        angle: _animation!.value * pi * (3 / 4),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          height: _isExpanded ? 50 : 60,
          width: _isExpanded ? 50 : 70,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _toggle,
              borderRadius: BorderRadius.circular(35),
              child: Icon(
                Icons.add,
                color: Colors.black,
                size: 35,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActionButtons() {
    final List<Widget> children = [];
    final count = widget.children.length;
    final step = 120.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees + 30,
          maxDistance: 112, //widget.distance,
          progress: _animation!,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildActionButton(Widget child, int i) {
    return AnimatedAlign(
      duration: _isExpanded
          ? Duration(milliseconds: 250)
          : Duration(milliseconds: 350),
      alignment: _isExpanded
          ? Alignment(
              -0.3 + (i * 0.25),
              0.9 - (i / (widget.children.length - 1)) * 0.5,
            )
          : Alignment.bottomCenter,
      curve: _isExpanded ? Curves.elasticOut : Curves.easeIn,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 275),
        curve: _isExpanded ? Curves.easeOut : Curves.easeIn,
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(40)),
        child: widget.children[i],
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final centerX = MediaQuery.of(context).size.width / 2 - 20.0;
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: centerX + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * pi / 2,
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
