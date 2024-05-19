class zigo.tweenManager
{
   var updateTime;
   var tweenList;
   var lockedTweens;
   var _th_depth = 6789;
   function tweenManager()
   {
      var _loc1_ = this;
      _loc1_.playing = false;
      _loc1_.autoStop = false;
      _loc1_.broadcastEvents = false;
      _loc1_.autoOverwrite = true;
      _loc1_.ints = new Array();
      _loc1_.lockedTweens = new Object();
      _loc1_.tweenList = new Array();
   }
   function cleanUp()
   {
      var _loc1_ = this;
      if(_loc1_.tweenList instanceof Array && _loc1_.tweenList.length > 0)
      {
         for(var _loc2_ in _loc1_.tweenList)
         {
            if(_loc1_.tweenList[_loc2_].mc._x == undefined)
            {
               _loc1_.tweenList.splice(Number(_loc2_),1);
            }
         }
         if(_loc1_.tweenList.length == 0)
         {
            _loc1_.tweenList = [];
            _loc1_.deinit();
         }
         for(_loc2_ in _loc1_.ints)
         {
            if(_loc1_.ints[_loc2_] != undefined && _loc1_.ints[_loc2_].mc._x == undefined)
            {
               _loc1_.removeDelayedTween(Number(_loc2_));
            }
         }
      }
   }
   function set updateInterval(time)
   {
      var _loc1_ = this;
      if(_loc1_.playing)
      {
         _loc1_.deinit();
         _loc1_.updateTime = time;
         _loc1_.init();
      }
      else
      {
         _loc1_.updateTime = time;
      }
   }
   function get updateInterval()
   {
      return this.updateTime;
   }
   function set controllerDepth(v)
   {
      var _loc1_ = this;
      var _loc2_ = v;
      if(_global.isNaN(_loc2_) == true)
      {
      }
      if(_loc1_.tweenHolder._name != undefined)
      {
         _loc1_.tweenHolder.swapDepths(_loc2_);
      }
      else
      {
         _loc1_._th_depth = _loc2_;
      }
   }
   function get controllerDepth()
   {
      return this._th_depth;
   }
   function init()
   {
      var _loc1_ = this;
      if(_loc1_.updateTime > 0)
      {
         clearInterval(_loc1_.updateIntId);
         _loc1_.updateIntId = setInterval(_loc1_,"update",_loc1_.updateTime);
      }
      else
      {
         if(_loc1_.tweenHolder._name == undefined)
         {
            _loc1_.tweenHolder = _root.createEmptyMovieClip("_th_",_loc1_._th_depth);
         }
         var tm = _loc1_;
         _loc1_.tweenHolder.onEnterFrame = function()
         {
            tm.update.call(tm);
         };
      }
      _loc1_.playing = true;
      _loc1_.now = getTimer();
   }
   function deinit()
   {
      var _loc1_ = this;
      _loc1_.playing = false;
      clearInterval(_loc1_.updateIntId);
      delete _loc1_.tweenHolder.onEnterFrame;
   }
   function update()
   {
      var _loc3_ = this;
      var _loc1_ = undefined;
      var i;
      var _loc2_ = undefined;
      var missing = false;
      i = _loc3_.tweenList.length;
      if(_loc3_.broadcastEvents)
      {
         var ut;
         var et;
         var up;
         var ep;
         ut = {};
         et = {};
         up = {};
         ep = {};
      }
      while(i--)
      {
         _loc1_ = _loc3_.tweenList[i];
         if(_loc1_.mc._x == undefined)
         {
            missing = true;
         }
         else if(_loc1_.pt == -1)
         {
            if(_loc1_.ts + _loc1_.d > _loc3_.now)
            {
               if(_loc1_.ctm == undefined)
               {
                  _loc1_.mc[_loc1_.pp] = _loc1_.ef(_loc3_.now - _loc1_.ts,_loc1_.ps,_loc1_.ch,_loc1_.d,_loc1_.e1,_loc1_.e2);
               }
               else
               {
                  var ttm = {};
                  for(_loc2_ in _loc1_.ctm)
                  {
                     ttm[_loc2_] = _loc1_.ef(_loc3_.now - _loc1_.ts,_loc1_.stm[_loc2_],_loc1_.ctm[_loc2_],_loc1_.d,_loc1_.e1,_loc1_.e2);
                  }
                  _loc1_.c.setTransform(ttm);
               }
               if(_loc3_.broadcastEvents)
               {
                  if(ut[targetPath(_loc1_.mc)] == undefined)
                  {
                     ut[targetPath(_loc1_.mc)] = _loc1_.mc;
                  }
                  if(up[targetPath(_loc1_.mc)] == undefined)
                  {
                     up[targetPath(_loc1_.mc)] = [];
                  }
                  up[targetPath(_loc1_.mc)].push(_loc1_.ctm == undefined ? _loc1_.pp : "_ct_");
               }
               if(_loc1_.cb.updfunc != undefined)
               {
                  var f = _loc1_.cb.updfunc;
                  if(typeof f == "string" && _loc1_.cb.updscope != undefined)
                  {
                     f = _loc1_.cb.updscope[f];
                  }
                  f.apply(_loc1_.cb.updscope,_loc1_.cb.updargs);
               }
            }
            else
            {
               if(_loc1_.ctm == undefined)
               {
                  _loc1_.mc[_loc1_.pp] = _loc1_.ps + _loc1_.ch;
               }
               else
               {
                  var ttm = {};
                  for(_loc2_ in _loc1_.ctm)
                  {
                     ttm[_loc2_] = _loc1_.stm[_loc2_] + _loc1_.ctm[_loc2_];
                  }
                  _loc1_.c.setTransform(ttm);
               }
               if(_loc3_.broadcastEvents)
               {
                  if(ut[targetPath(_loc1_.mc)] == undefined)
                  {
                     ut[targetPath(_loc1_.mc)] = _loc1_.mc;
                  }
                  if(et[targetPath(_loc1_.mc)] == undefined)
                  {
                     et[targetPath(_loc1_.mc)] = _loc1_.mc;
                  }
                  if(up[targetPath(_loc1_.mc)] == undefined)
                  {
                     up[targetPath(_loc1_.mc)] = [];
                  }
                  up[targetPath(_loc1_.mc)].push(_loc1_.ctm == undefined ? _loc1_.pp : "_ct_");
                  if(ep[targetPath(_loc1_.mc)] == undefined)
                  {
                     ep[targetPath(_loc1_.mc)] = [];
                  }
                  ep[targetPath(_loc1_.mc)].push(_loc1_.ctm == undefined ? _loc1_.pp : "_ct_");
               }
               if(_loc1_.cb.updfunc != undefined)
               {
                  var f = _loc1_.cb.updfunc;
                  if(typeof f == "string" && _loc1_.cb.updscope != undefined)
                  {
                     f = _loc1_.cb.updscope[f];
                  }
                  f.updfunc.apply(_loc1_.cb.updscope,_loc1_.cb.updargs);
               }
               if(endt == undefined)
               {
                  var endt = new Array();
               }
               endt.push(i);
            }
         }
      }
      if(missing)
      {
         _loc3_.cleanUp();
      }
      for(_loc2_ in ut)
      {
         ut[_loc2_].broadcastMessage("onTweenUpdate",{target:ut[_loc2_],props:up[_loc2_]});
      }
      if(endt != undefined)
      {
         _loc3_.endTweens(endt);
      }
      for(_loc2_ in et)
      {
         et[_loc2_].broadcastMessage("onTweenEnd",{target:et[_loc2_],props:ep[_loc2_]});
      }
      _loc3_.now = getTimer();
      if(_loc3_.updateTime > 0)
      {
         updateAfterEvent();
      }
   }
   function endTweens(tid_arr)
   {
      var _loc1_ = undefined;
      var tl;
      var _loc2_ = undefined;
      var cb;
      var j;
      _loc1_ = [];
      tl = tid_arr.length;
      _loc2_ = 0;
      while(_loc2_ < tl)
      {
         cb = this.tweenList[tid_arr[_loc2_]].cb;
         if(cb != undefined)
         {
            var exec = true;
            for(var j in _loc1_)
            {
               if(_loc1_[j] == cb)
               {
                  exec = false;
                  break;
               }
            }
            if(exec)
            {
               _loc1_.push(cb);
            }
         }
         this.tweenList.splice(tid_arr[_loc2_],1);
         _loc2_ = _loc2_ + 1;
      }
      _loc2_ = 0;
      while(_loc2_ < _loc1_.length)
      {
         var _loc3_ = _loc1_[_loc2_].func;
         if(typeof _loc3_ == "string" && _loc1_[_loc2_].scope != undefined)
         {
            _loc3_ = _loc1_[_loc2_].scope[_loc3_];
         }
         _loc3_.apply(_loc1_[_loc2_].scope,_loc1_[_loc2_].args);
         _loc2_ = _loc2_ + 1;
      }
      if(this.tweenList.length == 0)
      {
         this.deinit();
      }
   }
   function removeDelayedTween(index)
   {
      var _loc1_ = this;
      clearInterval(_loc1_.ints[index].intid);
      _loc1_.ints[index] = undefined;
      var _loc2_ = true;
      for(var _loc3_ in _loc1_.ints)
      {
         if(_loc1_.ints[_loc3_] != undefined)
         {
            _loc2_ = false;
            break;
         }
      }
      if(_loc2_)
      {
         _loc1_.ints = [];
      }
   }
   function addTween(mc, props, pEnd, sec, eqFunc, callback, extra1, extra2)
   {
      var _loc3_ = this;
      var i;
      var pp;
      var addnew;
      var _loc2_ = undefined;
      var _loc1_ = undefined;
      if(!_loc3_.playing)
      {
         _loc3_.init();
      }
      var ip = [];
      for(i in props)
      {
         pp = props[i];
         addnew = true;
         if(pp.substr(0,4) != "_ct_")
         {
            var ch = typeof pEnd[i] != "string" ? pEnd[i] - mc[pp] : Number(pEnd[i]);
            if(_loc3_.autoOverwrite)
            {
               for(_loc2_ in _loc3_.tweenList)
               {
                  _loc1_ = _loc3_.tweenList[_loc2_];
                  if(_loc1_.mc == mc && _loc1_.pp == pp)
                  {
                     _loc1_.ps = mc[pp];
                     _loc1_.ch = ch;
                     _loc1_.ts = _loc3_.now;
                     _loc1_.d = sec * 1000;
                     _loc1_.ef = eqFunc;
                     _loc1_.cb = callback;
                     _loc1_.e1 = extra1;
                     _loc1_.e2 = extra2;
                     _loc1_.pt = -1;
                     addnew = false;
                     ip.push(_loc1_.pp);
                     break;
                  }
               }
            }
            if(addnew)
            {
               _loc3_.tweenList.unshift({mc:mc,pp:pp,ps:mc[pp],ch:ch,ts:_loc3_.now,d:sec * 1000,ef:eqFunc,cb:callback,e1:extra1,e2:extra2,pt:-1});
            }
         }
         else
         {
            var c = new Color(mc);
            var stm = c.getTransform();
            var ctm = {};
            for(_loc2_ in pEnd[i])
            {
               if(pEnd[i][_loc2_] != stm[_loc2_] && pEnd[i][_loc2_] != undefined)
               {
                  ctm[_loc2_] = typeof pEnd[i][_loc2_] != "string" ? pEnd[i][_loc2_] - stm[_loc2_] : stm[_loc2_] + Number(pEnd[i][_loc2_]);
               }
            }
            if(_loc3_.autoOverwrite)
            {
               for(_loc2_ in _loc3_.tweenList)
               {
                  _loc1_ = _loc3_.tweenList[_loc2_];
                  if(_loc1_.mc == mc && _loc1_.ctm != undefined)
                  {
                     _loc1_.c = c;
                     _loc1_.stm = stm;
                     _loc1_.ctm = ctm;
                     _loc1_.ts = _loc3_.now;
                     _loc1_.d = sec * 1000;
                     _loc1_.ef = eqFunc;
                     _loc1_.cb = callback;
                     _loc1_.e1 = extra1;
                     _loc1_.e2 = extra2;
                     _loc1_.pt = -1;
                     addnew = false;
                     ip.push("_ct_");
                     break;
                  }
               }
            }
            if(addnew)
            {
               _loc3_.tweenList.unshift({mc:mc,c:c,stm:stm,ctm:ctm,ts:_loc3_.now,d:sec * 1000,ef:eqFunc,cb:callback,e1:extra1,e2:extra2,pt:-1});
            }
         }
      }
      if(_loc3_.broadcastEvents)
      {
         if(ip.length > 0)
         {
            mc.broadcastMessage("onTweenInterrupt",{target:mc,props:ip});
         }
         mc.broadcastMessage("onTweenStart",{target:mc,props:props});
      }
      if(callback.startfunc != undefined)
      {
         var f = callback.startfunc;
         if(typeof f == "string" && callback.startscope != undefined)
         {
            f = callback.startscope[f];
         }
         f.apply(callback.startscope,callback.startargs);
      }
      if(sec == 0)
      {
         _loc3_.update();
      }
   }
   function addTweenWithDelay(delay, mc, props, pEnd, sec, eqFunc, callback, extra1, extra2)
   {
      var _loc1_ = this;
      var il;
      var intid;
      il = _loc1_.ints.length;
      intid = setInterval(function(obj)
      {
         obj.removeDelayedTween(il);
         if(mc._x != undefined)
         {
            obj.addTween(mc,props,pEnd,sec,eqFunc,callback,extra1,extra2);
         }
      }
      ,delay * 1000,_loc1_);
      _loc1_.ints[il] = {mc:mc,props:props,pend:pEnd,intid:intid,st:getTimer(),delay:delay * 1000,args:arguments.slice(1),pt:-1};
      if(!_loc1_.playing)
      {
         _loc1_.init();
      }
   }
   function removeTween(mc, props)
   {
      var _loc2_ = mc;
      var _loc3_ = this;
      var all;
      var _loc1_ = undefined;
      var j;
      all = false;
      if(props == undefined && _loc3_.broadcastEvents != true)
      {
         all = true;
      }
      _loc1_ = _loc3_.tweenList.length;
      var ip = {};
      while(true)
      {
         _loc1_;
         if(!_loc1_--)
         {
            break;
         }
         if(_loc3_.tweenList[_loc1_].mc == _loc2_)
         {
            if(all)
            {
               _loc3_.tweenList.splice(_loc1_,1);
            }
            else
            {
               for(j in props)
               {
                  if(_loc3_.tweenList[_loc1_].pp == props[j])
                  {
                     _loc3_.tweenList.splice(_loc1_,1);
                     if(ip[targetPath(_loc2_)] == undefined)
                     {
                        ip[targetPath(_loc2_)] = {t:_loc2_,p:[]};
                     }
                     ip[targetPath(_loc2_)].p.push(props[j]);
                  }
                  else if(props[j] == "_ct_" && _loc3_.tweenList[_loc1_].ctm != undefined && _loc3_.tweenList[_loc1_].mc == _loc2_)
                  {
                     _loc3_.tweenList.splice(_loc1_,1);
                     if(ip[targetPath(_loc2_)] == undefined)
                     {
                        ip[targetPath(_loc2_)] = {t:_loc2_,p:[]};
                     }
                     ip[targetPath(_loc2_)].p.push("_ct_");
                  }
               }
            }
         }
      }
      _loc1_ = _loc3_.ints.length;
      while(true)
      {
         _loc1_;
         if(!_loc1_--)
         {
            break;
         }
         if(_loc3_.ints[_loc1_].mc == _loc2_)
         {
            if(all)
            {
               _loc3_.removeDelayedTween(Number(_loc1_));
            }
            else
            {
               for(j in props)
               {
                  for(var k in _loc3_.ints[_loc1_].props)
                  {
                     if(_loc3_.ints[_loc1_].props[k] == props[j])
                     {
                        _loc3_.ints[_loc1_].props.splice(k,1);
                        _loc3_.ints[_loc1_].pend.splice(k,1);
                        if(ip[targetPath(_loc2_)] == undefined)
                        {
                           ip[targetPath(_loc2_)] = {t:_loc2_,p:[]};
                        }
                        ip[targetPath(_loc2_)].p.push(props[j]);
                     }
                  }
                  if(_loc3_.ints[_loc1_].props.length == 0)
                  {
                     clearInterval(_loc3_.ints[_loc1_].intid);
                  }
               }
            }
         }
      }
      if(_loc3_.broadcastEvents)
      {
         for(var k in ip)
         {
            if(ip[k].p.length > 0)
            {
               ip[k].t.broadcastMessage("onTweenInterrupt",{target:ip[k].t,props:ip[k].p});
            }
         }
      }
      if(_loc3_.tweenList.length == 0)
      {
         _loc3_.deinit();
      }
   }
   function isTweening(mc, prop)
   {
      var _loc2_ = this;
      var _loc3_ = prop;
      var allprops = _loc3_ == undefined;
      for(var i in _loc2_.tweenList)
      {
         var _loc1_ = _loc2_.tweenList[i];
         if(_loc2_.tweenList[i].mc == mc && _loc2_.tweenList[i].pt == -1 && (allprops || _loc3_ == _loc1_.pp || _loc3_ == "_ct_" && _loc1_.ctm != undefined))
         {
            return true;
         }
      }
      return false;
   }
   function getTweens(mc)
   {
      var _loc1_ = this;
      var _loc3_ = mc;
      var _loc2_ = 0;
      for(var i in _loc1_.tweenList)
      {
         if(_loc1_.tweenList[i].mc == _loc3_)
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
      var _loc1_ = this;
      var all = mc == undefined;
      var allprops = propsObj == undefined;
      for(var i in _loc1_.tweenList)
      {
         var _loc2_ = _loc1_.tweenList[i];
         if((_loc2_.mc == mc || all) && (allprops || propsObj[_loc2_.pp] == true))
         {
            if(_loc2_.pt != -1)
            {
               _loc2_.pt = -1;
            }
            _loc2_.ts = _loc1_.now - _loc2_.d;
         }
      }
      for(var i in _loc1_.ints)
      {
         if(_loc1_.ints[i] != undefined)
         {
            if(_loc1_.ints[i].mc == mc || all)
            {
               if(_loc1_.ints[i].mc._x != undefined)
               {
                  var _loc3_ = _loc1_.ints[i].args;
                  _loc3_[3] = 0;
                  _loc1_.addTween.apply(_loc1_,_loc3_);
               }
               _loc1_.removeDelayedTween(Number(i));
            }
         }
      }
      _loc1_.update();
   }
   function rewTween(mc, propsObj)
   {
      var _loc1_ = this;
      var _loc3_ = mc == undefined;
      var allprops = propsObj == undefined;
      for(var i in _loc1_.tweenList)
      {
         var _loc2_ = _loc1_.tweenList[i];
         if((_loc2_.mc == mc || _loc3_) && (allprops || propsObj[_loc2_.pp] == true))
         {
            if(_loc2_.pt != -1)
            {
               _loc2_.pt = -1;
            }
            _loc2_.ts = _loc1_.now;
         }
      }
      for(var i in _loc1_.ints)
      {
         if(_loc1_.ints[i] != undefined)
         {
            if(_loc1_.ints[i].mc == mc || _loc3_)
            {
               if(_loc1_.ints[i].mc._x != undefined)
               {
                  _loc1_.addTween.apply(_loc1_,_loc1_.ints[i].args);
               }
               _loc1_.removeDelayedTween(Number(i));
            }
         }
      }
      _loc1_.update();
   }
   function isTweenPaused(mc, prop)
   {
      var _loc1_ = this;
      var _loc3_ = mc;
      if(_loc3_ == undefined)
      {
         return null;
      }
      var allprops = prop == undefined;
      for(var i in _loc1_.tweenList)
      {
         var _loc2_ = _loc1_.tweenList[i];
         if(_loc1_.tweenList[i].mc == _loc3_ && (allprops || prop == _loc2_.pp || prop == "_ct_" && _loc2_.ctm != undefined))
         {
            return Boolean(_loc1_.tweenList[i].pt != -1);
         }
      }
      for(var i in _loc1_.ints)
      {
         if(_loc1_.ints[i] != undefined && _loc1_.ints[i].mc == _loc3_)
         {
            return Boolean(_loc1_.ints[i].pt != -1);
         }
      }
      return false;
   }
   function pauseTween(mc, propsObj)
   {
      var _loc1_ = this;
      var _loc3_ = mc == undefined;
      if(!(_loc3_ == false && _loc1_.isTweenPaused(mc) == true))
      {
         var allprops = propsObj == undefined;
         for(var i in _loc1_.tweenList)
         {
            var _loc2_ = _loc1_.tweenList[i];
            if(_loc2_.pt == -1 && (_loc2_.mc == mc || _loc3_) && (allprops || propsObj[_loc2_.pp] == true || propsObj._ct_ != undefined && _loc2_.ctm != undefined))
            {
               _loc2_.pt = _loc1_.now;
            }
         }
         for(var i in _loc1_.ints)
         {
            if(_loc1_.ints[i] != undefined)
            {
               if(_loc1_.ints[i].pt == -1 && (_loc1_.ints[i].mc == mc || _loc3_))
               {
                  _loc1_.ints[i].pt = _loc1_.now;
               }
            }
         }
      }
   }
   function unpauseTween(mc, propsObj)
   {
      var _loc1_ = this;
      var all = mc == undefined;
      if(!(all == false && _loc1_.isTweenPaused(mc) === false))
      {
         var allprops = propsObj == undefined;
         if(!_loc1_.playing)
         {
            _loc1_.init();
         }
         for(var _loc2_ in _loc1_.tweenList)
         {
            var _loc3_ = _loc1_.tweenList[_loc2_];
            if(_loc3_.pt != -1 && (_loc3_.mc == mc || all) && (allprops || propsObj[_loc3_.pp] == true) || propsObj._ct_ != undefined && _loc3_.ctm != undefined)
            {
               _loc3_.ts = _loc1_.now - (_loc3_.pt - _loc3_.ts);
               _loc3_.pt = -1;
            }
         }
         for(_loc2_ in _loc1_.ints)
         {
            if(_loc1_.ints[_loc2_] != undefined)
            {
               if(_loc1_.ints[_loc2_].pt != -1 && (_loc1_.ints[_loc2_].mc == mc || all))
               {
                  _loc1_.ints[_loc2_].delay -= _loc1_.ints[_loc2_].pt - _loc1_.ints[_loc2_].st;
                  _loc1_.ints[_loc2_].st = _loc1_.now;
                  _loc1_.ints[_loc2_].intid = setInterval(function(obj, id)
                  {
                     var _loc1_ = obj;
                     var _loc2_ = id;
                     _loc1_.addTween.apply(_loc1_,_loc1_.ints[_loc2_].args);
                     clearInterval(_loc1_.ints[_loc2_].intid);
                     _loc1_.ints[_loc2_] = undefined;
                  }
                  ,_loc1_.ints[_loc2_].delay,_loc1_,_loc2_);
               }
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
      var _loc1_ = this;
      for(var _loc2_ in _loc1_.ints)
      {
         _loc1_.removeDelayedTween(Number(_loc2_));
      }
      _loc1_.tweenList = new Array();
      _loc1_.deinit();
   }
   function toString()
   {
      return "[AS2 tweenManager 1.2.0]";
   }
}
