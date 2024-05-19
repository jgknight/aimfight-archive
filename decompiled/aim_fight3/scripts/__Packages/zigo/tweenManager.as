class zigo.tweenManager
{
   var playing;
   var isPaused;
   var autoStop;
   var broadcastEvents;
   var autoOverwrite;
   var ints;
   var lockedTweens;
   var tweenList;
   var updateTime;
   var updateIntId;
   var tweenHolder;
   var now;
   var pausedTime;
   function tweenManager()
   {
      this.playing = false;
      this.isPaused = false;
      this.autoStop = false;
      this.broadcastEvents = false;
      this.autoOverwrite = true;
      this.ints = new Array();
      this.lockedTweens = new Object();
      this.tweenList = new Array();
   }
   function set updateInterval(time)
   {
      if(this.playing)
      {
         this.deinit();
         this.updateTime = time;
         this.init();
      }
      else
      {
         this.updateTime = time;
      }
   }
   function get updateInterval()
   {
      return this.updateTime;
   }
   function init()
   {
      if(this.updateTime > 0)
      {
         this.updateIntId = setInterval(this,"update",this.updateTime);
      }
      else
      {
         if(this.tweenHolder._name == undefined)
         {
            this.tweenHolder = _root.createEmptyMovieClip("_th_",6789);
         }
         var tm = this;
         this.tweenHolder.onEnterFrame = function()
         {
            tm.update.call(tm);
         };
      }
      this.playing = true;
      this.now = getTimer();
   }
   function deinit()
   {
      this.playing = false;
      clearInterval(this.updateIntId);
      delete this.tweenHolder.onEnterFrame;
   }
   function update()
   {
      var _loc2_ = undefined;
      var _loc7_ = undefined;
      var _loc3_ = undefined;
      _loc7_ = this.tweenList.length;
      if(this.broadcastEvents)
      {
         var _loc4_ = undefined;
         var _loc6_ = undefined;
         _loc4_ = {};
         _loc6_ = {};
      }
      while(true)
      {
         _loc7_;
         if(!_loc7_--)
         {
            break;
         }
         _loc2_ = this.tweenList[_loc7_];
         if(_loc2_.ts + _loc2_.d > this.now)
         {
            if(_loc2_.ctm == undefined)
            {
               _loc2_.mc[_loc2_.pp] = _loc2_.ef(this.now - _loc2_.ts,_loc2_.ps,_loc2_.ch,_loc2_.d,_loc2_.e1,_loc2_.e2);
            }
            else
            {
               var _loc5_ = {};
               for(_loc3_ in _loc2_.ctm)
               {
                  _loc5_[_loc3_] = _loc2_.ef(this.now - _loc2_.ts,_loc2_.stm[_loc3_],_loc2_.ctm[_loc3_],_loc2_.d,_loc2_.e1,_loc2_.e2);
               }
               _loc2_.c.setTransform(_loc5_);
            }
            if(this.broadcastEvents)
            {
               if(_loc4_[targetPath(_loc2_.mc)] == undefined)
               {
                  _loc4_[targetPath(_loc2_.mc)] = _loc2_.mc;
               }
            }
            if(_loc2_.cb.updfunc != undefined)
            {
               _loc2_.cb.updfunc.apply(_loc2_.cb.updscope,_loc2_.cb.updargs);
            }
         }
         else
         {
            if(_loc2_.ctm == undefined)
            {
               _loc2_.mc[_loc2_.pp] = _loc2_.ps + _loc2_.ch;
            }
            else
            {
               _loc5_ = {};
               for(_loc3_ in _loc2_.ctm)
               {
                  _loc5_[_loc3_] = _loc2_.stm[_loc3_] + _loc2_.ctm[_loc3_];
               }
               _loc2_.c.setTransform(_loc5_);
            }
            if(this.broadcastEvents)
            {
               if(_loc4_[targetPath(_loc2_.mc)] == undefined)
               {
                  _loc4_[targetPath(_loc2_.mc)] = _loc2_.mc;
               }
               if(_loc6_[targetPath(_loc2_.mc)] == undefined)
               {
                  _loc6_[targetPath(_loc2_.mc)] = _loc2_.mc;
               }
            }
            if(_loc2_.cb.updfunc != undefined)
            {
               _loc2_.cb.updfunc.apply(_loc2_.cb.updscope,_loc2_.cb.updargs);
            }
            if(endt == undefined)
            {
               var endt = new Array();
            }
            endt.push(_loc7_);
         }
      }
      for(_loc3_ in _loc4_)
      {
         _loc4_[_loc3_].broadcastMessage("onTweenUpdate");
      }
      if(endt != undefined)
      {
         this.endTweens(endt);
      }
      for(_loc3_ in _loc6_)
      {
         _loc6_[_loc3_].broadcastMessage("onTweenEnd");
      }
      this.now = getTimer();
      if(this.updateTime > 0)
      {
         updateAfterEvent();
      }
   }
   function endTweens(tid_arr)
   {
      var _loc2_ = undefined;
      var _loc8_ = undefined;
      var _loc3_ = undefined;
      var _loc4_ = undefined;
      var _loc7_ = undefined;
      _loc2_ = [];
      _loc8_ = tid_arr.length;
      _loc3_ = 0;
      while(_loc3_ < _loc8_)
      {
         _loc4_ = this.tweenList[tid_arr[_loc3_]].cb;
         if(_loc4_ != undefined)
         {
            var _loc5_ = true;
            for(_loc7_ in _loc2_)
            {
               if(_loc2_[_loc7_] == _loc4_)
               {
                  _loc5_ = false;
                  break;
               }
            }
            if(_loc5_)
            {
               _loc2_.push(_loc4_);
            }
         }
         this.tweenList.splice(tid_arr[_loc3_],1);
         _loc3_ = _loc3_ + 1;
      }
      _loc3_ = 0;
      while(_loc3_ < _loc2_.length)
      {
         _loc2_[_loc3_].func.apply(_loc2_[_loc3_].scope,_loc2_[_loc3_].args);
         _loc3_ = _loc3_ + 1;
      }
      if(this.tweenList.length == 0)
      {
         this.deinit();
      }
   }
   function addTween(mc, props, pEnd, sec, eqFunc, callback, extra1, extra2)
   {
      var _loc4_ = undefined;
      var _loc12_ = undefined;
      var _loc6_ = undefined;
      var _loc3_ = undefined;
      var _loc2_ = undefined;
      if(!this.playing)
      {
         this.init();
      }
      for(_loc4_ in props)
      {
         _loc12_ = props[_loc4_];
         _loc6_ = true;
         if(_loc12_.substr(0,4) != "_ct_")
         {
            if(this.autoOverwrite)
            {
               for(_loc3_ in this.tweenList)
               {
                  _loc2_ = this.tweenList[_loc3_];
                  if(_loc2_.mc == mc && _loc2_.pp == _loc12_)
                  {
                     _loc2_.ps = mc[_loc12_];
                     _loc2_.ch = pEnd[_loc4_] - mc[_loc12_];
                     _loc2_.ts = this.now;
                     _loc2_.d = sec * 1000;
                     _loc2_.ef = eqFunc;
                     _loc2_.cb = callback;
                     _loc2_.e1 = extra1;
                     _loc2_.e2 = extra2;
                     _loc6_ = false;
                     break;
                  }
               }
            }
            if(_loc6_)
            {
               this.tweenList.unshift({mc:mc,pp:_loc12_,ps:mc[_loc12_],ch:pEnd[_loc4_] - mc[_loc12_],ts:this.now,d:sec * 1000,ef:eqFunc,cb:callback,e1:extra1,e2:extra2});
            }
         }
         else
         {
            var _loc16_ = new Color(mc);
            var _loc20_ = _loc16_.getTransform();
            var _loc19_ = {};
            for(_loc3_ in pEnd[_loc4_])
            {
               if(pEnd[_loc4_][_loc3_] != _loc20_[_loc3_] && pEnd[_loc4_][_loc3_] != undefined)
               {
                  _loc19_[_loc3_] = pEnd[_loc4_][_loc3_] - _loc20_[_loc3_];
               }
            }
            if(this.autoOverwrite)
            {
               for(_loc3_ in this.tweenList)
               {
                  _loc2_ = this.tweenList[_loc3_];
                  if(_loc2_.mc == mc && _loc2_.ctm != undefined)
                  {
                     _loc2_.c = _loc16_;
                     _loc2_.stm = _loc20_;
                     _loc2_.ctm = _loc19_;
                     _loc2_.ts = this.now;
                     _loc2_.d = sec * 1000;
                     _loc2_.ef = eqFunc;
                     _loc2_.cb = callback;
                     _loc2_.e1 = extra1;
                     _loc2_.e2 = extra2;
                     _loc6_ = false;
                     break;
                  }
               }
            }
            if(_loc6_)
            {
               this.tweenList.unshift({mc:mc,c:_loc16_,stm:_loc20_,ctm:_loc19_,ts:this.now,d:sec * 1000,ef:eqFunc,cb:callback,e1:extra1,e2:extra2});
            }
         }
      }
      if(this.broadcastEvents)
      {
         mc.broadcastMessage("onTweenStart",props[_loc4_]);
      }
      if(callback.startfunc != undefined)
      {
         callback.startfunc.apply(callback.startscope,callback.startargs);
      }
   }
   function addTweenWithDelay(delay, mc, props, pEnd, sec, eqFunc, callback, extra1, extra2)
   {
      var il = this.ints.length;
      var _loc3_ = setInterval(function(obj)
      {
         obj.addTween(mc,props,pEnd,sec,eqFunc,callback,extra1,extra2);
         clearInterval(obj.ints[il].intid);
         obj.ints[il] = undefined;
      }
      ,delay * 1000,this);
      this.ints[il] = {mc:mc,props:props,pend:pEnd,intid:_loc3_,st:this.now,delay:delay * 1000,args:arguments.slice(1)};
   }
   function removeTween(mc, props)
   {
      var _loc6_ = undefined;
      var _loc2_ = undefined;
      var _loc3_ = undefined;
      _loc6_ = false;
      if(props == undefined)
      {
         _loc6_ = true;
      }
      _loc2_ = this.tweenList.length;
      while(true)
      {
         _loc2_;
         if(!_loc2_--)
         {
            break;
         }
         if(this.tweenList[_loc2_].mc == mc)
         {
            if(_loc6_)
            {
               this.tweenList.splice(_loc2_,1);
            }
            else
            {
               for(_loc3_ in props)
               {
                  if(this.tweenList[_loc2_].pp == props[_loc3_])
                  {
                     this.tweenList.splice(_loc2_,1);
                  }
                  else if(props[_loc3_] == "_ct_" && this.tweenList[_loc2_].ctm != undefined)
                  {
                     this.tweenList.splice(_loc2_,1);
                  }
               }
            }
         }
      }
      _loc2_ = this.ints.length;
      while(true)
      {
         _loc2_;
         if(!_loc2_--)
         {
            break;
         }
         if(this.ints[_loc2_].mc == mc)
         {
            if(_loc6_)
            {
               clearInterval(this.ints[_loc2_].intid);
               this.ints[_loc2_] = undefined;
            }
            else
            {
               for(_loc3_ in props)
               {
                  for(var _loc5_ in this.ints[_loc2_].props)
                  {
                     if(this.ints[_loc2_].props[_loc5_] == props[_loc3_])
                     {
                        this.ints[_loc2_].props.splice(_loc5_,1);
                        this.ints[_loc2_].pend.splice(_loc5_,1);
                     }
                  }
                  if(this.ints[_loc2_].props.length == 0)
                  {
                     clearInterval(this.ints[_loc2_].intid);
                  }
               }
            }
         }
      }
      if(this.tweenList.length == 0)
      {
         this.deinit();
      }
   }
   function isTweening(mc)
   {
      for(var _loc3_ in this.tweenList)
      {
         if(this.tweenList[_loc3_].mc == mc)
         {
            return true;
         }
      }
      return false;
   }
   function getTweens(mc)
   {
      var _loc2_ = 0;
      for(var _loc4_ in this.tweenList)
      {
         if(this.tweenList[_loc4_].mc == mc)
         {
            _loc2_ = _loc2_ + 1;
         }
      }
      return _loc2_;
   }
   function lockTween(mc, bool)
   {
      this.lockedTweens[targetPath(mc)] = bool;
   }
   function isTweenLocked(mc)
   {
      if(this.lockedTweens[targetPath(mc)] == undefined)
      {
         return false;
      }
      return this.lockedTweens[targetPath(mc)];
   }
   function pauseAll()
   {
      if(this.isPaused)
      {
         return undefined;
      }
      this.isPaused = true;
      this.pausedTime = this.now;
      for(var _loc2_ in this.ints)
      {
         clearInterval(this.ints[_loc2_].intid);
      }
      this.deinit();
   }
   function unpauseAll()
   {
      if(!this.isPaused)
      {
         return undefined;
      }
      var _loc2_ = undefined;
      var _loc4_ = undefined;
      this.isPaused = false;
      this.init();
      for(_loc2_ in this.tweenList)
      {
         _loc4_ = this.tweenList[_loc2_];
         _loc4_.ts = this.now - (this.pausedTime - _loc4_.ts);
      }
      for(_loc2_ in this.ints)
      {
         if(this.ints[_loc2_] != undefined)
         {
            var _loc3_ = this.ints[_loc2_].delay - (this.pausedTime - this.ints[_loc2_].st);
            var _loc5_ = setInterval(function(obj, id)
            {
               obj.addTween.apply(obj,obj.ints[id].args);
               clearInterval(obj.ints[id].intid);
               obj.ints[id] = undefined;
            }
            ,_loc3_,this,_loc2_);
            this.ints[_loc2_].intid = _loc5_;
            this.ints[_loc2_].st = this.now;
            this.ints[_loc2_].delay = _loc3_;
         }
      }
   }
   function stopAll()
   {
      for(var _loc2_ in this.ints)
      {
         clearInterval(this.ints[_loc2_].intid);
      }
      this.tweenList = new Array();
      this.deinit();
   }
   function toString()
   {
      return "[AS2 tweenManager 1.1.7]";
   }
}
