import 'package:fempinya3_flutter_app/core/utils/datetime_utils.dart';
import 'package:fempinya3_flutter_app/features/events/domain/entities/event.dart';
import 'package:fempinya3_flutter_app/features/events/domain/entities/event_member_comment.dart';
import 'package:fempinya3_flutter_app/features/events/presentation/bloc/event_view/event_view_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fempinya3_flutter_app/core/theme_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventMemberCommentsScreen extends StatelessWidget {
  final EventEntity event;

  const EventMemberCommentsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {    
    final translate = AppLocalizations.of(context)!;

    final textController = TextEditingController();

    return Scaffold(
        //drawer: const MenuWidget(),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
                child: CustomScrollView(
              slivers: [
                CommentScreenHeader(translate: translate),
                CommentScreenTextForm(textController: textController, translate: translate),
                CommentScreenTextButton(textController: textController, translate: translate),
                const CommentScreenCommentsList(),                
              ],
            ))));
  }
}

class CommentScreenCommentsList extends StatelessWidget {
  const CommentScreenCommentsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: BlocBuilder<EventViewBloc, EventViewState>(
            builder: (context, state){
              if (state is EventViewInitial) {
                return Container();
              }
              return SizedBox(
                  width: MediaQuery.of(context)
                      .size
                      .width, // Ajusta al ancho de la pantalla
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: (state.event?.comments ?? []).length,
                    itemBuilder: (context, index) {
                      return CommentCard(
                        comment: (state.event?.comments ?? [])
                            .reversed
                            .toList()[index]);
                    },
                  ),
                );
            },
          ),
      ),
    );
  }
}

class CommentScreenTextButton extends StatelessWidget {
  const CommentScreenTextButton({
    super.key,
    required this.textController,
    required this.translate,
  });

  final TextEditingController textController;
  final AppLocalizations translate;

  void _onSavePressed(BuildContext context, String comment) {
      final translate = AppLocalizations.of(context)!;

      final eventViewBloc = context.read<EventViewBloc>();

      eventViewBloc.add(AddEventMemberComment(comment));
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(translate.commonSnackBarSuccessSaving),
        ),
      );
    }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: TextButton(
            onPressed: () {
              if (textController.text != "") {
                _onSavePressed(context, textController.text);
              }
            },
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primaryFixedDim),
            child: Text(translate.commonSave,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryFixed))),
      ),
    );
  }
}

class CommentScreenTextForm extends StatelessWidget {
  const CommentScreenTextForm({
    super.key,
    required this.textController,
    required this.translate,
  });

  final TextEditingController textController;
  final AppLocalizations translate;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: TextFormField(
            controller: textController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: translate.commentsScreenHintText,
              labelText: translate.commentsScreenLabelText,
              border: const OutlineInputBorder(),
            ),
      )),
    );
  }
}

class CommentScreenHeader extends StatelessWidget {
  const CommentScreenHeader({
    super.key,
    required this.translate,
  });

  final AppLocalizations translate;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 40,
              child: BackButton(),
            ),
            Text(
              translate.commonReturn,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(width: 40),
          ],
        ),
      ),
    );
  }
}


class CommentCard extends StatelessWidget {
  final EventMemberCommentEntity comment;

  const CommentCard({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateTimeUtils.formatDateToHumanLanguage(
                    comment.date, // TO FIX,
                    Localizations.localeOf(context).toString())),
                Text(
                  comment.user,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(comment
                    .comment), // assuming comment.comment is the text of the comment
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: comment.user == 'user'
            ? IconButton(
              icon: const Icon(Icons.delete,),
              onPressed: () {
                // Add your delete logic here
                // For example:
                // deleteComment(comment.id);
              },
            )
            : const SizedBox() ,
          ),
        ],
      ),
    );
  }
}
