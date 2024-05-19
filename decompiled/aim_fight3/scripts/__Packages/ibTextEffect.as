class ibTextEffect
{
   var me;
   var amPlaying;
   var effectType;
   var effectParams;
   var queuePlayback;
   var queueID;
   var myEffect;
   var nextInQueueInterval;
   var effectQueue = new Array();
   function ibTextEffect(clip)
   {
      this.me = clip;
      this.amPlaying = false;
      this.clearQueue();
   }
   function addToQueue(type, params)
   {
      this.effectQueue.push({type:type,params:params});
   }
   function clearQueue()
   {
      if(this.effectQueue)
      {
         delete this.effectQueue;
      }
      this.effectQueue = new Array();
   }
   function getQueue()
   {
      return this.effectQueue;
   }
   function start(type, params)
   {
      this.amPlaying = true;
      if(type != undefined && params != undefined)
      {
         this.effectType = type;
         this.effectParams = params;
         this.queuePlayback = false;
         this.callEffectFunction(this.effectType);
      }
      else
      {
         this.queuePlayback = true;
         this.startQueue();
      }
   }
   function startQueue()
   {
      this.amPlaying = true;
      this.queueID = 0;
      this.callEffectFunction(this.effectQueue[this.queueID].type);
   }
   function callEffectFunction(type)
   {
      clearInterval(this.myEffect.myInterval);
      this.myEffect.params = {};
      delete this.myEffect;
      if(type == "vivaTypeIn")
      {
         if(this.queuePlayback)
         {
            this.effectParams = this.effectQueue[this.queueID].params;
         }
         this.myEffect = new ibTextEffects_VivaTypeIn(this.me,this.effectParams,this);
      }
      else
      {
         trace("Error: Unknown Effect Type Specified");
      }
   }
   function stop()
   {
      this.queueID = this.effectQueue.length;
      this.amPlaying = false;
   }
   function nextInQueue()
   {
      clearInterval(this.nextInQueueInterval);
      this.queueID = this.queueID + 1;
      if(this.queueID == this.effectQueue.length)
      {
         this.amPlaying = false;
      }
      else
      {
         this.amPlaying = true;
         this.callEffectFunction(this.effectQueue[this.queueID].type);
      }
   }
   function effectDone(p)
   {
      if(this.queuePlayback)
      {
         if(p != undefined)
         {
            this.nextInQueueInterval = setInterval(this,"nextInQueue",p);
         }
         else
         {
            this.nextInQueue();
         }
      }
      else
      {
         this.amPlaying = false;
      }
   }
   function callBack(t)
   {
      if(t.params.callBackScope == undefined)
      {
         this.me[t.params.callBackFunc](t.params.callBackParams);
      }
      else
      {
         var _loc3_ = this.me[t.params.callBackScope];
         _loc3_[t.params.callBackFunc](t.params.callBackParams);
      }
      if(t.params.pause)
      {
         this.effectDone(t.params.pause);
      }
      else
      {
         this.effectDone();
      }
      false;
   }
   function isPlaying()
   {
      return this.amPlaying;
   }
   function clearEffect()
   {
      clearInterval(this.myEffect.myInterval);
      this.myEffect.params = {};
      delete this.myEffect;
   }
}
