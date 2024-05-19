# AIM Fight Archive
Collection of historical information and assets related to the AIMFight.com website. AIM Fight was a website operated by AIM/AOL from 2005-2013 which allowed you to compare the popularity of any two screennames. 

## Live Demo
You can access a live demo of the AIM Fight website at the GitHub pages url, https://aimfight-archive.github.io/

The website uses a static results file, so scores will be the same regardless of what screenname is entered.

## Repo Contents
Within the `decompiled` directory you can find the decompiled and exported resources from each of the AIM fight swf files. They were decompiled using the [JPEXS Free Flash Decompiler](https://github.com/jindrapetrik/jpexs-decompiler).


A full export includes shapes, texts, images, scripts, frames, sprites, buttons, fonts, symbok class mappings, movies, sounds, binary data, definefont4, morphshapes, embedded assets.

A partial export means it is missing the movies, sounds, binary data, definefont4, morphshapes, embedded assets. 


 * __aim_fight2__
   * Classic/default view
   * Partial export
   * Notable scripts in Frame 1
 * __aim_fight3__
   * Classic/default view
   * Partial export
   * Notable scripts in Frame 1
 * __aim_fight4_slurpee__
   * Superman Returns movie ad sponsored by Slurpee
   * Partial export
   * Notable scripts in Frame 1
 * __aim_fight5__
   * Classic/default view
   * Partial export
   * Notable scripts in Frame 1
 * __aim_fight6__
   * Silver Surfer movie ad
   * Full export
   * Notable scripts in Frame 1 and Frame 92
* __aim_fight6_armyoftwo__
   * EA Games Army of Two video game ad
   * Partial export
   * Notable scripts in Frame 20
* __aim_fight_06_sony__
   * Zoom movie ad starring Tim Allen
   * Partial export
   * Notable scripts in Frame 1
* __aim_fight_sw__
   * Sydney White movie ad starring Amanda Bynes
   * Partial export
   * Notable scripts in Frame 1 and Frame 92

## Contributing
If you have any additional information to add, or you have a previously unlisted .swf file, please open a PR.


# About AIM Fight

## API

The API consists of a single URL called by the Adobe Flash applet that returns the scores and ranks of the users. Additionally, it returns heights for the bars for the applet to show.

It was accessed at `http://www.aimfight.com/getFight.php?name1=SCREENNAME1&name2=SCREENNAME2`

By replacing SCREENNAME1 and SCREENNAME2 with the screen names of the individuals to fight, percent-encoded data was returned in the following format:

```
&success=1&score1=132451&score2=6004&oscore1=27241&oscore2=0&height1=99&height2=4
```

* `success` returns whether or not the fight was a valid one (0 if no, 1 if yes)
* `score1` represents the score of the first screen name entered
* `score2` represents the score of the second screen name entered
* `oscore1` shows the rank of the first screen name if it is in the Top 5%
* `oscore2` shows the rank of the second screen name if it is in the Top 5%
* `height1` is the height of the first screen name's bar
* `height2` is the height of the second screen name's bar

## Server Algorithm
tbd
