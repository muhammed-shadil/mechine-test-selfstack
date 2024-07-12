import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDashChat {
  MessageOptions myMessageOptions() {
    return MessageOptions(
      showOtherUsersAvatar: true,
      showOtherUsersName: true,
      containerColor: Colors.white,
      currentUserContainerColor: Color.fromARGB(255, 131, 129, 129),
      currentUserTextColor: const Color.fromARGB(255, 50, 49, 49),
      textColor: const Color.fromARGB(255, 63, 59, 59),
      timeFontSize: 8,
      showTime: true,
      timeFormat: DateFormat('hh:mm a'),
    );
  }

  InputOptions myInputOptions() {
    return const InputOptions(
        inputToolbarPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        inputToolbarStyle: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        textCapitalization: TextCapitalization.sentences,
        inputDecoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          hintText: 'Ask Something...',
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            borderSide: BorderSide(color: Colors.white),
          ),
        ));
  }

  MessageListOptions myMessageListOptions() {
    return MessageListOptions(
      dateSeparatorBuilder: (date) {
        return Row(
          children: [
            const Expanded(
                child: Divider(
              thickness: 0.2,
            )),
            Center(
              child: Text(
                DateFormat('d EEE').format(date).toString(),
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const Expanded(
                child: Divider(
              thickness: 0.2,
            )),
          ],
        );
      },
      separatorFrequency: SeparatorFrequency.days,
    );
  }
}
