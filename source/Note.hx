package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
#if polymod
import polymod.format.ParseRules.TargetSignatureElement;
#end

using StringTools;

class Note extends FlxSprite
{
	public var strumTime:Float = 0;

	public var mustPress:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var prevNote:Note;

	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;

	public var noteScore:Float = 1;

	public static var swagWidth:Float = 160 * 0.7;
	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;

	public var MyStrum:FlxSprite;

	private var notetolookfor = 0;

	public var elapsedtime:Float = 0;

	private var InPlayState:Bool = false;

	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false)
	{
		super();

		if (prevNote == null)
			prevNote = this;

		this.prevNote = prevNote;
		isSustainNote = sustainNote;

		if (FlxG.save.data.scrollType == 2){
			x -= 250;
		}else if (FlxG.save.data.scrollType == 1){
			x -= 600;
		}else{
			x = 92;
		}
		// MAKE SURE ITS DEFINITELY OFF SCREEN?
		y -= 2000;
		this.strumTime = strumTime + FlxG.save.data.offset;

		this.noteData = noteData;

		var daStage:String = PlayState.curStage;

		if (PlayState.SONG.noteSkin == null){
			if (daStage == 'school' || daStage == 'schoolEvil')PlayState.SONG.noteSkin = 'pixel';
		}
		switch (PlayState.SONG.noteSkin)
		{
			case 'pixel':
				{
					loadGraphic(Paths.image('weeb/pixelUI/NOTE_assets'), true, 17, 17);
				}

				animation.add('greenScroll', [6]);
				animation.add('redScroll', [7]);
				animation.add('blueScroll', [5]);
				animation.add('purpleScroll', [4]);

				if (isSustainNote)
				{
					{
						loadGraphic(Paths.image('weeb/pixelUI/NOTE_assetsENDS'), true, 7, 6);
					}

					animation.add('purpleholdend', [4]);
					animation.add('greenholdend', [6]);
					animation.add('redholdend', [7]);
					animation.add('blueholdend', [5]);

					animation.add('purplehold', [0]);
					animation.add('greenhold', [2]);
					animation.add('redhold', [3]);
					animation.add('bluehold', [1]);
				}

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();

			default:
				{
					frames = Paths.getSparrowAtlas('NOTE_assets');
				}

				animation.addByPrefix('greenScroll', 'green0');
				animation.addByPrefix('redScroll', 'red0');
				animation.addByPrefix('blueScroll', 'blue0');
				animation.addByPrefix('purpleScroll', 'purple0');

				if (isSustainNote){
					frames = Paths.getSparrowAtlas('NOTE_assets');
					animation.addByPrefix('purpleholdend', 'pruple end hold');
					animation.addByPrefix('greenholdend', 'green hold end');
					animation.addByPrefix('redholdend', 'red hold end');
					animation.addByPrefix('blueholdend', 'blue hold end');
	
					animation.addByPrefix('purplehold', 'purple hold piece');
					animation.addByPrefix('greenhold', 'green hold piece');
					animation.addByPrefix('redhold', 'red hold piece');
					animation.addByPrefix('bluehold', 'blue hold piece');
				}

				setGraphicSize(Std.int(width * 0.7));
				updateHitbox();
				antialiasing = true;
		}


		if (PlayState.SONG.cheatingNotes || PlayState.SONG.unfairnessNotes || PlayState.SONG.randomNotes){
			switch (noteData)
			{
				case 0:
					x += swagWidth * 3;
					notetolookfor = 3;
					animation.play('purpleScroll');
				case 1:
					x += swagWidth * 1;
					notetolookfor = 1;
					animation.play('blueScroll');
				case 2:
					x += swagWidth * 0;
					notetolookfor = 0;
					animation.play('greenScroll');
				case 3:
					notetolookfor = 2;
					x += swagWidth * 2;
					animation.play('redScroll');
			}
			flipY = (Math.round(Math.random()) == 0); //fuck you
			flipX = (Math.round(Math.random()) == 1);
		}else{
			switch (noteData)
			{
				case 0:
					x += swagWidth * 0;
					animation.play('purpleScroll');
				case 1:
					x += swagWidth * 1;
					animation.play('blueScroll');
				case 2:
					x += swagWidth * 2;
					animation.play('greenScroll');
				case 3:
					x += swagWidth * 3;
					animation.play('redScroll');
			}
		}

		if (PlayState.SONG.cheatingNotes || PlayState.SONG.unfairnessNotes || PlayState.SONG.randomNotes){
			if (Type.getClassName(Type.getClass(FlxG.state)).contains("PlayState"))
				{
					var state:PlayState = cast(FlxG.state,PlayState);
					InPlayState = true;
					if (mustPress)
					{
						state.playerStrums.forEach(function(spr:FlxSprite)
						{
							if (spr.ID == notetolookfor)
							{
								x = spr.x;
							}
						});
					}
					else
					{
						state.enemyStrums.forEach(function(spr:FlxSprite)
						{
							if (spr.ID == notetolookfor)
							{
								x = spr.x;
							}
						});
					}
				}
		}

		// trace(prevNote);

		if (isSustainNote && prevNote != null)
		{
			noteScore * 0.2;
			//alpha = 0.6;

			x += width / 2;

			switch (noteData)
			{
				case 2:
					animation.play('greenholdend');
				case 3:
					animation.play('redholdend');
				case 1:
					animation.play('blueholdend');
				case 0:
					animation.play('purpleholdend');
			}

			updateHitbox();

			x -= width / 2;

			if (PlayState.SONG.noteSkin == 'pixel')
				x += 30;

			if (prevNote.isSustainNote)
			{
				switch (prevNote.noteData)
				{
					case 0:
						prevNote.animation.play('purplehold');
					case 1:
						prevNote.animation.play('bluehold');
					case 2:
						prevNote.animation.play('greenhold');
					case 3:
						prevNote.animation.play('redhold');
				}

				prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.5 * PlayState.SONG.speed;
				prevNote.updateHitbox();
				// prevNote.setGraphicSize();
			}
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		elapsedtime += elapsed;

		if (PlayState.SONG.cheatingNotes){
			if (Type.getClassName(Type.getClass(FlxG.state)).contains("PlayState"))
			{
				var state:PlayState = cast(FlxG.state,PlayState);
				InPlayState = true;

				if (mustPress)                                         
				{
					state.playerStrums.forEach(function(spr:FlxSprite){
						{
							x += Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1);
							x -= Math.sin(elapsedtime) * 1.5;
						}
					});
				}
				else
				{
					state.enemyStrums.forEach(function(spr:FlxSprite){
						{
							x -= Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1);
							x += Math.sin(elapsedtime) * 1.5;
						}
					});
				}
			}
		}

		if (FlxG.save.data.scrollType == 2){
			var state:PlayState = cast(FlxG.state,PlayState);
			InPlayState = true;
			if (!mustPress)                                         
				{
					state.enemyStrums.forEach(function(spr:FlxSprite){
						{
							x = spr.x - 9654;
						}
					});
				}
		}

		if (PlayState.SONG.unfairnessNotes){
			if (Type.getClassName(Type.getClass(FlxG.state)).contains("PlayState"))
			{
				var state:PlayState = cast(FlxG.state,PlayState);
				InPlayState = true;

				if (mustPress)                                         
				{
					state.playerStrums.forEach(function(spr:FlxSprite){
						{
							x = ((FlxG.width / 2) - (spr.width / 2)) + (Math.sin(elapsedtime + (spr.ID)) * 300);
							y = ((FlxG.height / 2) - (spr.height / 2)) + (Math.cos(elapsedtime + (spr.ID)) * 300);
						}
					});
				}
				else
				{
					state.enemyStrums.forEach(function(spr:FlxSprite){
						{
							x = ((FlxG.width / 2) - (spr.width / 2)) + (Math.sin((elapsedtime + (spr.ID )) * 2) * 300);
							y = ((FlxG.height / 2) - (spr.height / 2)) + (Math.cos((elapsedtime + (spr.ID)) * 2) * 300);
						}
					});
				}
			}
		}

		if (PlayState.SONG.randomNotes){
			if (Type.getClassName(Type.getClass(FlxG.state)).contains("PlayState"))
			{
				var state:PlayState = cast(FlxG.state,PlayState);
				InPlayState = true;

				if (mustPress)                                         
				{
					state.playerStrums.forEach(function(spr:FlxSprite){
						{
							x += Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1);
							x -= Math.sin(elapsedtime) * 1.5;
						}
					});
				}
				else
				{
					state.enemyStrums.forEach(function(spr:FlxSprite){
						{
							x -= Math.sin(elapsedtime) * ((spr.ID % 2) == 0 ? 1 : -1);
							x += Math.sin(elapsedtime) * 1.5;
							y = ((FlxG.height / 2) - (spr.height / 2)) + (Math.cos((elapsedtime + (spr.ID)) * 2) * 300);
						}
					});
				}
			}
		}

		if (mustPress)
		{
			// The * 0.5 is so that it's easier to hit them too late, instead of too early
			if (strumTime > Conductor.songPosition - Conductor.safeZoneOffset
				&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.5))
				canBeHit = true;
			else
				canBeHit = false;

			if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset && !wasGoodHit)
				tooLate = true;
		}
		else
		{
			canBeHit = false;

			if (strumTime <= Conductor.songPosition)
				wasGoodHit = true;
		}

		if (tooLate)
		{
			if (alpha > 0.3)
				alpha = 0.3;
		}
	}
}
