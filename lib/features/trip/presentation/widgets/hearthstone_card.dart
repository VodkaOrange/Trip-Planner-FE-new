import 'package:ai_trip_planner/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class HearthstoneCard extends StatefulWidget {
  final String? imageUrl; // Made nullable
  final String title;
  final String description;
  final VoidCallback? onTap;

  const HearthstoneCard({
    super.key,
    this.imageUrl,
    required this.title,
    required this.description,
    this.onTap,
  });

  @override
  State<HearthstoneCard> createState() => _HearthstoneCardState();
}

class _HearthstoneCardState extends State<HearthstoneCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _shineController;
  late Animation<double> _shineAnimation;
  late ConfettiController _confettiController;

  double _rotationX = 0;
  double _rotationY = 0;

  @override
  void initState() {
    super.initState();
    _shineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _shineAnimation = Tween<double>(begin: -1.5, end: 1.5).animate(
      CurvedAnimation(parent: _shineController, curve: Curves.easeInOut),
    );

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
    _shineController.repeat();
  }

  @override
  void dispose() {
    _shineController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final localPosition = renderBox.globalToLocal(details.globalPosition);

    final halfWidth = renderBox.size.width / 2;
    final halfHeight = renderBox.size.height / 2;

    setState(() {
      _rotationY = (localPosition.dx - halfWidth) / halfWidth * 0.2;
      _rotationX = -(localPosition.dy - halfHeight) / halfHeight * 0.2;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _rotationX = 0;
      _rotationY = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _confettiController.play();
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(_rotationX)
          ..rotateY(_rotationY),
        alignment: FractionalOffset.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Card(
              elevation: 8,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Stack(
                children: [
                  Container(
                    width: 250,
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      // Conditionally set the background
                      image: widget.imageUrl != null
                          ? DecorationImage(
                              image: NetworkImage(widget.imageUrl!),
                              fit: BoxFit.cover,
                            )
                          : null,
                      color: widget.imageUrl == null
                          ? Colors.grey[200]
                          : null,
                    ),
                    // Display a placeholder icon if no image is available
                    child: widget.imageUrl == null
                        ? const Center(
                            child: Icon(
                              Icons.local_activity_outlined,
                              size: 80,
                              color: Colors.grey,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                  color: AppColors.blackWithHigherOpacity,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.title,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      widget.description,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                  // Shine Effect
                  AnimatedBuilder(
                    animation: _shineAnimation,
                    builder: (context, child) {
                      return Positioned.fill(
                        child: Transform.translate(
                          offset: Offset(
                              MediaQuery.of(context).size.width *
                                  _shineAnimation.value,
                              0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  AppColors.white.withOpacity(0.0),
                                  AppColors.white.withOpacity(0.4),
                                  AppColors.white.withOpacity(0.0),
                                ],
                                stops: const [0.4, 0.5, 0.6],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ],
            ),
          ],
        ),
      ),
    );
  }
}
