function preload()
{
   gotoAndStop("preloader");
   play();
   onEnterFrame = function()
   {
      if(getBytesLoaded() >= getBytesTotal())
      {
         if(!p1 && !p2)
         {
            gotoAndStop("selection");
            play();
         }
         else
         {
            player1 = p1;
            player2 = p2;
            gotoAndStop("fight_load");
            play();
            getFight();
         }
         onEnterFrame = null;
      }
   };
}
function defineUserNameHandlers()
{
   var _loc1_ = this;
   var _loc3_ = "Enter your screen name";
   player1Effect = new ibTextEffect();
   player1Effect.start("vivaTypeIn",{textObj:player_1._txt,theText:_loc3_,speed:1,numOfChars:_loc3_.length,endChar:""});
   var player2txt = "Enter opponent\'s screen name";
   player2Effect = new ibTextEffect();
   player2Effect.start("vivaTypeIn",{textObj:player_2._txt,theText:player2txt,speed:1,numOfChars:player2txt.length,endChar:""});
   player_1._txt.onSetFocus = function()
   {
      this.text = "";
   };
   player_2._txt.onSetFocus = function()
   {
      this.text = "";
   };
   player_1._txt.onKillFocus = function()
   {
      if(this.text == "")
      {
         this.text = "Enter your screen name";
      }
   };
   player_2._txt.onKillFocus = function()
   {
      if(this.text == "")
      {
         this.text = "Enter your opponent\'s screen name";
      }
   };
   if(!haveAddedKeyListener)
   {
      var _loc2_ = new Object();
      _loc2_.onKeyUp = function()
      {
         trace(Selection.getFocus());
         if(Key.getCode() == 13 && Selection.getFocus() != _level0.fight_btn)
         {
            setPlayerNames();
         }
      };
      Key.addListener(_loc2_);
      haveAddedKeyListener = true;
   }
   fight_btn.onRelease = function()
   {
      setPlayerNames();
   };
   fight_btn.onRollOver = function()
   {
      this.gotoAndStop(2);
   };
   fight_btn.onRollOut = function()
   {
      this.gotoAndStop(1);
   };
}
function setPlayerNames(player1, player2)
{
   if(player_1._txt.text == "Enter your screen name" || player_2._txt.text == "Enter your opponent\'s screen name" || player_1._txt.text == "" || player_2._txt.text == "")
   {
      showStat("Please fill in both screen names");
      return undefined;
   }
   _root.player1 = player_1._txt.text;
   _root.player2 = player_2._txt.text;
   gotoAndStop("fight_load");
   play();
   getFight();
}
function showStat(t)
{
   clearStat();
   statInt = setInterval(clearStat,3000);
   statEffect = new ibTextEffect();
   statEffect.start("vivaTypeIn",{textObj:stat._txt,theText:t,speed:2,numOfChars:t.length,endChar:""});
}
function clearStat()
{
   stat._txt.text = "";
   clearInterval(statInt);
}
function stripSpaces(s)
{
   var _loc1_ = s;
   var _loc2_ = undefined;
   _loc2_ = _loc1_;
   if(_loc1_.indexOf(" ",0) > -1)
   {
      _loc2_ = _loc1_.substr(0,_loc1_.indexOf(" ",0));
      _loc2_ += _loc1_.substr(_loc1_.indexOf(" ",0) + 1,_loc1_.length);
      _loc1_ = _loc2_;
      while(_loc1_.indexOf(" ",0) > -1)
      {
         _loc2_ = _loc1_.substr(0,_loc1_.indexOf(" ",0));
         _loc2_ += _loc1_.substr(_loc1_.indexOf(" ",0) + 1,_loc1_.length);
         _loc1_ = _loc2_;
      }
   }
   trace(_loc2_);
   return _loc2_;
}
function getFight()
{
   var _loc1_ = this;
   fight_lv = new LoadVars();
   fight_lv.onLoad = function()
   {
      var _loc1_ = this;
      if(_loc1_.success == "1")
      {
         score1 = Number(_loc1_.score1);
         score2 = Number(_loc1_.score2);
         height1 = Number(_loc1_.height1);
         height2 = Number(_loc1_.height2);
         oscore1 = Number(_loc1_.oscore1);
         oscore2 = Number(_loc1_.oscore2);
         if(height1 < 2)
         {
            height1 = 2;
         }
         if(height2 < 2)
         {
            height2 = 2;
         }
         gotoAndStop("results");
         play();
      }
      else
      {
         trace("Error Connecting");
         fightAgain.removeMovieClip();
         gotoAndStop("connect_error");
         play();
      }
   };
   fight_lv.name1 = stripSpaces(player1);
   fight_lv.name2 = stripSpaces(player2);
   trace("fin");
   trace(player1);
   fight_lv.sendAndLoad(fight_url,fight_lv,"GET");
}
function displayResults()
{
   user_1.tween("_y",165,0.4,"easeOutBack");
   user_2.tween("_y",165,0.4,"easeOutBack",0.1);
   var _loc1_ = 5;
   if(score1 == score2)
   {
      user_1.setColor("0xFF0000");
      user_2.setColor("0xFF0000");
   }
   else if(score1 > score2)
   {
      user_1.setColor("0x66CC00");
      user_2.setColor("0xFF0000");
   }
   else
   {
      user_1.setColor("0xFF0000");
      user_2.setColor("0x66CC00");
   }
   user_1.setVal(score1);
   user_1.setSpeed(_loc1_);
   if(height1 >= height2)
   {
      user_1.setHeight(height1,graphAnimationCallBack);
   }
   else
   {
      user_1.setHeight(height1);
   }
   user_2.setVal(score2);
   user_2.setSpeed(_loc1_);
   if(height2 > height1)
   {
      user_2.setHeight(height2,graphAnimationCallBack);
   }
   else
   {
      user_2.setHeight(height2);
   }
   user_1.displayVal();
   user_2.displayVal();
   user_1.setName(player1);
   user_2.setName(player2);
}
function showPlayAgain()
{
   attachMovie("fightAgain","fightAgain",10,{_x:300,_y:250});
   fightAgain.onRelease = function()
   {
      gotoAndStop("selection");
      play();
      killClip(fightAgain);
      killClip(winner_clip);
   };
   fightAgain.onRollOver = function()
   {
      this.gotoAndStop(2);
   };
   fightAgain.onRollOut = function()
   {
      this.gotoAndStop(1);
   };
}
function killClip(c)
{
   removeMovieClip(c);
}
function graphAnimationCallBack()
{
   attachMovie("winner_mc","winner_clip",100,{_x:370,_y:30});
   if(score2 > score1)
   {
      winner_clip.winner._txt.text = player2 + " Wins!";
   }
   else if(score2 < score1)
   {
      winner_clip.winner._txt.text = player1 + " Wins!";
   }
   else if(score2 == score1)
   {
      winner_clip.winner._txt.text = "It\'s a Tie!";
   }
   showPlayAgain();
   if(oscore1 > 0)
   {
      user_1.setRank(oscore1);
      user_1.displayRank();
   }
   if(oscore2 > 0)
   {
      user_2.setRank(oscore2);
      user_2.displayRank();
   }
   user_1.setName(player1);
   user_2.setName(player2);
}
fight_url = "getFight.php";
rankExplanation_url = "";
haveAddedKeyListener = false;
rankTxt = "If your score is in the top 5% of all AIM users online, we\'ll show you where you rank is compared to the others in the top 5%.";
scoreTxt = "Your score shows how many connections you have relative to other AIM users.";
if(_global.$tweenManager == undefined)
{
   _global.$tweenManager = new zigo.tweenManager();
}
else
{
   _global.$tweenManager.cleanUp();
   _global.$tweenManager.init();
}
com.robertpenner.easing.Back;
com.robertpenner.easing.Bounce;
com.robertpenner.easing.Circ;
com.robertpenner.easing.Cubic;
com.robertpenner.easing.Elastic;
com.robertpenner.easing.Expo;
com.robertpenner.easing.Linear;
com.robertpenner.easing.Quad;
com.robertpenner.easing.Quart;
com.robertpenner.easing.Quint;
com.robertpenner.easing.Sine;
var Mp = MovieClip.prototype;
Mp.addListener = function()
{
   var _loc1_ = this;
   if(!_loc1_._listeners)
   {
      AsBroadcaster.initialize(_loc1_);
   }
   _loc1_.addListener.apply(_loc1_,arguments);
};
ASSetPropFlags(Mp,"addListener",1,0);
Mp.tween = function(props, pEnd, seconds, animType, delay, callback, extra1, extra2)
{
   if(_global.$tweenManager.isTweenLocked(this))
   {
      trace("tween not added, this movieclip is locked");
      return undefined;
   }
   if(arguments.length < 2)
   {
      trace("tween not added, props & pEnd must be defined");
      return undefined;
   }
   if(typeof props == "string")
   {
      if(props.indexOf(",") > -1)
      {
         props = props.split(" ").join("").split(",");
      }
      else
      {
         props = [props];
      }
   }
   if(!(pEnd instanceof Array))
   {
      pEnd = [pEnd];
      while(pEnd.length < props.length)
      {
         pEnd.push(pEnd[0]);
      }
   }
   if(seconds == undefined)
   {
      seconds = 2;
   }
   else if(seconds < 0.01)
   {
      seconds = 0;
   }
   if(delay < 0.01 || delay == undefined)
   {
      delay = 0;
   }
   switch(typeof animType)
   {
      case "string":
         animType = animType.toLowerCase();
         if(animType == "linear")
         {
            var eqf = com.robertpenner.easing.Linear.easeNone;
         }
         else if(animType.indexOf("easeoutin") == 0)
         {
            var t = animType.substr(9);
            t = t.charAt(0).toUpperCase() + t.substr(1);
            var eqf = com.robertpenner.easing[t].easeOutIn;
         }
         else if(animType.indexOf("easeinout") == 0)
         {
            var t = animType.substr(9);
            t = t.charAt(0).toUpperCase() + t.substr(1);
            var eqf = com.robertpenner.easing[t].easeInOut;
         }
         else if(animType.indexOf("easein") == 0)
         {
            var t = animType.substr(6);
            t = t.charAt(0).toUpperCase() + t.substr(1);
            var eqf = com.robertpenner.easing[t].easeIn;
         }
         else if(animType.indexOf("easeout") == 0)
         {
            var t = animType.substr(7);
            t = t.charAt(0).toUpperCase() + t.substr(1);
            var eqf = com.robertpenner.easing[t].easeOut;
         }
         if(eqf == undefined)
         {
            var eqf = com.robertpenner.easing.Expo.easeOut;
         }
         break;
      case "function":
         var eqf = animType;
         break;
      case "object":
         if(animType.ease != undefined && animType.pts != undefined)
         {
            var eqf = animType.ease;
            extra1 = animType.pts;
         }
         else
         {
            var eqf = com.robertpenner.easing.Expo.easeOut;
         }
         break;
      default:
         var eqf = com.robertpenner.easing.Expo.easeOut;
   }
   switch(typeof callback)
   {
      case "function":
         callback = {func:callback,scope:this._parent};
         break;
      case "string":
         var ilp;
         var funcp;
         var scope;
         var args;
         var a;
         ilp = callback.indexOf("(");
         funcp = callback.slice(0,ilp);
         scope = eval(funcp.slice(0,funcp.lastIndexOf(".")));
         func = eval(funcp);
         args = callback.slice(ilp + 1,callback.lastIndexOf(")")).split(",");
         var i = 0;
         while(i < args.length)
         {
            a = eval(args[i]);
            if(a != undefined)
            {
               args[i] = a;
            }
            i++;
         }
         callback = {func:func,scope:scope,args:args};
   }
   if(_global.$tweenManager.autoStop)
   {
      _global.$tweenManager.removeTween(this);
   }
   if(delay > 0)
   {
      _global.$tweenManager.addTweenWithDelay(delay,this,props,pEnd,seconds,eqf,callback,extra1,extra2);
   }
   else
   {
      _global.$tweenManager.addTween(this,props,pEnd,seconds,eqf,callback,extra1,extra2);
   }
};
Mp.stopTween = function(props)
{
   var _loc1_ = props;
   if(typeof _loc1_ == "string")
   {
      if(_loc1_.indexOf(",") > -1)
      {
         _loc1_ = _loc1_.split(" ").join("").split(",");
      }
      else
      {
         _loc1_ = [_loc1_];
      }
   }
   _global.$tweenManager.removeTween(this,_loc1_);
};
Mp.isTweening = function(prop)
{
   return _global.$tweenManager.isTweening(this,prop);
};
Mp.getTweens = function()
{
   return _global.$tweenManager.getTweens(this);
};
Mp.lockTween = function()
{
   _global.$tweenManager.lockTween(this,true);
};
Mp.unlockTween = function()
{
   _global.$tweenManager.lockTween(this,false);
};
Mp.isTweenLocked = function()
{
   return _global.$tweenManager.isTweenLocked(this);
};
Mp.isTweenPaused = function(prop)
{
   return _global.$tweenManager.isTweenPaused(this,prop);
};
Mp.pauseTween = function(props)
{
   var _loc1_ = props;
   var _loc2_ = undefined;
   if(_loc1_ != undefined)
   {
      if(typeof _loc1_ == "string")
      {
         if(_loc1_.indexOf(",") > -1)
         {
            _loc1_ = _loc1_.split(" ").join("").split(",");
         }
         else
         {
            _loc1_ = [_loc1_];
         }
      }
      _loc2_ = {};
      for(var _loc3_ in _loc1_)
      {
         _loc2_[_loc1_[_loc3_]] = true;
      }
   }
   _global.$tweenManager.pauseTween(this,_loc2_);
};
Mp.unpauseTween = function(props)
{
   var _loc1_ = props;
   var _loc2_ = undefined;
   if(_loc1_ != undefined)
   {
      if(typeof _loc1_ == "string")
      {
         if(_loc1_.indexOf(",") > -1)
         {
            _loc1_ = _loc1_.split(" ").join("").split(",");
         }
         else
         {
            _loc1_ = [_loc1_];
         }
      }
      _loc2_ = {};
      for(var _loc3_ in _loc1_)
      {
         _loc2_[_loc1_[_loc3_]] = true;
      }
   }
   _global.$tweenManager.unpauseTween(this,_loc2_);
};
Mp.pauseAllTweens = function()
{
   _global.$tweenManager.pauseTween();
};
Mp.unpauseAllTweens = function()
{
   _global.$tweenManager.unpauseTween();
};
Mp.stopAllTweens = function()
{
   _global.$tweenManager.stopAll();
};
Mp.ffTween = function(props)
{
   var _loc1_ = props;
   var _loc2_ = undefined;
   if(_loc1_ != undefined)
   {
      if(typeof _loc1_ == "string")
      {
         if(_loc1_.indexOf(",") > -1)
         {
            _loc1_ = _loc1_.split(" ").join("").split(",");
         }
         else
         {
            _loc1_ = [_loc1_];
         }
      }
      _loc2_ = {};
      for(var _loc3_ in _loc1_)
      {
         _loc2_[_loc1_[_loc3_]] = true;
      }
   }
   _global.$tweenManager.ffTween(this,_loc2_);
};
Mp.rewTween = function(props)
{
   var _loc1_ = props;
   var _loc2_ = undefined;
   if(_loc1_ != undefined)
   {
      if(typeof _loc1_ == "string")
      {
         if(_loc1_.indexOf(",") > -1)
         {
            _loc1_ = _loc1_.split(" ").join("").split(",");
         }
         else
         {
            _loc1_ = [_loc1_];
         }
      }
      _loc2_ = {};
      for(var _loc3_ in _loc1_)
      {
         _loc2_[_loc1_[_loc3_]] = true;
      }
   }
   _global.$tweenManager.rewTween(this,_loc2_);
};
Mp.alphaTo = function(destAlpha, seconds, animType, delay, callback, extra1, extra2)
{
   this.tween(["_alpha"],[destAlpha],seconds,animType,delay,callback,extra1,extra2);
};
Mp.scaleTo = function(destScale, seconds, animType, delay, callback, extra1, extra2)
{
   this.tween(["_xscale","_yscale"],[destScale,destScale],seconds,animType,delay,callback,extra1,extra2);
};
Mp.sizeTo = function(destSize, seconds, animType, delay, callback, extra1, extra2)
{
   this.tween(["_width","_height"],[destSize,destSize],seconds,animType,delay,callback,extra1,extra2);
};
Mp.slideTo = function(destX, destY, seconds, animType, delay, callback, extra1, extra2)
{
   this.tween(["_x","_y"],[destX,destY],seconds,animType,delay,callback,extra1,extra2);
};
Mp.rotateTo = function(destRotation, seconds, animType, delay, callback, extra1, extra2)
{
   this.tween(["_rotation"],[destRotation],seconds,animType,delay,callback,extra1,extra2);
};
_global.getColorTransObj = function(type, amt, rgb)
{
   var _loc1_ = amt;
   var _loc3_ = rgb;
   switch(type)
   {
      case "brightness":
         var percent = 100 - Math.abs(_loc1_);
         var offset = 0;
         if(_loc1_ > 0)
         {
            offset = 256 * (_loc1_ / 100);
         }
         return {ra:percent,rb:offset,ga:percent,gb:offset,ba:percent,bb:offset};
      case "brightOffset":
         var offset = 256 * (_loc1_ / 100);
         return {ra:100,rb:offset,ga:100,gb:offset,ba:100,bb:offset};
      case "contrast":
         var _loc2_ = {};
         _loc2_.ba = _loc0_ = _loc1_;
         _loc2_.ga = _loc0_;
         _loc2_.ra = _loc0_;
         _loc2_.bb = _loc0_ = 128 - 1.28 * _loc1_;
         _loc2_.gb = _loc0_;
         _loc2_.rb = _loc0_;
         return _loc2_;
      case "invertColor":
         _loc2_ = {};
         _loc2_.ba = _loc0_ = 100 - 2 * _loc1_;
         _loc2_.ga = _loc0_;
         _loc2_.ra = _loc0_;
         _loc2_.bb = _loc0_ = _loc1_ * 2.55;
         _loc2_.gb = _loc0_;
         _loc2_.rb = _loc0_;
         return _loc2_;
      case "tint":
         if(_loc3_ == undefined || _loc3_ == null)
         {
            break;
         }
         var r = _loc3_ >> 16;
         var g = _loc3_ >> 8 & 255;
         var b = _loc3_ & 255;
         var ratio = _loc1_ / 100;
         _loc2_ = {rb:r * ratio,gb:g * ratio,bb:b * ratio};
         _loc2_.ba = _loc0_ = 100 - _loc1_;
         _loc2_.ga = _loc0_;
         _loc2_.ra = _loc0_;
         return _loc2_;
   }
   return {rb:0,ra:100,gb:0,ga:100,bb:0,ba:100};
};
Mp.brightnessTo = function(bright, seconds, animType, delay, callback, extra1, extra2)
{
   this.tween(["_ct_"],[getColorTransObj("brightness",bright)],seconds,animType,delay,callback,extra1,extra2);
};
Mp.brightOffsetTo = function(percent, seconds, animType, delay, callback, extra1, extra2)
{
   this.tween(["_ct_"],[getColorTransObj("brightOffset",percent)],seconds,animType,delay,callback,extra1,extra2);
};
Mp.contrastTo = function(percent, seconds, animType, delay, callback, extra1, extra2)
{
   this.tween(["_ct_"],[getColorTransObj("contrast",percent)],seconds,animType,delay,callback,extra1,extra2);
};
Mp.colorTo = function(rgb, seconds, animType, delay, callback, extra1, extra2)
{
   this.tween(["_ct_"],[getColorTransObj("tint",100,rgb)],seconds,animType,delay,callback,extra1,extra2);
};
Mp.colorTransformTo = function(ra, rb, ga, gb, ba, bb, aa, ab, seconds, animType, delay, callback, extra1, extra2)
{
   var _loc1_ = {ra:ra,rb:rb,ga:ga,gb:gb,ba:ba,bb:bb,aa:aa,ab:ab};
   this.tween(["_ct_"],[_loc1_],seconds,animType,delay,callback,extra1,extra2);
};
Mp.invertColorTo = function(percent, seconds, animType, delay, callback, extra1, extra2)
{
   this.tween(["_ct_"],[getColorTransObj("invertColor",percent)],seconds,animType,delay,callback,extra1,extra2);
};
Mp.tintTo = function(rgb, percent, seconds, animType, delay, callback, extra1, extra2)
{
   this.tween(["_ct_"],[getColorTransObj("tint",percent,rgb)],seconds,animType,delay,callback,extra1,extra2);
};
Mp.getFrame = function()
{
   return this._currentframe;
};
Mp.setFrame = function(fr)
{
   this.gotoAndStop(Math.round(fr));
};
Mp.addProperty("_frame",Mp.getFrame,Mp.setFrame);
Mp.frameTo = function(endframe, duration, animType, delay, callback, extra1, extra2)
{
   var _loc1_ = endframe;
   if(_loc1_ == undefined)
   {
      _loc1_ = this._totalframes;
   }
   this.tween("_frame",_loc1_,duration,animType,delay,callback,extra1,extra2);
};
var TFP = TextField.prototype;
if(!TFP.origAddListener)
{
   TFP.origAddListener = TFP.addListener;
   ASSetPropFlags(TFP,"origAddListener",1,0);
   TFP.addListener = function()
   {
      var _loc1_ = this;
      if(!_loc1_._listeners)
      {
         AsBroadcaster.initialize(_loc1_);
      }
      _loc1_.origAddListener.apply(_loc1_,arguments);
   };
}
var methods = ["tween","stopTween","isTweening","getTweens","lockTween","isTweenLocked","unlockTween","isTweenPaused","pauseTween","unpauseTween","pauseAllTweens","unpauseAllTweens","stopAllTweens","ffTween","rewTween","getFrame","setFrame","_frame","frameTo","alphaTo","brightnessTo","colorTo","colorTransformTo","invertColorTo","tintTo","scaleTo","sizeTo","slideTo","rotateTo","brightOffsetTo","contrastTo"];
for(var i in methods)
{
   ASSetPropFlags(Mp,methods[i],1,0);
   if(methods[i].toLowerCase().indexOf("frame") == -1)
   {
      TFP[methods[i]] = Mp[methods[i]];
      ASSetPropFlags(TFP,methods[i],1,0);
   }
}
delete Mp;
delete TFP;
delete methods;
var mp = MovieClip.prototype;
mp.$setrx = function(value)
{
   this._x = Math.round(value);
};
mp.$getrx = function()
{
   return Math.round(this._x);
};
mp.$setry = function(value)
{
   this._y = Math.round(value);
};
mp.$getry = function()
{
   return Math.round(this._y);
};
mp.addProperty("_rx",mp.$getrx,mp.$setrx);
mp.addProperty("_ry",mp.$getry,mp.$setry);
ASSetPropFlags(mp,"_rx",1,0);
ASSetPropFlags(mp,"_ry",1,0);
ASSetPropFlags(mp,"$getrx",1,0);
ASSetPropFlags(MP,"$setry",1,0);
ASSetPropFlags(MP,"$getrx",1,0);
ASSetPropFlags(MP,"$setry",1,0);
delete mp;
Sound.prototype.tween = MovieClip.prototype.tween;
Sound.prototype.addProperty("_volume",Sound.prototype.getVolume,Sound.prototype.setVolume);
Sound.prototype.volumeTo = function(destVol, seconds, animType, delay, callback, extra1, extra2)
{
   this.tween("_volume",destVol,seconds,animType,delay,callback,extra1,extra2);
};
