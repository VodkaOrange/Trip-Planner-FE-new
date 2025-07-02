import 'package:ai_trip_planner/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class HearthstoneCard extends StatefulWidget {
  final String? imageUrl;
  final String title;
  final String description;
  final VoidCallback? onTap;
  final double? price; // New field for price
  final double? duration; // New field for duration

  const HearthstoneCard({
    super.key,
    this.imageUrl,
    required this.title,
    required this.description,
    this.onTap,
    this.price,
    this.duration,
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
        ConfettiController(duration: const Duration(seconds: 3));
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
      onTap: () async {
        _confettiController.play();
        await Future.delayed(const Duration(milliseconds: 500));
        if (mounted && widget.onTap != null) {
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
                      image: widget.imageUrl != null
                          ? DecorationImage(
                              image: NetworkImage(widget.imageUrl!),
                              fit: BoxFit.cover,
                            )
                          : null,
                      gradient: widget.imageUrl == null
                          ? LinearGradient(
                              colors: [
                                Theme.of(context).primaryColor.withOpacity(0.7),
                                Theme.of(context).primaryColor,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: widget.imageUrl == null
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.end,
                      children: [
                        if (widget.imageUrl == null)
                          const Center(
                            child: Icon(
                              Icons.local_activity_outlined,
                              size: 80,
                              color: AppColors.white,
                            ),
                          ),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                  // Price and Duration Pills
                  if (widget.price != null)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: _buildInfoPill(
                        icon: Icons.euro_symbol,
                        text: widget.price!.toStringAsFixed(0),
                      ),
                    ),
                  if (widget.duration != null)
                    Positioned(
                      top: 12,
                      right: 12,
                      child: _buildInfoPill(
                        icon: Icons.timer_outlined,
                        text: '${widget.duration}h',
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

  Widget _buildInfoPill({required IconData icon, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.white, size: 16),
          const SizedBox(width: 4),
          Text(text,
              style:
                  const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
