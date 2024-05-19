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
   var _loc3_ = "Enter your screen name";
   player1Effect = new ibTextEffect();
   player1Effect.start("vivaTypeIn",{textObj:player_1._txt,theText:_loc3_,speed:1,numOfChars:_loc3_.length,endChar:""});
   var _loc4_ = "Enter opponent\'s screen name";
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
      loadMovie("http://pr.atwola.com/promoimp/100000075xx1079959995/aol","_root.imageLoader");
      trace("image loading");
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
   attachMovie("fightAgain","fightAgain",10,{_x:380,_y:270});
   fightAgain.onRelease = function()
   {
      gotoAndStop("selection");
      play();
      killClip(fightAgain);
      killClip(winner_clip);
      loadMovie("http://pr.atwola.com/promoimp/100000075xx1079959995/aol","_root.imageLoader");
      trace("fight again image load");
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
   attachMovie("winner_mc","winner_clip",100,{_x:454,_y:-50});
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
   if(!this._listeners)
   {
      AsBroadcaster.initialize(this);
   }
   this.addListener.apply(this,arguments);
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
   _global.$tweenManager.removeTween(this,props);
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
   var _loc4_ = undefined;
   if(props != undefined)
   {
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
      _loc4_ = {};
      for(var _loc5_ in props)
      {
         _loc4_[props[_loc5_]] = true;
      }
   }
   _global.$tweenManager.pauseTween(this,_loc4_);
};
Mp.unpauseTween = function(props)
{
   var _loc4_ = undefined;
   if(props != undefined)
   {
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
      _loc4_ = {};
      for(var _loc5_ in props)
      {
         _loc4_[props[_loc5_]] = true;
      }
   }
   _global.$tweenManager.unpauseTween(this,_loc4_);
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
   var _loc4_ = undefined;
   if(props != undefined)
   {
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
      _loc4_ = {};
      for(var _loc5_ in props)
      {
         _loc4_[props[_loc5_]] = true;
      }
   }
   _global.$tweenManager.ffTween(this,_loc4_);
};
Mp.rewTween = function(props)
{
   var _loc4_ = undefined;
   if(props != undefined)
   {
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
      _loc4_ = {};
      for(var _loc5_ in props)
      {
         _loc4_[props[_loc5_]] = true;
      }
   }
   _global.$tweenManager.rewTween(this,_loc4_);
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
   switch(type)
   {
      case "brightness":
         var _loc4_ = 100 - Math.abs(amt);
         var _loc6_ = 0;
         if(amt > 0)
         {
            _loc6_ = 256 * (amt / 100);
         }
         return {ra:_loc4_,rb:_loc6_,ga:_loc4_,gb:_loc6_,ba:_loc4_,bb:_loc6_};
      case "brightOffset":
         _loc6_ = 256 * (amt / 100);
         return {ra:100,rb:_loc6_,ga:100,gb:_loc6_,ba:100,bb:_loc6_};
      case "contrast":
         var _loc2_ = {};
         _loc2_.ba = _loc0_ = amt;
         _loc2_.ga = _loc0_;
         _loc2_.ra = _loc0_;
         _loc2_.bb = _loc0_ = 128 - 1.28 * amt;
         _loc2_.gb = _loc0_;
         _loc2_.rb = _loc0_;
         return _loc2_;
      case "invertColor":
         _loc2_ = {};
         _loc2_.ba = _loc0_ = 100 - 2 * amt;
         _loc2_.ga = _loc0_;
         _loc2_.ra = _loc0_;
         _loc2_.bb = _loc0_ = amt * 2.55;
         _loc2_.gb = _loc0_;
         _loc2_.rb = _loc0_;
         return _loc2_;
      case "tint":
         if(rgb == undefined || rgb == null)
         {
            break;
         }
         var _loc8_ = rgb >> 16;
         var _loc9_ = rgb >> 8 & 255;
         var _loc7_ = rgb & 255;
         var _loc5_ = amt / 100;
         _loc2_ = {rb:_loc8_ * _loc5_,gb:_loc9_ * _loc5_,bb:_loc7_ * _loc5_};
         _loc2_.ba = _loc0_ = 100 - amt;
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
   var _loc2_ = {ra:ra,rb:rb,ga:ga,gb:gb,ba:ba,bb:bb,aa:aa,ab:ab};
   this.tween(["_ct_"],[_loc2_],seconds,animType,delay,callback,extra1,extra2);
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
   if(endframe == undefined)
   {
      endframe = this._totalframes;
   }
   this.tween("_frame",endframe,duration,animType,delay,callback,extra1,extra2);
};
var TFP = TextField.prototype;
if(!TFP.origAddListener)
{
   TFP.origAddListener = TFP.addListener;
   ASSetPropFlags(TFP,"origAddListener",1,0);
   TFP.addListener = function()
   {
      if(!this._listeners)
      {
         AsBroadcaster.initialize(this);
      }
      this.origAddListener.apply(this,arguments);
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
