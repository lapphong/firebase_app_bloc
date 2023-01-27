import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../themes/app_color.dart';
import '../../../themes/text_style.dart';

class UncompletedProgress extends StatelessWidget {
  const UncompletedProgress({
    Key? key,
    this.percent = 0,
    this.percentCompleted = 0,
    this.percentUnCompleted = 0,
  }) : super(key: key);

  final double percent;
  final int percentCompleted, percentUnCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 357,
      decoration: BoxDecoration(
        color: DarkTheme.primaryBlue600,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              'Your Today\'s Progress\nAlmost Done!',
              style: TxtStyle.headline2,
              textAlign: TextAlign.center,
            ),
          ),
          CircularPercentIndicator(
            radius: 70,
            lineWidth: 15,
            percent: percent,
            animation: true,
            animationDuration: 1000,
            progressColor: DarkTheme.white,
            backgroundColor: Colors.black.withOpacity(0.4),
            circularStrokeCap: CircularStrokeCap.round,
            center: Text('${(percent * 100).toStringAsFixed(0)}%',
                style: TxtStyle.percent),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: DarkTheme.primaryBlue900,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RichText(
                    text: TextSpan(
                      text: percentCompleted.toString(),
                      style: TxtStyle.headline3,
                      children: const <TextSpan>[
                        TextSpan(text: ' Completed', style: TxtStyle.headline4),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: VerticalDivider(
                      width: 1,
                      color: DarkTheme.white.withOpacity(0.2),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: percentUnCompleted.toString(),
                      style: TxtStyle.headline3,
                      children: const <TextSpan>[
                        TextSpan(
                            text: ' Uncompleted', style: TxtStyle.headline4),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
