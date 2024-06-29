// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:quran_app/controller/cubit/verse_cubit.dart';

// class AudioPlayerScreen extends StatelessWidget {
//   const AudioPlayerScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // final cubit = BlocProvider.of<VerseCubit>(context);

//     return BlocProvider<VerseCubit>(
//       create: (context) => VerseCubit(),
//       child: Scaffold(
//         body: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ControlButtons(),
//               BlocConsumer<VerseCubit, VerseState>(
//                 listener: (context, state) {
//                   if (state is AduioPlaying) {
//                     // BlocProvider.of<VerseCubit>(context).seek(
//                     //     BlocProvider.of<VerseCubit>(context).player.position);
//                   }
//                 },
//                 builder: (context, state) {
//                   if (state is AudioPlayerLoaded) {
//                     return SeekBar(
//                       duration: state.duration,
//                       position: state.position,
//                       bufferedPosition: state.bufferedPosition,
//                       onChangeEnd: (newPosition) {
//                         context.read<VerseCubit>().seek(newPosition);
//                       },
//                     );
//                   } else if (state is AudioPlayerError) {
//                     return Text('Error: ${state.message}');
//                   } else {
//                     return const CircularProgressIndicator();
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ControlButtons extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final cubit = BlocProvider.of<VerseCubit>(context);

//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         IconButton(
//           icon: const Icon(Icons.skip_previous),
//           iconSize: 64.0,
//           onPressed: cubit.seekToPrevious,
//         ),
//         IconButton(
//           icon: const Icon(Icons.volume_up),
//           onPressed: () {
//             final state = context.read<VerseCubit>().state;
//             if (state is AudioPlayerLoaded) {
//               showSliderDialog(
//                 context: context,
//                 title: "Adjust volume",
//                 divisions: 10,
//                 min: 0.0,
//                 max: 1.0,
//                 value: state.volume,
//                 onChanged: cubit.setVolume,
//               );
//             }
//           },
//         ),
//         BlocBuilder<VerseCubit, VerseState>(
//           builder: (context, state) {
//             if (state is AudioPlayerLoaded) {
//               if (cubit.player.playing) {
//                 return IconButton(
//                   icon: const Icon(Icons.pause),
//                   iconSize: 64.0,
//                   onPressed: cubit.pause,
//                 );
//               } else {
//                 return IconButton(
//                   icon: const Icon(Icons.play_arrow),
//                   iconSize: 64.0,
//                   onPressed: cubit.play,
//                 );
//               }
//             } else {
//               return const CircularProgressIndicator();
//             }
//           },
//         ),
//         IconButton(
//           icon: const Icon(Icons.speed),
//           onPressed: () {
//             final state = context.read<VerseCubit>().state;
//             if (state is AudioPlayerLoaded) {
//               showSliderDialog(
//                 context: context,
//                 title: "Adjust speed",
//                 divisions: 10,
//                 min: 0.5,
//                 max: 1.5,
//                 value: state.speed,
//                 onChanged: cubit.setSpeed,
//               );
//             }
//           },
//         ),
//         IconButton(
//           icon: const Icon(Icons.skip_next),
//           iconSize: 64.0,
//           onPressed: cubit.seekToNext,
//         ),
//       ],
//     );
//   }
// }

// class SeekBar extends StatelessWidget {
//   final Duration duration;
//   final Duration position;
//   final Duration bufferedPosition;
//   final ValueChanged<Duration>? onChangeEnd;

//   const SeekBar({
//     Key? key,
//     required this.duration,
//     required this.position,
//     required this.bufferedPosition,
//     this.onChangeEnd,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Slider(
//           min: 0.0,
//           max: duration.inMilliseconds.toDouble(),
//           value: position.inMilliseconds
//               .toDouble()
//               .clamp(0.0, duration.inMilliseconds.toDouble()),
//           onChanged: (value) {
//             onChangeEnd?.call(Duration(milliseconds: value.round()));
//           },
//         ),
//         Text(
//           '${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')} / '
//           '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
//         ),
//       ],
//     );
//   }
// }

// void showSliderDialog({
//   required BuildContext context,
//   required String title,
//   required int divisions,
//   required double min,
//   required double max,
//   required double value,
//   required ValueChanged<double> onChanged,
// }) {
//   showDialog<void>(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(title),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Slider(
//               divisions: divisions,
//               min: min,
//               max: max,
//               value: value,
//               onChanged: onChanged,
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_app/controller/cubit/verse_cubit.dart';

class AudioPlayerScreen extends StatelessWidget {
  const AudioPlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VerseCubit>(
      create: (context) => VerseCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ControlButtons(),
              BlocConsumer<VerseCubit, VerseState>(
                listener: (context, state) {
                  if (state is AduioPlaying) {
                    // Handle audio playing state
                  }
                },
                builder: (context, state) {
                  if (state is AudioPlayerLoaded) {
                    return StreamBuilder<PositionData>(
                      stream: state.positionDataStream,
                      builder: (context, snapshot) {
                        final positionData = snapshot.data;
                        return SeekBar(
                          duration: state.duration,
                          position: positionData?.position ?? Duration.zero,
                          bufferedPosition:
                              positionData?.bufferedPosition ?? Duration.zero,
                          onChangeEnd: (newPosition) {
                            context.read<VerseCubit>().seek(newPosition);
                          },
                        );
                      },
                    );
                  } else if (state is AudioPlayerError) {
                    return Text('Error: ${state.message}');
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ControlButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<VerseCubit>(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous),
          iconSize: 64.0,
          onPressed: cubit.seekToPrevious,
        ),
        IconButton(
          icon: const Icon(Icons.volume_up),
          onPressed: () {
            final state = context.read<VerseCubit>().state;
            if (state is AudioPlayerLoaded) {
              showSliderDialog(
                context: context,
                title: "Adjust volume",
                divisions: 10,
                min: 0.0,
                max: 1.0,
                value: state.volume,
                onChanged: cubit.setVolume,
              );
            }
          },
        ),
        BlocBuilder<VerseCubit, VerseState>(
          builder: (context, state) {
            if (state is AudioPlayerLoaded) {
              if (cubit.player.playing) {
                return IconButton(
                  icon: const Icon(Icons.pause),
                  iconSize: 64.0,
                  onPressed: cubit.pause,
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.play_arrow),
                  iconSize: 64.0,
                  onPressed: cubit.play,
                );
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.speed),
          onPressed: () {
            final state = context.read<VerseCubit>().state;
            if (state is AudioPlayerLoaded) {
              showSliderDialog(
                context: context,
                title: "Adjust speed",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                value: state.speed,
                onChanged: cubit.setSpeed,
              );
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.skip_next),
          iconSize: 64.0,
          onPressed: cubit.seekToNext,
        ),
      ],
    );
  }
}

class SeekBar extends StatelessWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChangeEnd;

  const SeekBar({
    Key? key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChangeEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          min: 0.0,
          max: duration.inMilliseconds.toDouble(),
          value: position.inMilliseconds
              .toDouble()
              .clamp(0.0, duration.inMilliseconds.toDouble()),
          onChanged: (value) {
            onChangeEnd?.call(Duration(milliseconds: value.round()));
          },
        ),
        Text(
          '${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')} / '
          '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
        ),
      ],
    );
  }
}

void showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  required double value,
  required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Slider(
              divisions: divisions,
              min: min,
              max: max,
              value: value,
              onChanged: onChanged,
            ),
          ],
        ),
      );
    },
  );
}
