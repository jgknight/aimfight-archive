class Tooltip extends MovieClip
{
   var me;
   var tooltipHit;
   var initY;
   var titleEffect;
   var tipHeight;
   var textEffect;
   function Tooltip()
   {
      super();
      this.me = this;
      this.me.stopTween();
      this.tooltipHit = true;
      this.initY = this.me._y;
      setInterval(this,"testTooltipHit",500);
   }
   function setTitle(theTitle)
   {
      this.titleEffect = new ibTextEffect();
      this.titleEffect.start("vivaTypeIn",{textObj:this.me.title_txt,theText:theTitle,speed:1,numOfChars:theTitle.length,endChar:"",theColor:39372});
   }
   function setText(theText)
   {
      this.me._txt.autoSize = "left";
      this.me._txt.html = true;
      this.me._txt.htmlText = theText;
      this.me._txt.condenseWhite = true;
      this.me._txt._visible = 0;
      this.tipHeight = this.me._txt.textHeight;
      this.me._txt.text = "";
      this.me._txt._visible = 1;
      this.textEffect = new ibTextEffect();
      this.textEffect.start("vivaTypeIn",{textObj:this.me._txt,theText:theText,speed:1,numOfChars:15,endChar:""});
      this.setSize();
   }
   function setSize()
   {
      this.me._txt._y = this.me._txt._y - this.tipHeight + 15;
      this.me.ttMid._height = this.tipHeight + 7;
      this.me.ttMid._y = this.me._txt._y - 1;
      this.me.ttTop._y = this.me._txt._y - 3;
   }
   function setScrollBar()
   {
      this.me.attachMovie("ib_ScrollBar_base","ttScroll",1,{_x:202,_y:11,_alpha:0});
      this.me.ttScroll.setTarget(this.me._txt,false);
      this.me.ttScroll.setScrollColors(39372,16777215);
      this.me.ttScroll.tween("_alpha",100,0.3,"easeOutQuad");
   }
   function testTooltipHit()
   {
      if(this.me.hitTest(_root._xmouse,_root._ymouse,true) || this.me.ref.hitTest(_root._xmouse,_root._ymouse,true))
      {
         if(!this.tooltipHit)
         {
            this.tooltipHit = true;
         }
      }
      else if(this.tooltipHit)
      {
         this.tooltipHit = false;
         this.hideTooltip();
      }
   }
   function hideTooltip()
   {
      this.me.tween("_alpha",0,0.8,undefined,0,{scope:this.me,func:this.me.removeMovieClip});
   }
}
