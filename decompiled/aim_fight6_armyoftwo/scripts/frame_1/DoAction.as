dupMovie = function()
{
   i = 0;
   while(i < 100)
   {
      circle.duplicateMovieClip("circle" + i,i,{_x:Math.random() * 740,_y:Math.random() * 270,_alpha:Math.random() * 50});
      with(eval("circle" + i))
      {
         _xscale = _yscale = Math.random() * 150;
      }
      i++;
   }
};
preload();
