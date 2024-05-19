class ibTextEffects_VivaTypeIn extends ibTextEffect
{
   function ibTextEffects_VivaTypeIn(clip, params, p)
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
   }
   function vivaLineTypeOut(t)
   {
      var _loc1_ = t;
      var _loc2_ = this;
      _loc1_.textObj.html = true;
      _loc1_.textObj.setTextFormat(_loc1_.oldFormat);
      if(_loc1_.oldBegin < _loc1_.lineSpeed * 1.5)
      {
         _loc1_.textObj.htmlText = "";
         clearInterval(_loc2_.myInterval);
         if(_loc1_.lineSpeed == undefined)
         {
            _loc2_.myInterval = setInterval(_loc2_,"vivaCharTypeIn",30,_loc2_.thisClass);
         }
         else
         {
            _loc2_.myInterval = setInterval(_loc2_,"vivaLineTypeIn",30,_loc2_.thisClass);
         }
      }
      else
      {
         _loc1_.oldBegin -= _loc1_.lineSpeed * 1.5;
         _loc1_.textObj.htmlText = _loc1_.oldText.substr(0,_loc1_.oldBegin) + _loc1_.oldEndChar;
         _loc1_.textObj.setTextFormat(_loc1_.oldFormat);
      }
   }
   function vivaLineTypeIn(t)
   {
      var _loc1_ = t;
      var _loc2_ = this;
      _loc1_.textObj.html = true;
      if(_loc1_.begin > _loc1_.endLine - _loc1_.lineSpeed)
      {
         _loc1_.textObj.htmlText = _loc1_.theText.substr(0,_loc1_.endLine);
         clearInterval(_loc2_.myInterval);
         _loc2_.myInterval = setInterval(_loc2_,"vivaCharTypeIn",30,_loc2_.thisClass);
      }
      else
      {
         _loc1_.begin += _loc1_.lineSpeed;
         _loc1_.textObj.htmlText = _loc1_.theText.substr(0,_loc1_.begin) + _loc1_.endChar;
      }
   }
   function vivaCharTypeIn(t)
   {
      var _loc1_ = t;
      _loc1_.textObj.html = true;
      if(_loc1_.endLine > _loc1_.end)
      {
         _loc1_.textObj.htmlText = _loc1_.theText;
         this.endVivaTypeIn(_loc1_);
      }
      else
      {
         _loc1_.endLine += _loc1_.speed;
         _loc1_.textObj.htmlText = _loc1_.theText.substr(0,_loc1_.endLine) + _loc1_.endChar;
      }
   }
   function endVivaTypeIn(t)
   {
      var _loc1_ = this;
      clearInterval(_loc1_.myInterval);
      delete _loc1_.myInterval;
      _loc1_.parent.callBack(t);
   }
}
