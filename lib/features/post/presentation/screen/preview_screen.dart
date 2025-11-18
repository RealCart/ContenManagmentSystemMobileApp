import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:instai/core/constants/app_colors.dart';
import 'package:instai/core/utils/global_loader.dart';
import 'package:instai/core/utils/status.dart';
import 'package:instai/features/post/domain/entities/generated_post_entity.dart';
import 'package:instai/features/post/presentation/bloc/preview_bloc/preview_bloc.dart';
import 'package:instai/service_locator.dart';
import 'package:instai/core/routing/app_router.gr.dart';

@RoutePage()
class PreviewScreen extends StatelessWidget implements AutoRouteWrapper {
  const PreviewScreen({super.key, required this.result});

  final GeneratedPostEntity result;

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => getIt<PreviewBloc>(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PreviewBloc, PreviewState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status == Status.loading) {
          context.showLoader();
        } else {
          context.hideLoader();
        }
        if (state.status == Status.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error?.errorMessage ?? "")),
          );
        }
        if (state.status == Status.successfully) {
          context.router.replaceAll([const HomeRoute()]);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Preview"),
          leading: IconButton(
            onPressed: () => context.router.pop(),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              children: [
                if (result.tempPhotoUrl != null) ...[
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CachedNetworkImage(
                        imageUrl: result.tempPhotoUrl!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                        errorWidget: (context, url, error) => const ColoredBox(
                          color: Colors.black12,
                          child: Center(child: Icon(Icons.broken_image)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
                Text("Generated description", style: TextTheme.of(context).bodyMedium),
                const SizedBox(height: 8.0),
                Text(result.generatedDescription),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () => BlocProvider.of<PreviewBloc>(context).add(SavePostEvent(result)),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: AppColors.gradientColors,
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cloud_upload_outlined, color: AppColors.white),
                          SizedBox(width: 12.0),
                          Text(
                            "Save",
                            style: TextStyle(color: AppColors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}