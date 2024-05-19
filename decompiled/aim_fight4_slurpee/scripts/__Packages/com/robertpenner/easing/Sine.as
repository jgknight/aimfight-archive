class com.robertpenner.easing.Sine
{
   function Sine()
   {
   }
   static function easeIn(t, b, c, d)
   {
      return (- c) * Math.cos(t / d * 1.5707963267948966) + c + b;
   }
   static function easeOut(t, b, c, d)
   {
      return c * Math.sin(t / d * 1.5707963267948966) + b;
   }
   static function easeInOut(t, b, c, d)
   {
      return (- c) / 2 * (Math.cos(3.141592653589793 * t / d) - 1) + b;
   }
   static function easeOutIn(t, b, c, d)
   {
      var _loc1_ = t;
      if((_loc1_ /= d / 2) < 1)
      {
         return c / 2 * Math.sin(3.141592653589793 * _loc1_ / 2) + b;
      }
      return (- c) / 2 * (Math.cos(3.141592653589793 * (_loc1_ = _loc1_ - 1) / 2) - 2) + b;
   }
}
