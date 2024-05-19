class Tooltip extends MovieClip
{
   function Tooltip()
   {
      var _loc1_ = this;
      super();
      _loc1_.me = _loc1_;
      _loc1_.me.stopTween();
      _loc1_.tooltipHit = true;
      _loc1_.initY = _loc1_.me._y;
      setInterval(_loc1_,"testTooltipHit",500);
   }
   function setTitle(theTitle)
   {
      var _loc1_ = this;
      _loc1_.titleEffect = new ibTextEffect();
      _loc1_.titleEffect.start("vivaTypeIn",{textObj:_loc1_.me.title_txt,theText:theTitle,speed:1,numOfChars:theTitle.length,endChar:"",theColor:39372});
   }
   function setText(theText)
   {
      var _loc1_ = this;
      _loc1_.me._txt.autoSize = "left";
      _loc1_.me._txt.html = true;
      _loc1_.me._txt.htmlText = theText;
      _loc1_.me._txt.condenseWhite = true;
      _loc1_.me._txt._visible = 0;
      _loc1_.tipHeight = _loc1_.me._txt.textHeight;
      _loc1_.me._txt.text = "";
      _loc1_.me._txt._visible = 1;
      _loc1_.textEffect = new ibTextEffect();
      _loc1_.textEffect.start("vivaTypeIn",{textObj:_loc1_.me._txt,theText:theText,speed:1,numOfChars:15,endChar:""});
      _loc1_.setSize();
   }
   function setSize()
   {
      var _loc1_ = this;
      _loc1_.me._txt._y = _loc1_.me._txt._y - _loc1_.tipHeight + 15;
      _loc1_.me.ttMid._height = _loc1_.tipHeight + 7;
      _loc1_.me.ttMid._y = _loc1_.me._txt._y - 1;
      _loc1_.me.ttTop._y = _loc1_.me._txt._y - 3;
   }
   function setScrollBar()
   {
      var _loc1_ = this;
      _loc1_.me.attachMovie("ib_ScrollBar_base","ttScroll",1,{_x:202,_y:11,_alpha:0});
      _loc1_.me.ttScroll.setTarget(_loc1_.me._txt,false);
      _loc1_.me.ttScroll.setScrollColors(39372,16777215);
      _loc1_.me.ttScroll.tween("_alpha",100,0.3,"easeOutQuad");
   }
   function testTooltipHit()
   {
      var _loc1_ = this;
      var _loc2_ = _root;
      if(_loc1_.me.hitTest(_loc2_._xmouse,_loc2_._ymouse,true) || _loc1_.me.ref.hitTest(_loc2_._xmouse,_loc2_._ymouse,true))
      {
         if(!_loc1_.tooltipHit)
         {
            _loc1_.tooltipHit = true;
         }
      }
      else if(_loc1_.tooltipHit)
      {
         _loc1_.tooltipHit = false;
         _loc1_.hideTooltip();
      }
   }
   function hideTooltip()
   {
      var _loc1_ = this;
      _loc1_.me.tween("_alpha",0,0.8,undefined,0,{scope:_loc1_.me,func:_loc1_.me.removeMovieClip});
   }
}
