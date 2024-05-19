if(!_global.ibTextEffects_VivaTypeIn)
{
   var _loc1_ = null;
   _global.ibTextEffects_VivaTypeIn = _loc1_ = function(clip, params, p)
   {
      var _loc1_ = this;
      var _loc2_ = params;
      super();
      _loc1_.parent = p;
      _loc1_.me = clip;
      _loc1_.thisClass = _loc1_;
      _loc1_.thisClass.textObj = _loc2_.textObj;
      _loc1_.thisClass.theText = _loc2_.theText;
      _loc1_.thisClass.lineSpeed = _loc2_.lineSpeed;
      _loc1_.thisClass.speed = _loc2_.speed;
      _loc1_.thisClass.numOfChars = _loc2_.numOfChars;
      _loc1_.thisClass.endChar = _loc2_.endChar;
      _loc1_.thisClass.params = _loc2_;
      _loc1_.thisClass.endLine = _loc1_.thisClass.theText.length - _loc1_.thisClass.numOfChars;
      _loc1_.thisClass.begin = 0;
      _loc1_.thisClass.end = _loc1_.thisClass.theText.length;
      _loc1_.thisClass.oldText = _loc2_.textObj.text;
      _loc1_.thisClass.oldBegin = _loc1_.thisClass.oldText.length;
      _loc1_.thisClass.oldEnd = 0;
      _loc1_.thisClass.oldEndChar = _loc2_.oldEndChar;
      _loc1_.thisClass.oldFormat = _loc2_.textObj.getTextFormat();
      _loc1_.thisClass.oldFormat.color = "0x999999";
      clearInterval(_loc1_.myInterval);
      if(_loc1_.thisClass.lineSpeed == undefined)
      {
         _loc1_.myInterval = setInterval(_loc1_,"vivaCharTypeIn",30,_loc1_.thisClass);
      }
      else if(_loc1_.thisClass.oldText == "")
      {
         _loc1_.myInterval = setInterval(_loc1_,"vivaLineTypeIn",30,_loc1_.thisClass);
      }
      else
      {
         _loc1_.myInterval = setInterval(_loc1_,"vivaLineTypeOut",30,_loc1_.thisClass);
      }
   };
   §§push(_global);
   §§push("ibTextEffects_VivaTypeIn");
}
else
{
   §§pop();
}
