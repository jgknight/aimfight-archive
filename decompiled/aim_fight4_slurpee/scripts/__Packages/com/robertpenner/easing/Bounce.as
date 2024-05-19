class com.robertpenner.easing.Bounce
{
   function Bounce()
   {
   }
   static function easeOut(t, b, c, d)
   {
      var _loc1_ = t;
      var _loc2_ = c;
      var _loc3_ = b;
      if((_loc1_ /= d) < 0.36363636363636365)
      {
         return _loc2_ * (7.5625 * _loc1_ * _loc1_) + _loc3_;
      }
      if(_loc1_ < 0.7272727272727273)
      {
         return _loc2_ * (7.5625 * (_loc1_ -= 0.5454545454545454) * _loc1_ + 0.75) + _loc3_;
      }
      if(_loc1_ < 0.9090909090909091)
      {
         return _loc2_ * (7.5625 * (_loc1_ -= 0.8181818181818182) * _loc1_ + 0.9375) + _loc3_;
      }
      return _loc2_ * (7.5625 * (_loc1_ -= 0.9545454545454546) * _loc1_ + 0.984375) + _loc3_;
   }
   static function easeIn(t, b, c, d)
   {
      return c - com.robertpenner.easing.Bounce.easeOut(d - t,0,c,d) + b;
   }
   static function easeInOut(t, b, c, d)
   {
      var _loc1_ = d;
      var _loc2_ = t;
      var _loc3_ = c;
      if(_loc2_ < _loc1_ / 2)
      {
         return com.robertpenner.easing.Bounce.easeIn(_loc2_ * 2,0,_loc3_,_loc1_) * 0.5 + b;
      }
      return com.robertpenner.easing.Bounce.easeOut(_loc2_ * 2 - _loc1_,0,_loc3_,_loc1_) * 0.5 + _loc3_ * 0.5 + b;
   }
   static function easeOutIn(t, b, c, d)
   {
      var _loc1_ = d;
      var _loc2_ = t;
      var _loc3_ = c;
      if(_loc2_ < _loc1_ / 2)
      {
         return com.robertpenner.easing.Bounce.easeOut(_loc2_ * 2,0,_loc3_,_loc1_) * 0.5 + b;
      }
      return com.robertpenner.easing.Bounce.easeIn(_loc2_ * 2 - _loc1_,0,_loc3_,_loc1_) * 0.5 + _loc3_ * 0.5 + b;
   }
}
