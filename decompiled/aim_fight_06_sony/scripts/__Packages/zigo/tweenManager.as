class zigo.tweenManager
{
   var playing;
   var autoStop;
   var broadcastEvents;
   var autoOverwrite;
   var ints;
   var lockedTweens;
   var tweenList;
   var updateTime;
   var tweenHolder;
   var updateIntId;
   var now;
   var _th_depth = 6789;
   function tweenManager()
   {
      this.playing = false;
      this.autoStop = false;
      this.broadcastEvents = false;
      this.autoOverwrite = true;
      this.ints = new Array();
      this.lockedTweens = new Object();
      this.tweenList = new Array();
   }
   function cleanUp()
   {
      if(!(this.tweenList instanceof Array && this.tweenList.length > 0))
      {
         return undefined;
      }
      for(var _loc2_ in this.tweenList)
      {
         if(this.tweenList[_loc2_].mc._x == undefined)
         {
            this.tweenList.splice(Number(_loc2_),1);
         }
      }
      if(this.tweenList.length == 0)
      {
         this.tweenList = [];
         this.deinit();
      }
      for(_loc2_ in this.ints)
      {
         if(this.ints[_loc2_] != undefined && this.ints[_loc2_].mc._x == undefined)
         {
            this.removeDelayedTween(Number(_loc2_));
         }
      }
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
   function set controllerDepth(v)
   {
      if(_global.isNaN(v) == true)
      {
         return;
      }
      if(this.tweenHolder._name != undefined)
      {
         this.tweenHolder.swapDepths(v);
      }
      else
      {
         this._th_depth = v;
      }
   }
   function get controllerDepth()
   {
      return this._th_depth;
   }
   function init()
   {
      if(this.updateTime > 0)
      {
         clearInterval(this.updateIntId);
         this.updateIntId = setInterval(this,"update",this.updateTime);
      }
      else
      {
         if(this.tweenHolder._name == undefined)
         {
            this.tweenHolder = _root.createEmptyMovieClip("_th_",this._th_depth);
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
      var _loc10_ = undefined;
      var _loc3_ = undefined;
      var _loc13_ = false;
      _loc10_ = this.tweenList.length;
      if(this.broadcastEvents)
      {
         var _loc4_ = undefined;
         var _loc7_ = undefined;
         var _loc5_ = undefined;
         var _loc9_ = undefined;
         _loc4_ = {};
         _loc7_ = {};
         _loc5_ = {};
         _loc9_ = {};
      }
      while(true)
      {
         _loc10_;
         if(!_loc10_--)
         {
            break;
         }
         _loc2_ = this.tweenList[_loc10_];
         if(_loc2_.mc._x == undefined)
         {
            _loc13_ = true;
         }
         else if(_loc2_.pt == -1)
         {
            if(_loc2_.ts + _loc2_.d > this.now)
            {
               if(_loc2_.ctm == undefined)
               {
                  _loc2_.mc[_loc2_.pp] = _loc2_.ef(this.now - _loc2_.ts,_loc2_.ps,_loc2_.ch,_loc2_.d,_loc2_.e1,_loc2_.e2);
               }
               else
               {
                  var _loc8_ = {};
                  for(_loc3_ in _loc2_.ctm)
                  {
                     _loc8_[_loc3_] = _loc2_.ef(this.now - _loc2_.ts,_loc2_.stm[_loc3_],_loc2_.ctm[_loc3_],_loc2_.d,_loc2_.e1,_loc2_.e2);
                  }
                  _loc2_.c.setTransform(_loc8_);
               }
               if(this.broadcastEvents)
               {
                  if(_loc4_[targetPath(_loc2_.mc)] == undefined)
                  {
                     _loc4_[targetPath(_loc2_.mc)] = _loc2_.mc;
                  }
                  if(_loc5_[targetPath(_loc2_.mc)] == undefined)
                  {
                     _loc5_[targetPath(_loc2_.mc)] = [];
                  }
                  _loc5_[targetPath(_loc2_.mc)].push(_loc2_.ctm == undefined ? _loc2_.pp : "_ct_");
               }
               if(_loc2_.cb.updfunc != undefined)
               {
                  var _loc6_ = _loc2_.cb.updfunc;
                  if(typeof _loc6_ == "string" && _loc2_.cb.updscope != undefined)
                  {
                     _loc6_ = _loc2_.cb.updscope[_loc6_];
                  }
                  _loc6_.apply(_loc2_.cb.updscope,_loc2_.cb.updargs);
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
                  _loc8_ = {};
                  for(_loc3_ in _loc2_.ctm)
                  {
                     _loc8_[_loc3_] = _loc2_.stm[_loc3_] + _loc2_.ctm[_loc3_];
                  }
                  _loc2_.c.setTransform(_loc8_);
               }
               if(this.broadcastEvents)
               {
                  if(_loc4_[targetPath(_loc2_.mc)] == undefined)
                  {
                     _loc4_[targetPath(_loc2_.mc)] = _loc2_.mc;
                  }
                  if(_loc7_[targetPath(_loc2_.mc)] == undefined)
                  {
                     _loc7_[targetPath(_loc2_.mc)] = _loc2_.mc;
                  }
                  if(_loc5_[targetPath(_loc2_.mc)] == undefined)
                  {
                     _loc5_[targetPath(_loc2_.mc)] = [];
                  }
                  _loc5_[targetPath(_loc2_.mc)].push(_loc2_.ctm == undefined ? _loc2_.pp : "_ct_");
                  if(_loc9_[targetPath(_loc2_.mc)] == undefined)
                  {
                     _loc9_[targetPath(_loc2_.mc)] = [];
                  }
                  _loc9_[targetPath(_loc2_.mc)].push(_loc2_.ctm == undefined ? _loc2_.pp : "_ct_");
               }
               if(_loc2_.cb.updfunc != undefined)
               {
                  _loc6_ = _loc2_.cb.updfunc;
                  if(typeof _loc6_ == "string" && _loc2_.cb.updscope != undefined)
                  {
                     _loc6_ = _loc2_.cb.updscope[_loc6_];
                  }
                  _loc6_.updfunc.apply(_loc2_.cb.updscope,_loc2_.cb.updargs);
               }
               if(endt == undefined)
               {
                  var endt = new Array();
               }
               endt.push(_loc10_);
            }
         }
      }
      if(_loc13_)
      {
         this.cleanUp();
      }
      for(_loc3_ in _loc4_)
      {
         _loc4_[_loc3_].broadcastMessage("onTweenUpdate",{target:_loc4_[_loc3_],props:_loc5_[_loc3_]});
      }
      if(endt != undefined)
      {
         this.endTweens(endt);
      }
      for(_loc3_ in _loc7_)
      {
         _loc7_[_loc3_].broadcastMessage("onTweenEnd",{target:_loc7_[_loc3_],props:_loc9_[_loc3_]});
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
      var _loc9_ = undefined;
      var _loc3_ = undefined;
      var _loc5_ = undefined;
      var _loc8_ = undefined;
      _loc2_ = [];
      _loc9_ = tid_arr.length;
      _loc3_ = 0;
      while(_loc3_ < _loc9_)
      {
         _loc5_ = this.tweenList[tid_arr[_loc3_]].cb;
         if(_loc5_ != undefined)
         {
            var _loc6_ = true;
            for(_loc8_ in _loc2_)
            {
               if(_loc2_[_loc8_] == _loc5_)
               {
                  _loc6_ = false;
                  break;
               }
            }
            if(_loc6_)
            {
               _loc2_.push(_loc5_);
            }
         }
         this.tweenList.splice(tid_arr[_loc3_],1);
         _loc3_ = _loc3_ + 1;
      }
      _loc3_ = 0;
      while(_loc3_ < _loc2_.length)
      {
         var _loc4_ = _loc2_[_loc3_].func;
         if(typeof _loc4_ == "string" && _loc2_[_loc3_].scope != undefined)
         {
            _loc4_ = _loc2_[_loc3_].scope[_loc4_];
         }
         _loc4_.apply(_loc2_[_loc3_].scope,_loc2_[_loc3_].args);
         _loc3_ = _loc3_ + 1;
      }
      if(this.tweenList.length == 0)
      {
         this.deinit();
      }
   }
   function removeDelayedTween(index)
   {
      clearInterval(this.ints[index].intid);
      this.ints[index] = undefined;
      var _loc2_ = true;
      for(var _loc3_ in this.ints)
      {
         if(this.ints[_loc3_] != undefined)
         {
            _loc2_ = false;
            break;
         }
      }
      if(_loc2_)
      {
         this.ints = [];
      }
   }
   function addTween(mc, props, pEnd, sec, eqFunc, callback, extra1, extra2)
   {
      var _loc4_ = undefined;
      var _loc13_ = undefined;
      var _loc6_ = undefined;
      var _loc3_ = undefined;
      var _loc2_ = undefined;
      if(!this.playing)
      {
         this.init();
      }
      var _loc12_ = [];
      for(_loc4_ in props)
      {
         _loc13_ = props[_loc4_];
         _loc6_ = true;
         if(_loc13_.substr(0,4) != "_ct_")
         {
            var _loc17_ = typeof pEnd[_loc4_] != "string" ? pEnd[_loc4_] - mc[_loc13_] : Number(pEnd[_loc4_]);
            if(this.autoOverwrite)
            {
               for(_loc3_ in this.tweenList)
               {
                  _loc2_ = this.tweenList[_loc3_];
                  if(_loc2_.mc == mc && _loc2_.pp == _loc13_)
                  {
                     _loc2_.ps = mc[_loc13_];
                     _loc2_.ch = _loc17_;
                     _loc2_.ts = this.now;
                     _loc2_.d = sec * 1000;
                     _loc2_.ef = eqFunc;
                     _loc2_.cb = callback;
                     _loc2_.e1 = extra1;
                     _loc2_.e2 = extra2;
                     _loc2_.pt = -1;
                     _loc6_ = false;
                     _loc12_.push(_loc2_.pp);
                     break;
                  }
               }
            }
            if(_loc6_)
            {
               this.tweenList.unshift({mc:mc,pp:_loc13_,ps:mc[_loc13_],ch:_loc17_,ts:this.now,d:sec * 1000,ef:eqFunc,cb:callback,e1:extra1,e2:extra2,pt:-1});
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
                  _loc19_[_loc3_] = typeof pEnd[_loc4_][_loc3_] != "string" ? pEnd[_loc4_][_loc3_] - _loc20_[_loc3_] : _loc20_[_loc3_] + Number(pEnd[_loc4_][_loc3_]);
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
                     _loc2_.pt = -1;
                     _loc6_ = false;
                     _loc12_.push("_ct_");
                     break;
                  }
               }
            }
            if(_loc6_)
            {
               this.tweenList.unshift({mc:mc,c:_loc16_,stm:_loc20_,ctm:_loc19_,ts:this.now,d:sec * 1000,ef:eqFunc,cb:callback,e1:extra1,e2:extra2,pt:-1});
            }
         }
      }
      if(this.broadcastEvents)
      {
         if(_loc12_.length > 0)
         {
            mc.broadcastMessage("onTweenInterrupt",{target:mc,props:_loc12_});
         }
         mc.broadcastMessage("onTweenStart",{target:mc,props:props});
      }
      if(callback.startfunc != undefined)
      {
         var _loc27_ = callback.startfunc;
         if(typeof _loc27_ == "string" && callback.startscope != undefined)
         {
            _loc27_ = callback.startscope[_loc27_];
         }
         _loc27_.apply(callback.startscope,callback.startargs);
      }
      if(sec == 0)
      {
         this.update();
      }
   }
   function addTweenWithDelay(delay, mc, props, pEnd, sec, eqFunc, callback, extra1, extra2)
   {
      var il;
      var _loc3_ = undefined;
      il = this.ints.length;
      _loc3_ = setInterval(function(obj)
      {
         obj.removeDelayedTween(il);
         if(mc._x != undefined)
         {
            obj.addTween(mc,props,pEnd,sec,eqFunc,callback,extra1,extra2);
         }
      }
      ,delay * 1000,this);
      this.ints[il] = {mc:mc,props:props,pend:pEnd,intid:_loc3_,st:getTimer(),delay:delay * 1000,args:arguments.slice(1),pt:-1};
      if(!this.playing)
      {
         this.init();
      }
   }
   function removeTween(mc, props)
   {
      var _loc8_ = undefined;
      var _loc2_ = undefined;
      var _loc5_ = undefined;
      _loc8_ = false;
      if(props == undefined && this.broadcastEvents != true)
      {
         _loc8_ = true;
      }
      _loc2_ = this.tweenList.length;
      var _loc4_ = {};
      while(true)
      {
         _loc2_;
         if(!_loc2_--)
         {
            break;
         }
         if(this.tweenList[_loc2_].mc == mc)
         {
            if(_loc8_)
            {
               this.tweenList.splice(_loc2_,1);
            }
            else
            {
               for(_loc5_ in props)
               {
                  if(this.tweenList[_loc2_].pp == props[_loc5_])
                  {
                     this.tweenList.splice(_loc2_,1);
                     if(_loc4_[targetPath(mc)] == undefined)
                     {
                        _loc4_[targetPath(mc)] = {t:mc,p:[]};
                     }
                     _loc4_[targetPath(mc)].p.push(props[_loc5_]);
                  }
                  else if(props[_loc5_] == "_ct_" && this.tweenList[_loc2_].ctm != undefined && this.tweenList[_loc2_].mc == mc)
                  {
                     this.tweenList.splice(_loc2_,1);
                     if(_loc4_[targetPath(mc)] == undefined)
                     {
                        _loc4_[targetPath(mc)] = {t:mc,p:[]};
                     }
                     _loc4_[targetPath(mc)].p.push("_ct_");
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
            if(_loc8_)
            {
               this.removeDelayedTween(Number(_loc2_));
            }
            else
            {
               for(_loc5_ in props)
               {
                  for(var _loc11_ in this.ints[_loc2_].props)
                  {
                     if(this.ints[_loc2_].props[_loc11_] == props[_loc5_])
                     {
                        this.ints[_loc2_].props.splice(_loc11_,1);
                        this.ints[_loc2_].pend.splice(_loc11_,1);
                        if(_loc4_[targetPath(mc)] == undefined)
                        {
                           _loc4_[targetPath(mc)] = {t:mc,p:[]};
                        }
                        _loc4_[targetPath(mc)].p.push(props[_loc5_]);
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
      if(this.broadcastEvents)
      {
         for(_loc11_ in _loc4_)
         {
            if(_loc4_[_loc11_].p.length > 0)
            {
               _loc4_[_loc11_].t.broadcastMessage("onTweenInterrupt",{target:_loc4_[_loc11_].t,props:_loc4_[_loc11_].p});
            }
         }
      }
      if(this.tweenList.length == 0)
      {
         this.deinit();
      }
   }
   function isTweening(mc, prop)
   {
      var _loc4_ = prop == undefined;
      for(var _loc6_ in this.tweenList)
      {
         var _loc2_ = this.tweenList[_loc6_];
         if(this.tweenList[_loc6_].mc == mc && this.tweenList[_loc6_].pt == -1 && (_loc4_ || prop == _loc2_.pp || prop == "_ct_" && _loc2_.ctm != undefined))
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
   function ffTween(mc, propsObj)
   {
      var _loc4_ = mc == undefined;
      var _loc6_ = propsObj == undefined;
      for(var _loc8_ in this.tweenList)
      {
         var _loc2_ = this.tweenList[_loc8_];
         if((_loc2_.mc == mc || _loc4_) && (_loc6_ || propsObj[_loc2_.pp] == true))
         {
            if(_loc2_.pt != -1)
            {
               _loc2_.pt = -1;
            }
            _loc2_.ts = this.now - _loc2_.d;
         }
      }
      for(_loc8_ in this.ints)
      {
         if(this.ints[_loc8_] != undefined)
         {
            if(this.ints[_loc8_].mc == mc || _loc4_)
            {
               if(this.ints[_loc8_].mc._x != undefined)
               {
                  var _loc3_ = this.ints[_loc8_].args;
                  _loc3_[3] = 0;
                  this.addTween.apply(this,_loc3_);
               }
               this.removeDelayedTween(Number(_loc8_));
            }
         }
      }
      this.update();
   }
   function rewTween(mc, propsObj)
   {
      var _loc3_ = mc == undefined;
      var _loc5_ = propsObj == undefined;
      for(var _loc7_ in this.tweenList)
      {
         var _loc2_ = this.tweenList[_loc7_];
         if((_loc2_.mc == mc || _loc3_) && (_loc5_ || propsObj[_loc2_.pp] == true))
         {
            if(_loc2_.pt != -1)
            {
               _loc2_.pt = -1;
            }
            _loc2_.ts = this.now;
         }
      }
      for(_loc7_ in this.ints)
      {
         if(this.ints[_loc7_] != undefined)
         {
            if(this.ints[_loc7_].mc == mc || _loc3_)
            {
               if(this.ints[_loc7_].mc._x != undefined)
               {
                  this.addTween.apply(this,this.ints[_loc7_].args);
               }
               this.removeDelayedTween(Number(_loc7_));
            }
         }
      }
      this.update();
   }
   function isTweenPaused(mc, prop)
   {
      if(mc == undefined)
      {
         return null;
      }
      var _loc5_ = prop == undefined;
      for(var _loc6_ in this.tweenList)
      {
         var _loc2_ = this.tweenList[_loc6_];
         if(this.tweenList[_loc6_].mc == mc && (_loc5_ || prop == _loc2_.pp || prop == "_ct_" && _loc2_.ctm != undefined))
         {
            return Boolean(this.tweenList[_loc6_].pt != -1);
         }
      }
      for(_loc6_ in this.ints)
      {
         if(this.ints[_loc6_] != undefined && this.ints[_loc6_].mc == mc)
         {
            return Boolean(this.ints[_loc6_].pt != -1);
         }
      }
      return false;
   }
   function pauseTween(mc, propsObj)
   {
      var _loc3_ = mc == undefined;
      if(_loc3_ == false && this.isTweenPaused(mc) == true)
      {
         return undefined;
      }
      var _loc6_ = propsObj == undefined;
      for(var _loc7_ in this.tweenList)
      {
         var _loc2_ = this.tweenList[_loc7_];
         if(_loc2_.pt == -1 && (_loc2_.mc == mc || _loc3_) && (_loc6_ || propsObj[_loc2_.pp] == true || propsObj._ct_ != undefined && _loc2_.ctm != undefined))
         {
            _loc2_.pt = this.now;
         }
      }
      for(_loc7_ in this.ints)
      {
         if(this.ints[_loc7_] != undefined)
         {
            if(this.ints[_loc7_].pt == -1 && (this.ints[_loc7_].mc == mc || _loc3_))
            {
               this.ints[_loc7_].pt = this.now;
            }
         }
      }
   }
   function unpauseTween(mc, propsObj)
   {
      var _loc4_ = mc == undefined;
      if(_loc4_ == false && this.isTweenPaused(mc) === false)
      {
         return undefined;
      }
      var _loc7_ = propsObj == undefined;
      if(!this.playing)
      {
         this.init();
      }
      for(var _loc2_ in this.tweenList)
      {
         var _loc3_ = this.tweenList[_loc2_];
         if(_loc3_.pt != -1 && (_loc3_.mc == mc || _loc4_) && (_loc7_ || propsObj[_loc3_.pp] == true) || propsObj._ct_ != undefined && _loc3_.ctm != undefined)
         {
            _loc3_.ts = this.now - (_loc3_.pt - _loc3_.ts);
            _loc3_.pt = -1;
         }
      }
      for(_loc2_ in this.ints)
      {
         if(this.ints[_loc2_] != undefined)
         {
            if(this.ints[_loc2_].pt != -1 && (this.ints[_loc2_].mc == mc || _loc4_))
            {
               this.ints[_loc2_].delay -= this.ints[_loc2_].pt - this.ints[_loc2_].st;
               this.ints[_loc2_].st = this.now;
               this.ints[_loc2_].intid = setInterval(function(obj, id)
               {
                  obj.addTween.apply(obj,obj.ints[id].args);
                  clearInterval(obj.ints[id].intid);
                  obj.ints[id] = undefined;
               }
               ,this.ints[_loc2_].delay,this,_loc2_);
            }
         }
      }
   }
   function pauseAll()
   {
      this.pauseTween();
   }
   function unpauseAll()
   {
      this.unpauseTween();
   }
   function stopAll()
   {
      for(var _loc2_ in this.ints)
      {
         this.removeDelayedTween(Number(_loc2_));
      }
      this.tweenList = new Array();
      this.deinit();
   }
   function toString()
   {
      return "[AS2 tweenManager 1.2.0]";
   }
}
