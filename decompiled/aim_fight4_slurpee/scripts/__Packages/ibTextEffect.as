class ibTextEffect
{
   var amPlaying;
   var effectQueue = new Array();
   function ibTextEffect(clip)
   {
      var _loc1_ = this;
      _loc1_.me = clip;
      _loc1_.amPlaying = false;
      _loc1_.clearQueue();
   }
   function addToQueue(type, params)
   {
      this.effectQueue.push({type:type,params:params});
   }
   function clearQueue()
   {
      var _loc1_ = this;
      if(_loc1_.effectQueue)
      {
         delete _loc1_.effectQueue;
      }
      _loc1_.effectQueue = new Array();
   }
   function getQueue()
   {
      return this.effectQueue;
   }
   function start(type, params)
   {
      var _loc1_ = this;
      _loc1_.amPlaying = true;
      if(type != undefined && params != undefined)
      {
         _loc1_.effectType = type;
         _loc1_.effectParams = params;
         _loc1_.queuePlayback = false;
         _loc1_.callEffectFunction(_loc1_.effectType);
      }
      else
      {
         _loc1_.queuePlayback = true;
         _loc1_.startQueue();
      }
   }
   function startQueue()
   {
      var _loc1_ = this;
      _loc1_.amPlaying = true;
      _loc1_.queueID = 0;
      _loc1_.callEffectFunction(_loc1_.effectQueue[_loc1_.queueID].type);
   }
   function callEffectFunction(type)
   {
      var _loc1_ = this;
      clearInterval(_loc1_.myEffect.myInterval);
      _loc1_.myEffect.params = {};
      delete _loc1_.myEffect;
      if(type == "vivaTypeIn")
      {
         if(_loc1_.queuePlayback)
         {
            _loc1_.effectParams = _loc1_.effectQueue[_loc1_.queueID].params;
         }
         _loc1_.myEffect = new ibTextEffects_VivaTypeIn(_loc1_.me,_loc1_.effectParams,_loc1_);
      }
      else
      {
         trace("Error: Unknown Effect Type Specified");
      }
   }
   function stop()
   {
      var _loc1_ = this;
      _loc1_.queueID = _loc1_.effectQueue.length;
      _loc1_.amPlaying = false;
   }
   function nextInQueue()
   {
      var _loc1_ = this;
      clearInterval(_loc1_.nextInQueueInterval);
      _loc1_.queueID = _loc1_.queueID + 1;
      if(_loc1_.queueID == _loc1_.effectQueue.length)
      {
         _loc1_.amPlaying = false;
      }
      else
      {
         _loc1_.amPlaying = true;
         _loc1_.callEffectFunction(_loc1_.effectQueue[_loc1_.queueID].type);
      }
   }
   function effectDone(p)
   {
      var _loc1_ = this;
      if(_loc1_.queuePlayback)
      {
         if(p != undefined)
         {
            _loc1_.nextInQueueInterval = setInterval(_loc1_,"nextInQueue",p);
         }
         else
         {
            _loc1_.nextInQueue();
         }
      }
      else
      {
         _loc1_.amPlaying = false;
      }
   }
   function callBack(t)
   {
      var _loc1_ = t;
      var _loc2_ = this;
      if(_loc1_.params.callBackScope == undefined)
      {
         _loc2_.me[_loc1_.params.callBackFunc](_loc1_.params.callBackParams);
      }
      else
      {
         var _loc3_ = _loc2_.me[_loc1_.params.callBackScope];
         _loc3_[_loc1_.params.callBackFunc](_loc1_.params.callBackParams);
      }
      if(_loc1_.params.pause)
      {
         _loc2_.effectDone(_loc1_.params.pause);
      }
      else
      {
         _loc2_.effectDone();
      }
      false;
   }
   function isPlaying()
   {
      return this.amPlaying;
   }
   function clearEffect()
   {
      var _loc1_ = this;
      clearInterval(_loc1_.myEffect.myInterval);
      _loc1_.myEffect.params = {};
      delete _loc1_.myEffect;
   }
}
