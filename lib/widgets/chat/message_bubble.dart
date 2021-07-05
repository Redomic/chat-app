import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String username;
  final String userImage;
  final bool isUser;
  final Key key;

  MessageBubble(
      this.message,
      this.username,
      this.userImage,
      this.isUser,
      {required this.key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isUser) UserLogo(isUser, userImage),
        Container(
          child: Column(
            crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                child: Text(
                  username,
                  style: TextStyle(
                    color: isUser
                        ? Theme.of(context).accentColor
                        : Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: isUser
                      ? Theme.of(context).accentColor
                      : Theme.of(context).primaryColor,
                  borderRadius: isUser
                      ? BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        )
                      : BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                ),
                constraints: BoxConstraints(
                  maxWidth: 250,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 12,
                ),
                child: Text(
                  message,
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.85),
                    fontSize: 16,
                  ),
                  textAlign: isUser ? TextAlign.end : TextAlign.start,
                ),
              ),
            ],
          ),
        ),
        if (isUser) UserLogo(isUser, userImage),
      ],
    );
  }
}

class UserLogo extends StatelessWidget {
  final String userImage;
  final bool isUser;

  UserLogo(this.isUser, this.userImage);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: isUser
            ? Theme.of(context).accentColor
            : Theme.of(context).primaryColor,
        backgroundImage: NetworkImage(userImage),
      ),
    );
  }
}
