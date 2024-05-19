class com.robertpenner.easing.Expo
{
   function Expo()
   {
   }
   static function easeIn(t, b, c, d)
   {
      return t != 0 ? c * Math.pow(2,10 * (t / d - 1)) + b : b;
   }
   static function easeOut(t, b, c, d)
   {
      return t != d ? c * (- Math.pow(2,-10 * t / d) + 1) + b : b + c;
   }
   static function easeInOut(t, b, c, d)
   {
      var _loc1_ = t;
      var _loc2_ = b;
      var _loc3_ = c;
      if(_loc1_ == 0)
      {
         return _loc2_;
      }
      if(_loc1_ == d)
      {
         return _loc2_ + _loc3_;
      }
      if((_loc1_ /= d / 2) < 1)
      {
         return _loc3_ / 2 * Math.pow(2,10 * (_loc1_ - 1)) + _loc2_;
      }
      return _loc3_ / 2 * (- Math.pow(2,-10 * (_loc1_ = _loc1_ - 1)) + 2) + _loc2_;
   }
   static function easeOutIn(t, b, c, d)
   {
      var _loc1_ = t;
      var _loc2_ = b;
      var _loc3_ = c;
      if(_loc1_ == 0)
      {
         return _loc2_;
      }
      if(_loc1_ == d)
      {
         return _loc2_ + _loc3_;
      }
      if((_loc1_ /= d / 2) < 1)
      {
         return _loc3_ / 2 * (- Math.pow(2,-10 * _loc1_) + 1) + _loc2_;
      }
      return _loc3_ / 2 * (Math.pow(2,10 * (_loc1_ - 2)) + 1) + _loc2_;
   }
}
