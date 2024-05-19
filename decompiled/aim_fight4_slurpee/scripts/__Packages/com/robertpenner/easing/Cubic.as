class com.robertpenner.easing.Cubic
{
   function Cubic()
   {
   }
   static function easeIn(t, b, c, d)
   {
      var _loc1_ = t;
      return c * (_loc1_ /= d) * _loc1_ * _loc1_ + b;
   }
   static function easeOut(t, b, c, d)
   {
      var _loc1_ = t;
      return c * ((_loc1_ = _loc1_ / d - 1) * _loc1_ * _loc1_ + 1) + b;
   }
   static function easeInOut(t, b, c, d)
   {
      var _loc1_ = t;
      if((_loc1_ /= d / 2) < 1)
      {
         return c / 2 * _loc1_ * _loc1_ * _loc1_ + b;
      }
      return c / 2 * ((_loc1_ -= 2) * _loc1_ * _loc1_ + 2) + b;
   }
   static function easeOutIn(t, b, c, d)
   {
      var _loc1_ = t;
      _loc1_ /= d / 2;
      return c / 2 * ((_loc1_ = _loc1_ - 1) * _loc1_ * _loc1_ + 1) + b;
   }
}
