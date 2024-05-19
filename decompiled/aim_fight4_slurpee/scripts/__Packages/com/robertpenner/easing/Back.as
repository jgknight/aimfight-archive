class com.robertpenner.easing.Back
{
   function Back()
   {
   }
   static function easeIn(t, b, c, d, s)
   {
      var _loc1_ = s;
      var _loc2_ = t;
      if(_loc1_ == undefined)
      {
         _loc1_ = 1.70158;
      }
      return c * (_loc2_ /= d) * _loc2_ * ((_loc1_ + 1) * _loc2_ - _loc1_) + b;
   }
   static function easeOut(t, b, c, d, s)
   {
      var _loc1_ = t;
      var _loc2_ = s;
      if(_loc2_ == undefined)
      {
         _loc2_ = 1.70158;
      }
      return c * ((_loc1_ = _loc1_ / d - 1) * _loc1_ * ((_loc2_ + 1) * _loc1_ + _loc2_) + 1) + b;
   }
   static function easeInOut(t, b, c, d, s)
   {
      var _loc1_ = t;
      var _loc2_ = s;
      if(_loc2_ == undefined)
      {
         _loc2_ = 1.70158;
      }
      if((_loc1_ /= d / 2) < 1)
      {
         return c / 2 * (_loc1_ * _loc1_ * (((_loc2_ *= 1.525) + 1) * _loc1_ - _loc2_)) + b;
      }
      return c / 2 * ((_loc1_ -= 2) * _loc1_ * (((_loc2_ *= 1.525) + 1) * _loc1_ + _loc2_) + 2) + b;
   }
   static function easeOutIn(t, b, c, d, s)
   {
      var _loc1_ = t;
      var _loc2_ = s;
      if(_loc2_ == undefined)
      {
         _loc2_ = 1.70158;
      }
      if((_loc1_ /= d / 2) < 1)
      {
         return c / 2 * ((_loc1_ = _loc1_ - 1) * _loc1_ * (((_loc2_ *= 1.525) + 1) * _loc1_ + _loc2_) + 1) + b;
      }
      return c / 2 * ((_loc1_ = _loc1_ - 1) * _loc1_ * (((_loc2_ *= 1.525) + 1) * _loc1_ - _loc2_) + 1) + b;
   }
}
