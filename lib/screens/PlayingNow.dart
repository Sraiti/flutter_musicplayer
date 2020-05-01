import 'package:flutter/material.dart';

class PlayingNow extends StatelessWidget {
  static final String id = "PlayingNow";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1e1e26),
      body: Stack(
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'asset/images/back.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(25.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(150.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.8), BlendMode.dstATop),
                          image: AssetImage("asset/images/artist.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Slider(
                value: 0,
                onChanged: (double value) => null,
                activeColor: Colors.blue,
                inactiveColor: Color(0xFFCEE3EE),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade500.withAlpha(80),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 245,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey.shade600,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: GestureDetector(
                              child: Icon(
                                Icons.fast_rewind,
                                color: Colors.grey.shade200,
                                size: 40,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 100,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: Center(
                                child: AnimatedCrossFade(
                                  duration: Duration(milliseconds: 200),
                                  crossFadeState: CrossFadeState.showSecond,
                                  firstChild: Icon(
                                    Icons.pause,
                                    size: 50,
                                    color: Colors.grey.shade900,
                                  ),
                                  secondChild: Icon(
                                    Icons.play_arrow,
                                    size: 50,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: GestureDetector(
                              child: Icon(
                                Icons.fast_forward,
                                color: Colors.grey.shade200,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.grey.shade500.withAlpha(50),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.pink.shade600,
                    size: 35.0,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
