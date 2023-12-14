package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;


	public var iconColor:String = "FF50a5eb";

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			default:
				switch (curCharacter)
				{
					case 'spirit': // PUT TEXT FILE CHARACTERS HERE!!!!
						frames = Paths.getPackerAtlas('characters/sprites/' + curCharacter);
					default:
						frames = Paths.getSparrowAtlas('characters/sprites/' + curCharacter);
				}
				switch (curCharacter) // PUT CHARACTER ANIMATION NAMES HERE (Don't need too if animation names are idle, left, right, up, down, we have a coded system for that)
				{
					case 'bf':
						animation.addByPrefix('idle', 'BF idle dance', 24, false);
						animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
						animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
						animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
						animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
						animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
						animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
						animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
						animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
						animation.addByPrefix('hey', 'BF HEY', 24, false);
						animation.addByPrefix('scared', 'BF idle shaking', 24);

					case 'bf-dead':
						animation.addByPrefix('firstDeath', "BF dies", 24, false);
						animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
						animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

					case 'bf-car':
						animation.addByPrefix('idle', 'BF idle dance', 24, false);
						animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
						animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
						animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
						animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
						animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
						animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
						animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
						animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
						animation.addByPrefix('hey', 'BF HEY', 24, false);

					case 'bf-christmas':
						animation.addByPrefix('idle', 'BF idle dance', 24, false);
						animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
						animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
						animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
						animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
						animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
						animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
						animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
						animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
						animation.addByPrefix('hey', 'BF HEY', 24, false);

					case 'bf-pixel':
						animation.addByPrefix('idle', 'BF IDLE', 24, false);
						animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
						animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
						animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
						animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
						animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
						animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
						animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
						animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);
						animation.addByPrefix('hey', 'BF HEY!!', 24, false);

					case 'bf-pixel-dead':
						animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
						animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
						animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
						animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);

					case 'gf':
						animation.addByPrefix('cheer', 'GF Cheer', 24, false);
						animation.addByPrefix('singLEFT', 'GF left note', 24, false);
						animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
						animation.addByPrefix('singUP', 'GF Up Note', 24, false);
						animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
						animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
						animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
						animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
						animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
						animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
						animation.addByPrefix('scared', 'GF FEAR', 24);

					case 'gf-car':
						animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
						animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
						animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

					case 'gf-christmas':
						animation.addByPrefix('cheer', 'GF Cheer', 24, false);
						animation.addByPrefix('singLEFT', 'GF left note', 24, false);
						animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
						animation.addByPrefix('singUP', 'GF Up Note', 24, false);
						animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
						animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
						animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
						animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
						animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
						animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
						animation.addByPrefix('scared', 'GF FEAR', 24);

					case 'gf-pixel':
						animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
						animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
						animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

					case 'dad':
						animation.addByPrefix('idle', 'Dad idle dance', 24);
						animation.addByPrefix('singUP', 'Dad Sing note UP', 24);
						animation.addByPrefix('singRIGHT', 'Dad Sing Note LEFT', 24);
						animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
						animation.addByPrefix('singLEFT', 'dad sing note right', 24);

					case 'spooky':
						animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
						animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
						animation.addByPrefix('singLEFT', 'note sing left', 24, false);
						animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);
						animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
						animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

					case 'monster':
						animation.addByPrefix('idle', 'monster idle', 24, false);
						animation.addByPrefix('singUP', 'monster up note', 24, false);
						animation.addByPrefix('singDOWN', 'monster down', 24, false);
						animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
						animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

					case 'monster-christmas':
						animation.addByPrefix('idle', 'monster idle', 24, false);
						animation.addByPrefix('singUP', 'monster up note', 24, false);
						animation.addByPrefix('singDOWN', 'monster down', 24, false);
						animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
						animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

					case 'pico':
						animation.addByPrefix('idle', "Pico Idle Dance", 24);
						animation.addByPrefix('singUP', 'pico Up note0', 24, false);
						animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
						if (isPlayer)
						{
							animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
							animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
							animation.addByPrefix('singRIGHTmiss', 'Pico Note Right Miss', 24, false);
							animation.addByPrefix('singLEFTmiss', 'Pico NOTE LEFT miss', 24, false);
						}
						else
						{
							// Need to be flipped! REDO THIS LATER!
							animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
							animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
							animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
							animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
						}
		
						animation.addByPrefix('singUPmiss', 'pico Up note miss', 24);
						animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24);

					case 'mom':
						animation.addByPrefix('idle', "Mom Idle", 24, false);
						animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
						animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
						animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
						// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
						// CUZ DAVE IS DUMB!
						animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);
						
					case 'mom-car':
						animation.addByPrefix('idle', "Mom Idle", 24, false);
						animation.addByPrefix('singUP', "Mom Up Pose", 24, false);
						animation.addByPrefix('singDOWN', "MOM DOWN POSE", 24, false);
						animation.addByPrefix('singLEFT', 'Mom Left Pose', 24, false);
						// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
						// CUZ DAVE IS DUMB!
						animation.addByPrefix('singRIGHT', 'Mom Pose Left', 24, false);

					case 'parents-christmas':
						animation.addByPrefix('idle', 'Parent Christmas Idle', 24, false);
						animation.addByPrefix('singUP', 'Parent Up Note Dad', 24, false);
						animation.addByPrefix('singDOWN', 'Parent Down Note Dad', 24, false);
						animation.addByPrefix('singLEFT', 'Parent Left Note Dad', 24, false);
						animation.addByPrefix('singRIGHT', 'Parent Right Note Dad', 24, false);
						animation.addByPrefix('singUP-alt', 'Parent Up Note Mom', 24, false);
						animation.addByPrefix('singDOWN-alt', 'Parent Down Note Mom', 24, false);
						animation.addByPrefix('singLEFT-alt', 'Parent Left Note Mom', 24, false);
						animation.addByPrefix('singRIGHT-alt', 'Parent Right Note Mom', 24, false);

					case 'senpai':
						animation.addByPrefix('idle', 'Senpai Idle', 24, false);
						animation.addByPrefix('singUP', 'SENPAI UP NOTE', 24, false);
						animation.addByPrefix('singLEFT', 'SENPAI LEFT NOTE', 24, false);
						animation.addByPrefix('singRIGHT', 'SENPAI RIGHT NOTE', 24, false);
						animation.addByPrefix('singDOWN', 'SENPAI DOWN NOTE', 24, false);

					case 'senpai-angry':
						animation.addByPrefix('idle', 'Angry Senpai Idle', 24, false);
						animation.addByPrefix('singUP', 'Angry Senpai UP NOTE', 24, false);
						animation.addByPrefix('singLEFT', 'Angry Senpai LEFT NOTE', 24, false);
						animation.addByPrefix('singRIGHT', 'Angry Senpai RIGHT NOTE', 24, false);
						animation.addByPrefix('singDOWN', 'Angry Senpai DOWN NOTE', 24, false);

					case 'spirit':
						animation.addByPrefix('idle', "idle spirit_", 24, false);
						animation.addByPrefix('singUP', "up_", 24, false);
						animation.addByPrefix('singRIGHT', "right_", 24, false);
						animation.addByPrefix('singLEFT', "left_", 24, false);
						animation.addByPrefix('singDOWN', "spirit down_", 24, false);

					default:
						animation.addByPrefix('idle', "idle", 24, false);
						animation.addByPrefix('singUP', "up", 24, false);
						animation.addByPrefix('singRIGHT', "right", 24, false);
						animation.addByPrefix('singLEFT', "left", 24, false);
						animation.addByPrefix('singDOWN', "down", 24, false);
				}

				switch (curCharacter) // PUT THE HEALTH BAR COLOR HERE (optional)
				{
					case 'bf':
						iconColor = "FF31B0D1";

					case 'bf-dead':
						iconColor = "FF31B0D1";

					case 'bf-car':
						iconColor = "FF31B0D1";

					case 'bf-christmas':
						iconColor = "FF31B0D1";

					case 'bf-pixel':
						iconColor = "FF7BD6F6";

					case 'bf-pixel-dead':
						iconColor = "FF7BD6F6";

					case 'gf':
						iconColor = "FFA5004D";

					case 'gf-car':
						iconColor = "FFA5004D";

					case 'gf-christmas':
						iconColor = "FFA5004D";

					case 'gf-pixel':
						iconColor = "FFA5004D";

					case 'dad':
						iconColor = "FFAF66CE";

					case 'spooky':
						iconColor = "FFD57E00";

					case 'monster':
						iconColor = "FFF3FF6E";

					case 'monster-christmas':
						iconColor = "FFF3FF6E";

					case 'pico':
						iconColor = "FFB7D855";

					case 'mom':
						iconColor = "FFD8558E";
						
					case 'mom-car':
						iconColor = "FFD8558E";

					case 'parents-christmas':
						iconColor = "FFAF66CE";

					case 'senpai':
						iconColor = "FFFFAA6F";

					case 'senpai-angry':
						iconColor = "FFBA78C2";
						
					case 'spirit':
						iconColor = "FFFF3C6E";

					default:
						iconColor = "FF50a5eb";
				}

				switch (curCharacter) // if pixel put them in the code so their not blurry
				{
					case 'bf-pixel' | 'bf-pixel-dead' | 'gf-pixel' | 'senpai' | 'senpai-angry' | 'spirit':
						antialiasing = false;
				}

				switch (curCharacter) // if pixel make them bigger
				{
					case 'bf-pixel' | 'bf-pixel-dead' | 'gf-pixel' | 'senpai' | 'senpai-angry' | 'spirit':
						setGraphicSize(Std.int(width * 6));
						updateHitbox();
				}
				
				switch (curCharacter) // if their a little too big
				{
					case 'bf-pixel':
						width -= 100;
						height -= 100;
				}

				switch (curCharacter) // if their a player character
				{
					case 'bf' | 'bf-dead' | 'bf-car' | 'bf-christmas' | 'bf-pixel' | 'bf-pixel-dead' | 'pico':
						flipX = true;
				}

				loadOffsetFile(curCharacter);

				switch (curCharacter) // change which animation plays first, if they use idle don't put them here
				{
					case 'gf' | 'gf-car' | 'gf-christmas' | 'gf-pixel' | 'spooky':  // dance right and left characters
						playAnim('danceRight');
					case 'bf-dead' | 'bf-pixel-dead':  // gameover characters
						animation.play('firstDeath');
					default:  // idle characters
						playAnim('idle');
				}
		}

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	public function loadOffsetFile(character:String)
		{
			var offset:Array<String> = CoolUtil.coolTextFile(Paths.txt('characters/offsets/' + character + "Offsets", 'shared'));
	
			for (i in 0...offset.length)
			{
				var data:Array<String> = offset[i].split(' ');
				addOffset(data[0], Std.parseInt(data[1]), Std.parseInt(data[2]));
			}
		}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-christmas':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-car':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
