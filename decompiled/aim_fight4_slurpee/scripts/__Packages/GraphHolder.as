class GraphHolder extends MovieClip
{
   var myVal;
   var speed;
   var me;
   var rank;
   function GraphHolder()
   {
      var _loc1_ = this;
      super();
      _loc1_.me = _loc1_;
      if(!_loc1_.speed)
      {
         _loc1_.speed = 2;
      }
      _loc1_.me.infoClip.rankBtn._visible = false;
      _loc1_.me.rankDisplay._visible = false;
      _loc1_.rankTxt = _loc1_._parent.rankTxt;
      _loc1_.scoreTxt = _loc1_._parent.scoreTxt;
      _loc1_.me.infoClip.rankBtn.onRollOver = function()
      {
         this._parent._parent.showToolTip("rank");
      };
      _loc1_.me.infoClip.rankBtn.onRollOut = function()
      {
         this._parent._parent.hideToolTip();
      };
      _loc1_.me.infoClip.scoreBtn.onRollOver = function()
      {
         this._parent._parent.showToolTip("score");
      };
      _loc1_.me.infoClip.scoreBtn.onRollOut = function()
      {
         this._parent._parent.hideToolTip();
      };
   }
   function setHeight(v, cB)
   {
      var _loc1_ = this;
      _loc1_.targHeight = v;
      if(cB)
      {
         _loc1_.callBack = cB;
      }
      _loc1_.me.onEnterFrame = function()
      {
         var _loc1_ = this;
         _loc1_.resizeGraph(_loc1_.speed,true);
         if(_loc1_.graph._height >= _loc1_.targHeight)
         {
            _loc1_.resizeGraph(_loc1_.targHeight,false);
            if(_loc1_.callBack)
            {
               _loc1_.callBack();
            }
            _loc1_.onEnterFrame = null;
         }
      };
   }
   function setColor(c)
   {
      var _loc1_ = this;
      _loc1_.me.graph.myColor = new Color(_loc1_.me.graph);
      _loc1_.me.graph.myColor.setRGB(c);
   }
   function resizeGraph(v, rel)
   {
      var _loc1_ = this;
      var _loc2_ = v;
      if(rel)
      {
         if(_loc1_.me.graph._height + _loc2_ > _loc1_.targHeight)
         {
            _loc1_.me.graph._height = _loc1_.targHeight;
         }
         else
         {
            _loc1_.me.graph._height += _loc2_;
         }
      }
      else
      {
         _loc1_.me.graph._height = _loc2_;
      }
      _loc1_.me.graph._y = - _loc1_.me.graph._height;
      _loc1_.me.bg._height = _loc1_.me.graph._height + 4;
      _loc1_.me.bg._y = _loc1_.me.graph._y - 2;
      _loc1_.me.val._y = _loc1_.me.bg._y - _loc1_.me.val._height;
   }
   function setVal(v)
   {
      this.myVal = v;
   }
   function displayVal()
   {
      var _loc1_ = this;
      _loc1_.me.infoClip.scoreBtn._visible = true;
      _loc1_.me.infoClip.scoreText.text = _loc1_.myVal;
   }
   function setSpeed(s)
   {
      this.speed = s;
   }
   function setName(s)
   {
      this.me.infoClip.nameText.text = s;
   }
   function setRank(r)
   {
      this.rank = r;
   }
   function displayRank()
   {
      var _loc1_ = this;
      _loc1_.me.infoClip.rankBtn._visible = true;
      _loc1_.me.infoClip.rankText.text = _loc1_.rank;
      _loc1_.me.rankDisplay._visible = true;
   }
   function showToolTip(src)
   {
      var _loc1_ = this;
      var _loc2_ = undefined;
      var _loc3_ = undefined;
      if(src == "rank")
      {
         _loc2_ = _loc1_.me.infoClip.rankBtn;
         _loc3_ = _loc1_.rankTxt;
      }
      else
      {
         _loc2_ = _loc1_.me.infoClip.scoreBtn;
         _loc3_ = _loc1_.scoreTxt;
      }
      _loc1_.me.infoClip.toolTip._x = _loc2_._x - _loc2_._width * 2;
      _loc1_.me.infoClip.toolTip._y = _loc2_._y - 30;
      var mody = _loc2_._y - _loc1_.me.infoClip.rankBtn._height / 2 + 20;
      var modx = 0;
      _loc1_.me.infoClip.attachMovie("tooltip_mc","toolTip",501,{_x:modx,_y:mody});
      _loc1_.me.infoClip.toolTip.ref = _loc2_;
      _loc1_.me.infoClip.toolTip.setText(_loc3_);
   }
   function hideToolTip()
   {
      this.me.infoClip.toolTip.removeMovieClip();
   }
}
