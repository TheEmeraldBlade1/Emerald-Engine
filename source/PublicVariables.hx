// this is like a thingy where if like multiple hx files use the same thing it gets called from here useful for not needing to add something new to each of them
// this code is extremly fucked up and unclean btw
// its also probably unstable...

class PublicVariables
{
    public static var pauseOptions:Bool = false;
    public static var noteFlip:Array<String> = ['']; // changes notes to left side useful if opponent is on the right side put song name in here to enable
    public static var noteFlipApart:Array<String> = ['']; // makes the notes farther apart in note flip put song name in here to enable song name must be in noteflip variable as well!
    public static var hideEnemyNotesSongs:Array<String> = ['']; // Put The Song Name In Here To Hide Enemy Notes In That Song
}