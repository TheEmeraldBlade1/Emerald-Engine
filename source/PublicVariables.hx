// this is like a thingy where if like multiple hx files use the same thing it gets called from here useful for not needing to add something new to each of them
// this code is extremly fucked up and unclean btw
// its also probably unstable...

class PublicVariables
{
    public static var pauseOptions:Bool = false;
    public static var noteFlip:Array<String> = ['']; // changes notes to left side useful if opponent is on the right side put song name in here to enable
    public static var noteFlipApart:Array<String> = ['']; // makes the notes farther apart in note flip put song name in here to enable song name must be in noteflip variable as well!
    public static var hideEnemyNotesSongs:Array<String> = ['']; // Put The Song Name In Here To Hide Enemy Notes In That Song
    public static var transParentText:Array<String> = ['']; // put song name here to make most of the text transparent
    public static var unCenteredNoteTypes:Array<Int> = [3, 10, 11]; // put a note type number here to center the confirm animation if it isnt centered on first go 
    public static var dontOverWriteNote:Array<String> = ['HURT']; // prevents noteskin overwriting a note type

	public static var noteSkins:Array<String> = [
		'Default',
		'Circles',
		'Rectangles',
		'Stepmania',
		'Synthwave',
		'Halloween',
		'Silver',
		'Mario',
		'Luigi',
		'3D',
        'Cat',
        'Spike'
	];

    public static var noteskinpath:String = '';
    public static function getNoteSkinPath(){
        if (ClientPrefs.notetypes == 0) noteskinpath = '';
		if (ClientPrefs.notetypes == 1) noteskinpath = '_Circles';
		if (ClientPrefs.notetypes == 2) noteskinpath = '_Rectangle';
		if (ClientPrefs.notetypes == 3) noteskinpath = '_Stepmania';
		if (ClientPrefs.notetypes == 4) noteskinpath = '_Synthwave';
		if (ClientPrefs.notetypes == 5) noteskinpath = '_Halloween';
		if (ClientPrefs.notetypes == 6) noteskinpath = '_silver';
		if (ClientPrefs.notetypes == 7) noteskinpath = '_Mario';
		if (ClientPrefs.notetypes == 8) noteskinpath = '_Luigi';
		if (ClientPrefs.notetypes == 9) noteskinpath = '_3D';
        if (ClientPrefs.notetypes == 10) noteskinpath = '_CAT';
        if (ClientPrefs.notetypes == 11) noteskinpath = '_Spike';
    }
}