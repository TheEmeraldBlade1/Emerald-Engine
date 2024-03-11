package uiAssets;

import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.FlxG;
import PlayState;

class ScoreRatingsText{
    public static var instance:ScoreRatingsText;
    public static var game:PlayState;

    public static var accuracyString:Array<String> = ['Score: ', 'Misses: ', 'Rating: ', ' | ', '%'];

    public function getFont(){
        return Paths.font("vcr.ttf");
    }
    public function firstScore(){
        return "Score: 0 | Misses: 0 | Rating: ?";
    }
    public function getScore(score:Int, misses:Int, percent:Float){
        return accuracyString[0] + score 
        + accuracyString[3] 
        + accuracyString[1] + misses 
        + accuracyString[3] 
        + accuracyString[2] + Math.floor(percent * 100) 
        + accuracyString[4];
    }
}
