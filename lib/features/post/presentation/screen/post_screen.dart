import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instai/core/constants/app_colors.dart';
import 'package:instai/core/presentation/widgets/custom_text_form_filed.dart';
import 'package:instai/core/routing/app_router.gr.dart';
import 'package:instai/core/utils/global_loader.dart';
import 'package:instai/core/utils/hastags_formatter.dart';
import 'package:instai/core/utils/status.dart';
import 'package:instai/features/post/presentation/bloc/post_bloc/post_bloc.dart';
import 'package:instai/service_locator.dart';
import 'package:image_picker/image_picker.dart';

@RoutePage()
class PostScreen extends StatefulWidget implements AutoRouteWrapper {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => getIt<PostBloc>(), child: this);
  }
}

class _PostScreenState extends State<PostScreen> {
  late final TextEditingController _descriptionController;
  late final TextEditingController _hashtagsController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
    _hashtagsController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _hashtagsController.dispose();
    super.dispose();
  }

  void _onGenerate() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final description = _descriptionController.text.trim();
    final hashtags = _hashtagsController.text
        .split(RegExp(r'\s+'))
        .map((e) => e.replaceAll('#', '').trim())
        .where((e) => e.isNotEmpty)
        .toList();
    BlocProvider.of<PostBloc>(context).add(
      SubmitGenerateEvent(description: description, hashtags: hashtags),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create post")),
      body: MultiBlocListener(
        listeners: [
          BlocListener<PostBloc, PostState>(
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
              if (state.status == Status.successfully && state.result != null) {
                context.router.push(PreviewRoute(result: state.result!));
              }
            },
          ),
        ],
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                const SizedBox(height: 16.0),
                Text("Photo", style: TextTheme.of(context).bodyMedium),
                const SizedBox(height: 8.0),
                FormField<Object?>(
                  validator: (_) =>
                      BlocProvider.of<PostBloc>(context).state.photo == null ? "Add a photo" : null,
                  builder: (field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        BlocSelector<PostBloc, PostState, Object?>(
                          selector: (state) => state.photo,
                          builder: (context, photo) {
                            if (photo == null) {
                              return GestureDetector(
                                onTap: () => BlocProvider.of<PostBloc>(context).add(
                                  const PickImageEvent(source: ImageSource.gallery),
                                ),
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: AppColors.gray.withAlpha(50),
                                      borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.add_photo_alternate, color: AppColors.gray, size: 24.0),
                                          const SizedBox(width: 12.0),
                                          Text("Tap to select a photo", style: TextTheme.of(context).bodyMedium),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }

                            return Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Image.file(
                                      BlocProvider.of<PostBloc>(context).state.photo!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        onPressed: () => BlocProvider.of<PostBloc>(context)
                                            .add(const RemoveImageEvent()),
                                        icon: const Icon(Icons.delete_outline),
                                        label: const Text("Delete"),
                                      ),
                                    ),
                                    const SizedBox(width: 12.0),
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        onPressed: () => BlocProvider.of<PostBloc>(context).add(
                                          const PickImageEvent(source: ImageSource.gallery),
                                        ),
                                        icon: const Icon(Icons.refresh),
                                        label: const Text("Replace"),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                        if (field.errorText != null) ...[
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text(
                            field.errorText!,
                            style: const TextStyle(color: Colors.redAccent, fontSize: 12.0),
                          ),],
                          )
                        ],
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16.0),
                Text("Description", style: TextTheme.of(context).bodyMedium),
                const SizedBox(height: 8.0),
                CustomTextFormFiled(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  hintText: "Beautiful sunset at the beach with palm trees",
                  controller: _descriptionController,
                  minLines: 5,
                  maxLines: null,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return "Enter description";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Text("Hashtags", style: TextTheme.of(context).bodyMedium),
                const SizedBox(height: 8.0),
                CustomTextFormFiled(
                  hintText: "#sunset #beach #nature",
                  controller: _hashtagsController,
                  maxLines: 1,
                  inputFormatters: [HashtagTextInputFormatter()],
                  validator: (v) {
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Text("Caption length", style: TextTheme.of(context).bodyMedium),
                const SizedBox(height: 8.0),
                BlocSelector<PostBloc, PostState, CaptionSize>(
                  selector: (state) => state.captionSize,
                  builder: (context, size) {
                    return SegmentedButton<CaptionSize>(
                      segments: const [
                        ButtonSegment(
                          value: CaptionSize.short,
                          label: Text('Short'),
                        ),
                        ButtonSegment(
                          value: CaptionSize.medium,
                          label: Text('Medium'),
                        ),
                        ButtonSegment(
                          value: CaptionSize.long,
                          label: Text('Long'),
                        ),
                      ],
                      selected: <CaptionSize>{size},
                      onSelectionChanged: (s) => BlocProvider.of<PostBloc>(context)
                          .add(ChangeCaptionSizeEvent(s.first)),
                      showSelectedIcon: false,
                    );
                  },
                ),
                const SizedBox(height: 24.0),
                GestureDetector(
                  onTap: _onGenerate,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: AppColors.gradientColors,
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(padding: const EdgeInsets.symmetric(vertical: 12.0), child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.auto_awesome, color: AppColors.white),
                        const SizedBox(width: 12.0),
                        Text("Generate", style: TextTheme.of(context).bodyMedium?.copyWith(color: AppColors.white)),
                      ],
                    ),),
                  ),
                )
              ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


