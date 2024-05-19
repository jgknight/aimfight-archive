class com.robertpenner.easing.Quad
{
   function Quad()
   {
   }
   static function easeIn(t, b, c, d)
   {
      return c * (t /= d) * t + b;
   }
   static function easeOut(t, b, c, d)
   {
      return (- c) * (t /= d) * (t - 2) + b;
   }
   static function easeInOut(t, b, c, d)
   {
      var _loc1_ = t;
      if((_loc1_ /= d / 2) < 1)
      {
         return c / 2 * _loc1_ * _loc1_ + b;
      }
      return (- c) / 2 * ((_loc1_ = _loc1_ - 1) * (_loc1_ - 2) - 1) + b;
   }
   static function easeOutIn(t, b, c, d)
   {
      var _loc1_ = t;
      if((_loc1_ /= d / 2) < 1)
      {
         return (- c) / 2 * ((_loc1_ = _loc1_ - 1) * _loc1_ - 1) + b;
      }
      return c / 2 * ((_loc1_ = _loc1_ - 1) * _loc1_ + 1) + b;
   }
}
