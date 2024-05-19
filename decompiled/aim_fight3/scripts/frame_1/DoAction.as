function preload()
{
   gotoAndStop("preloader");
   play();
   onEnterFrame = function()
   {
      if(getBytesLoaded() >= getBytesTotal())
      {
         if(!p1 || !p2)
         {
            gotoAndStop("selection");
            play();
         }
         else
         {
            player1 = p1;
            player2 = p2;
            gotoAndStop("fight_load2");
            play();
            getFight();
         }
         onEnterFrame = null;
      }
   };
}
function defineUserNameHandlers()
{
   var _loc3_ = "Enter your screen name";
   player1Effect = new ibTextEffect();
   player1Effect.start("vivaTypeIn",{textObj:player_1._txt,theText:_loc3_,speed:1,numOfChars:_loc3_.length,endChar:""});
   var _loc4_ = "Enter your opponent\'s screen name";
   player2Effect = new ibTextEffect();
   player2Effect.start("vivaTypeIn",{textObj:player_2._txt,theText:_loc4_,speed:1,numOfChars:_loc4_.length,endChar:""});
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
function setPlayerNames()
{
   if(player_1._txt.text == "Enter your screen name" || player_2._txt.text == "Enter your opponent\'s screen name" || player_1._txt.text == "" || player_2._txt.text == "")
   {
      showStat("Please fill in both screen names");
      return undefined;
   }
   player1 = player_1._txt.text;
   player2 = player_2._txt.text;
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
   var _loc2_ = undefined;
   _loc2_ = s;
   if(s.indexOf(" ",0) > -1)
   {
      _loc2_ = s.substr(0,s.indexOf(" ",0));
      _loc2_ += s.substr(s.indexOf(" ",0) + 1,s.length);
      s = _loc2_;
      while(s.indexOf(" ",0) > -1)
      {
         _loc2_ = s.substr(0,s.indexOf(" ",0));
         _loc2_ += s.substr(s.indexOf(" ",0) + 1,s.length);
         s = _loc2_;
      }
   }
   trace(_loc2_);
   return _loc2_;
}
function getFight()
{
   fight_lv = new LoadVars();
   fight_lv.onLoad = function()
   {
      if(this.success == "1")
      {
         score1 = Number(this.score1);
         score2 = Number(this.score2);
         height1 = Number(this.height1);
         height2 = Number(this.height2);
         oscore1 = Number(this.oscore1);
         oscore2 = Number(this.oscore2);
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
   attachMovie("fightAgain","fightAgain",10,{_x:560,_y:115});
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
if($tweenManager == undefined)
{
   _global.$tweenManager = new zigo.tweenManager();
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
AsBroadcaster.initialize(Mp);
Mp.$addListener = Mp.addListener;
ASSetPropFlags(Mp,"$addListener",1,0);
Mp.addListener = function()
{
   AsBroadcaster.initialize(this);
   this.$addListener.apply(this,arguments);
};
Mp.tween = function(props, pEnd, seconds, animType, delay, callback, extra1, extra2)
{
   if($tweenManager.isTweenLocked(this))
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
      props = [props];
   }
   if(pEnd.length == undefined)
   {
      pEnd = [pEnd];
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
   if($tweenManager.autoStop)
   {
      $tweenManager.removeTween(this,props);
   }
   if(delay > 0)
   {
      $tweenManager.addTweenWithDelay(delay,this,props,pEnd,seconds,eqf,callback,extra1,extra2);
   }
   else
   {
      $tweenManager.addTween(this,props,pEnd,seconds,eqf,callback,extra1,extra2);
   }
};
ASSetPropFlags(Mp,"tween",1,0);
Mp.stopTween = function(props)
{
   if(typeof props == "string")
   {
      props = [props];
   }
   $tweenManager.removeTween(this,props);
};
ASSetPropFlags(Mp,"stopTween",1,0);
Mp.isTweening = function()
{
   return $tweenManager.isTweening(this);
};
ASSetPropFlags(Mp,"isTweening",1,0);
Mp.getTweens = function()
{
   return $tweenManager.getTweens(this);
};
ASSetPropFlags(Mp,"getTweens",1,0);
Mp.lockTween = function()
{
   $tweenManager.lockTween(this,true);
};
ASSetPropFlags(Mp,"lockTween",1,0);
Mp.unlockTween = function()
{
   $tweenManager.lockTween(this,false);
};
ASSetPropFlags(Mp,"unlockTween",1,0);
Mp.isTweenLocked = function()
{
   return $tweenManager.isTweenLocked(this);
};
ASSetPropFlags(Mp,"isTweenLocked",1,0);
Mp.alphaTo = function(destAlpha, seconds, animType, delay, callback, extra1, extra2)
{
   this.tween(["_alpha"],[destAlpha],seconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(Mp,"alphaTo",1,0);
Mp.brightnessTo = function(bright, seconds, animType, delay, callback, extra1, extra2)
{
   var _loc3_ = 100 - Math.abs(bright);
   var _loc2_ = 0;
   if(bright > 0)
   {
      _loc2_ = 256 * (bright / 100);
   }
   var _loc5_ = {ra:_loc3_,rb:_loc2_,ga:_loc3_,gb:_loc2_,ba:_loc3_,bb:_loc2_};
   this.tween(["_ct_"],[_loc5_],seconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(Mp,"brightnessTo",1,0);
Mp.colorTo = function(destColor, seconds, animType, delay, callback, extra1, extra2)
{
   var _loc3_ = {rb:destColor >> 16,ra:0,gb:(destColor & 65280) >> 8,ga:0,bb:destColor & 255,ba:0};
   this.tween(["_ct_"],[_loc3_],seconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(Mp,"colorTo",1,0);
Mp.colorTransformTo = function(ra, rb, ga, gb, ba, bb, aa, ab, seconds, animType, delay, callback, extra1, extra2)
{
   var _loc2_ = {ra:ra,rb:rb,ga:ga,gb:gb,ba:ba,bb:bb,aa:aa,ab:ab};
   this.tween(["_ct_"],[_loc2_],seconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(Mp,"colorTransformTo",1,0);
Mp.scaleTo = function(destScale, seconds, animType, delay, callback, extra1, extra2)
{
   this.tween(["_xscale","_yscale"],[destScale,destScale],seconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(Mp,"scaleTo",1,0);
Mp.slideTo = function(destX, destY, seconds, animType, delay, callback, extra1, extra2)
{
   this.tween(["_x","_y"],[destX,destY],seconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(Mp,"slideTo",1,0);
Mp.rotateTo = function(destRotation, seconds, animType, delay, callback, extra1, extra2)
{
   this.tween(["_rotation"],[destRotation],seconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(Mp,"rotateTo",1,0);
Mp.getFrame = function()
{
   return this._currentframe;
};
ASSetPropFlags(Mp,"getFrame",1,0);
Mp.setFrame = function(fr)
{
   this.gotoAndStop(Math.round(fr));
};
ASSetPropFlags(Mp,"setFrame",1,0);
Mp.addProperty("_frame",Mp.getFrame,Mp.setFrame);
ASSetPropFlags(Mp,"_frame",1,0);
Mp.frameTo = function(endframe, duration, animType, delay, callback, extra1, extra2)
{
   if(endframe == undefined)
   {
      endframe = this._totalframes;
   }
   this.tween("_frame",endframe,duration,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(Mp,"frameTo",1,0);
Mp.brightOffsetTo = function(percent, seconds, animType, delay, callback, extra1, extra2)
{
   var _loc2_ = 256 * (percent / 100);
   var _loc3_ = {ra:100,rb:_loc2_,ga:100,gb:_loc2_,ba:100,bb:_loc2_};
   this.tween(["_ct_"],[_loc3_],seconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(Mp,"brightOffsetTo",1,0);
Mp.contrastTo = function(percent, seconds, animType, delay, callback, extra1, extra2)
{
   var _loc2_ = {};
   _loc2_.ra = _loc2_.ga = _loc2_.ba = percent;
   _loc2_.rb = _loc2_.gb = _loc2_.bb = 128 - 1.28 * percent;
   this.tween(["_ct_"],[_loc2_],seconds,animType,delay,callback,extra1,extra2);
};
ASSetPropFlags(Mp,"contrastTo",1,0);
delete Mp;
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
