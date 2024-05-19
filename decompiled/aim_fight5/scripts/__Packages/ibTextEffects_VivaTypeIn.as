class ibTextEffects_VivaTypeIn extends ibTextEffect
{
   var parent;
   var me;
   var thisClass;
   var myInterval;
   function ibTextEffects_VivaTypeIn(clip, params, p)
   {
      super();
      this.parent = p;
      this.me = clip;
      this.thisClass = this;
      this.thisClass.textObj = params.textObj;
      this.thisClass.theText = params.theText;
      this.thisClass.lineSpeed = params.lineSpeed;
      this.thisClass.speed = params.speed;
      this.thisClass.numOfChars = params.numOfChars;
      this.thisClass.endChar = params.endChar;
      this.thisClass.params = params;
      this.thisClass.endLine = this.thisClass.theText.length - this.thisClass.numOfChars;
      this.thisClass.begin = 0;
      this.thisClass.end = this.thisClass.theText.length;
      this.thisClass.oldText = params.textObj.text;
      this.thisClass.oldBegin = this.thisClass.oldText.length;
      this.thisClass.oldEnd = 0;
      this.thisClass.oldEndChar = params.oldEndChar;
      this.thisClass.oldFormat = params.textObj.getTextFormat();
      this.thisClass.oldFormat.color = "0x999999";
      clearInterval(this.myInterval);
      if(this.thisClass.lineSpeed == undefined)
      {
         this.myInterval = setInterval(this,"vivaCharTypeIn",30,this.thisClass);
      }
      else if(this.thisClass.oldText == "")
      {
         this.myInterval = setInterval(this,"vivaLineTypeIn",30,this.thisClass);
      }
      else
      {
         this.myInterval = setInterval(this,"vivaLineTypeOut",30,this.thisClass);
      }
   }
   function vivaLineTypeOut(t)
   {
      t.textObj.html = true;
      t.textObj.setTextFormat(t.oldFormat);
      if(t.oldBegin < t.lineSpeed * 1.5)
      {
         t.textObj.htmlText = "";
         clearInterval(this.myInterval);
         if(t.lineSpeed == undefined)
         {
            this.myInterval = setInterval(this,"vivaCharTypeIn",30,this.thisClass);
         }
         else
         {
            this.myInterval = setInterval(this,"vivaLineTypeIn",30,this.thisClass);
         }
      }
      else
      {
         t.oldBegin -= t.lineSpeed * 1.5;
         t.textObj.htmlText = t.oldText.substr(0,t.oldBegin) + t.oldEndChar;
         t.textObj.setTextFormat(t.oldFormat);
      }
   }
   function vivaLineTypeIn(t)
   {
      t.textObj.html = true;
      if(t.begin > t.endLine - t.lineSpeed)
      {
         t.textObj.htmlText = t.theText.substr(0,t.endLine);
         clearInterval(this.myInterval);
         this.myInterval = setInterval(this,"vivaCharTypeIn",30,this.thisClass);
      }
      else
      {
         t.begin += t.lineSpeed;
         t.textObj.htmlText = t.theText.substr(0,t.begin) + t.endChar;
      }
   }
   function vivaCharTypeIn(t)
   {
      t.textObj.html = true;
      if(t.endLine > t.end)
      {
         t.textObj.htmlText = t.theText;
         this.endVivaTypeIn(t);
      }
      else
      {
         t.endLine += t.speed;
         t.textObj.htmlText = t.theText.substr(0,t.endLine) + t.endChar;
      }
   }
   function endVivaTypeIn(t)
   {
      clearInterval(this.myInterval);
      delete this.myInterval;
      this.parent.callBack(t);
   }
}
