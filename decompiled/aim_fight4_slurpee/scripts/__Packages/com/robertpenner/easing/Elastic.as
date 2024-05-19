class com.robertpenner.easing.Elastic
{
   function Elastic()
   {
   }
   static function easeIn(t, b, c, d, a, p)
   {
      var _loc1_ = a;
      var _loc2_ = p;
      var _loc3_ = t;
      if(_loc3_ == 0)
      {
         return b;
      }
      if((_loc3_ /= d) == 1)
      {
         return b + c;
      }
      if(!_loc2_)
      {
         _loc2_ = d * 0.3;
      }
      if(!_loc1_ || _loc1_ < Math.abs(c))
      {
         _loc1_ = c;
         var s = _loc2_ / 4;
      }
      else
      {
         var s = _loc2_ / 6.283185307179586 * Math.asin(c / _loc1_);
      }
      return - _loc1_ * Math.pow(2,10 * (_loc3_ -= 1)) * Math.sin((_loc3_ * d - s) * 6.283185307179586 / _loc2_) + b;
   }
   static function easeOut(t, b, c, d, a, p)
   {
      var _loc1_ = c;
      var _loc2_ = a;
      var _loc3_ = p;
      if(t == 0)
      {
         return b;
      }
      if((t /= d) == 1)
      {
         return b + _loc1_;
      }
      if(!_loc3_)
      {
         _loc3_ = d * 0.3;
      }
      if(!_loc2_ || _loc2_ < Math.abs(_loc1_))
      {
         _loc2_ = _loc1_;
         var s = _loc3_ / 4;
      }
      else
      {
         var s = _loc3_ / 6.283185307179586 * Math.asin(_loc1_ / _loc2_);
      }
      return _loc2_ * Math.pow(2,-10 * t) * Math.sin((t * d - s) * 6.283185307179586 / _loc3_) + _loc1_ + b;
   }
   static function easeInOut(t, b, c, d, a, p)
   {
      var _loc1_ = t;
      var _loc2_ = a;
      var _loc3_ = p;
      if(_loc1_ == 0)
      {
         return b;
      }
      if((_loc1_ /= d / 2) == 2)
      {
         return b + c;
      }
      if(!_loc3_)
      {
         _loc3_ = d * 0.44999999999999996;
      }
      if(!_loc2_ || _loc2_ < Math.abs(c))
      {
         _loc2_ = c;
         var s = _loc3_ / 4;
      }
      else
      {
         var s = _loc3_ / 6.283185307179586 * Math.asin(c / _loc2_);
      }
      if(_loc1_ < 1)
      {
         return -0.5 * (_loc2_ * Math.pow(2,10 * (_loc1_ -= 1)) * Math.sin((_loc1_ * d - s) * 6.283185307179586 / _loc3_)) + b;
      }
      return _loc2_ * Math.pow(2,-10 * (_loc1_ -= 1)) * Math.sin((_loc1_ * d - s) * 6.283185307179586 / _loc3_) * 0.5 + c + b;
   }
   static function easeOutIn(t, b, c, d, a, p)
   {
      var _loc1_ = t;
      var _loc2_ = c;
      var _loc3_ = a;
      if(_loc1_ == 0)
      {
         return b;
      }
      if((_loc1_ /= d / 2) == 2)
      {
         return b + _loc2_;
      }
      if(!p)
      {
         p = d * 0.44999999999999996;
      }
      if(!_loc3_ || _loc3_ < Math.abs(_loc2_))
      {
         _loc3_ = _loc2_;
         var s = p / 4;
      }
      else
      {
         var s = p / 6.283185307179586 * Math.asin(_loc2_ / _loc3_);
      }
      if(_loc1_ < 1)
      {
         return 0.5 * (_loc3_ * Math.pow(2,-10 * _loc1_) * Math.sin((_loc1_ * d - s) * 6.283185307179586 / p)) + _loc2_ / 2 + b;
      }
      return _loc2_ / 2 + 0.5 * (_loc3_ * Math.pow(2,10 * (_loc1_ - 2)) * Math.sin((_loc1_ * d - s) * 6.283185307179586 / p)) + b;
   }
}
