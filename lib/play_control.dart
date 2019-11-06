
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:intl/intl.dart';

class PlayControls extends StatefulWidget {
  final url;

  const PlayControls({Key key, this.url});
  @override
  _PlayControlsState createState() => _PlayControlsState();
}

class _PlayControlsState extends State<PlayControls> {

  FlutterSound _flutterSound;
  double _playPosition,  _duration;
  bool _isPlaying, _isMuted;
  String _pos;

  Stream<PlayStatus> _playerSubscription;

//  String url = "https://mp3bullet.ng/wp-content/uploads/2018/04/ASA_-_Bamidele_Song__Mp3bullet.ng.mp3";
  @override
  void initState() {
    super.initState();
    _isPlaying = false;
    _isMuted = false;
    _flutterSound = FlutterSound();

    _playPosition = 0.0000001;
    _pos = "00:00";
    _duration = 1;

  }

  _play() async{

    print("Playing");

    String path = await _flutterSound.startPlayer(widget.url);


    _playerSubscription = _flutterSound.onPlayerStateChanged..listen((e){
      if(e != null ){
        DateTime date = new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
        String txt = DateFormat('mm:ss', 'en_US').format(date);
        setState(() {
          _duration = e.duration;

          _playPosition = e.currentPosition ;
          _pos = txt;
//            _flutterSound.setVolume(1);
        });

      }
      else{
        setState(() {
//          _duration = e.duration;
//          _playPosition = e.currentPosition ;
          _pos = "00:00";
          _isPlaying = false;
//            _flutterSound.setVolume(1);
        });
      }

    });


  }



  _stop() async{
    await _flutterSound.stopPlayer();
    if (_playerSubscription != null) {
//      _playerSubscription..clear();
      _playerSubscription = null;
    }

  }

  _pause() async{
    await _flutterSound.pausePlayer();
    if (_playerSubscription != null) {
      _playerSubscription = null;
    }

  }

  _fastForward()async{
    _playPosition = _playPosition + 5000 ;
    _flutterSound.seekToPlayer(_playPosition.ceil());
  }


  _rewind()async{
    _playPosition = _playPosition - 5000 ;
    _flutterSound.seekToPlayer(_playPosition.ceil());
  }

  void muteUnMute() {
    _isMuted ?
        _flutterSound.setVolume(1)
        : _flutterSound.setVolume(0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(

            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(_pos.toString()),
              ),
              Flexible(
                child: Slider(
                  onChanged: null,
                  value: _playPosition/_duration,
                  activeColor: Colors.red,
                  inactiveColor: Colors.green,
                  min:  0,
                  max: 1,
                ),
              ),
              IconButton(
                icon: Icon( _isMuted ? Icons.volume_off : Icons.volume_mute , color: Colors.white, ),
                tooltip: _isMuted ? "Unmute" :  "Mute",
                onPressed: (){
                  muteUnMute();
                  setState(() {
                    _isMuted = !_isMuted;
                  });
                },

              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.fast_rewind,
                    color: Colors.white,
                  ),
                  onPressed: () => _rewind(),
                ),
                  RawMaterialButton(
                    //    tooltip: _isPlaying ? "Stop" : "Play",

                    child: Icon( _isPlaying? Icons.pause : Icons.play_arrow, color: Colors.white,),
                    onPressed: (){

                      if(_isPlaying)
                        _pause();
                      else
                        _play();

                      setState(() {
                        _isPlaying = !_isPlaying;
                      });
                    },
                    fillColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    constraints:
                    BoxConstraints.tightFor(height: 70.0, width: 70.0),
                  ),
                IconButton(
                  icon: Icon(
                    Icons.fast_forward,
                    color: Colors.white,
                  ),
                  onPressed: () => _fastForward(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }


}

