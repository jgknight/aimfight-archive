class GraphHolder extends MovieClip
{
   var me;
   var speed;
   var rankTxt;
   var scoreTxt;
   var targHeight;
   var callBack;
   var graph;
   var onEnterFrame;
   var myVal;
   var rank;
   function GraphHolder()
   {
      super();
      this.me = this;
      if(!this.speed)
      {
         this.speed = 2;
      }
      this.me.infoClip.rankBtn._visible = false;
      this.me.rankDisplay._visible = false;
      this.rankTxt = this._parent.rankTxt;
      this.scoreTxt = this._parent.scoreTxt;
      this.me.infoClip.rankBtn.onRollOver = function()
      {
         this._parent._parent.showToolTip("rank");
      };
      this.me.infoClip.rankBtn.onRollOut = function()
      {
         this._parent._parent.hideToolTip();
      };
      this.me.infoClip.scoreBtn.onRollOver = function()
      {
         this._parent._parent.showToolTip("score");
      };
      this.me.infoClip.scoreBtn.onRollOut = function()
      {
         this._parent._parent.hideToolTip();
      };
   }
   function setHeight(v, cB)
   {
      this.targHeight = v;
      if(cB)
      {
         this.callBack = cB;
      }
      this.me.onEnterFrame = function()
      {
         this.resizeGraph(this.speed,true);
         if(this.graph._height >= this.targHeight)
         {
            this.resizeGraph(this.targHeight,false);
            if(this.callBack)
            {
               this.callBack();
            }
            this.onEnterFrame = null;
         }
      };
   }
   function setColor(c)
   {
      this.me.graph.myColor = new Color(this.me.graph);
      this.me.graph.myColor.setRGB(c);
   }
   function resizeGraph(v, rel)
   {
      if(rel)
      {
         if(this.me.graph._height + v > this.targHeight)
         {
            this.me.graph._height = this.targHeight;
         }
         else
         {
            this.me.graph._height += v;
         }
      }
      else
      {
         this.me.graph._height = v;
      }
      this.me.graph._y = - this.me.graph._height;
      this.me.bg._height = this.me.graph._height + 4;
      this.me.bg._y = this.me.graph._y - 2;
      this.me.val._y = this.me.bg._y - this.me.val._height;
   }
   function setVal(v)
   {
      this.myVal = v;
   }
   function displayVal()
   {
      this.me.infoClip.scoreBtn._visible = true;
      this.me.infoClip.scoreText.text = this.myVal;
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
      this.me.infoClip.rankBtn._visible = true;
      this.me.infoClip.rankText.text = this.rank;
      this.me.rankDisplay._visible = true;
   }
   function showToolTip(src)
   {
      var _loc2_ = undefined;
      var _loc3_ = undefined;
      if(src == "rank")
      {
         _loc2_ = this.me.infoClip.rankBtn;
         _loc3_ = this.rankTxt;
      }
      else
      {
         _loc2_ = this.me.infoClip.scoreBtn;
         _loc3_ = this.scoreTxt;
      }
      this.me.infoClip.toolTip._x = _loc2_._x - _loc2_._width * 2;
      this.me.infoClip.toolTip._y = _loc2_._y - 30;
      var _loc4_ = _loc2_._y - this.me.infoClip.rankBtn._height / 2 + 20;
      var _loc5_ = 0;
      this.me.infoClip.attachMovie("tooltip_mc","toolTip",501,{_x:_loc5_,_y:_loc4_});
      this.me.infoClip.toolTip.ref = _loc2_;
      this.me.infoClip.toolTip.setText(_loc3_);
   }
   function hideToolTip()
   {
      this.me.infoClip.toolTip.removeMovieClip();
   }
}
