package uiAssets;

import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.FlxG;
import PlayState;
import sys.io.File;

class ScoreRatingsText{
    public static var instance:ScoreRatingsText;
    public static var game:PlayState;

    public static var accuracyString:Array<String> = ['Score: ', 'Misses: ', 'Rating: ', ' | ', '%', '0', '?', '(', ')'];

    public function getFont(){
        #if MODS_ALLOWED
        if (sys.FileSystem.exists(Paths.modsFont("vcr.ttf"))){
            return Paths.modsFont("vcr.ttf");
        }
        else
        #end
        {
            return Paths.font("vcr.ttf");
        }
    }
    public function firstScore(){
        return 
        accuracyString[0]
        + accuracyString[5]
        + accuracyString[3] 
        + accuracyString[1]
        + accuracyString[5]
        + accuracyString[3] 
        + accuracyString[2] 
        + accuracyString[6];
    }
    public function getScore(score:Int, misses:Int, percent:Float){
        return 
        accuracyString[0] 
        + score 
        + accuracyString[3] 
        + accuracyString[1] 
        + misses 
        + accuracyString[3] 
        + accuracyString[2] 
        + Math.floor(percent * 100) 
        + accuracyString[4];
    }
}
