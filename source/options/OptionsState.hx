package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import flixel.util.FlxTimer;
import flixel.effects.FlxFlicker;
import Controls;

using StringTools;

class OptionsState extends MusicBeatState
{
	var options:Array<String> = [];
	private var grpOptions:FlxTypedGroup<Alphabet>;
	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;

	override function create() {
		#if desktop
		DiscordClient.changePresence("Options Menu", null);
		#end

		options = [
		'Preferences'
		, 'Note Colors'
		, 'Controls'
		];

		if (!FlxG.sound.music.playing){
			FlxG.sound.playMusic(Paths.music('lullma'));
		}

		menuBG = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = ClientPrefs.globalAntialiasing;
		add(menuBG);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(0, 0, options[i], true, false);
			optionText.screenCenter();
			optionText.y += (100 * (i - (options.length / 2))) + 50;
			grpOptions.add(optionText);
		}
		changeSelection();

		super.create();
	}

	override function closeSubState() {
		super.closeSubState();
		ClientPrefs.saveSettings();
		changeSelection();
	}

	override function update(elapsed:Float) {
		if (FlxG.keys.justPressed.THREE) {
			FlxG.mouse.visible = !FlxG.mouse.visible;
		}

		super.update(elapsed);

		if (controls.UI_UP_P) {
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P) {
			changeSelection(1);
		}

		if(options[curSelected] == 'Noteskin ' + "<" + PublicVariables.noteSkins[ClientPrefs.notetypes] + ">"){
			if (controls.UI_LEFT){
				ClientPrefs.notetypes -= 1;	
				FlxG.sound.play(Paths.sound('scrollMenu'));
				if (ClientPrefs.notetypes < 0)
					ClientPrefs.notetypes = PublicVariables.noteSkins.length - 1;
				ClientPrefs.saveSettings();
				MusicBeatState.switchState(new options.OptionsState());			
			}else if (controls.UI_RIGHT){
				ClientPrefs.notetypes += 1;
				FlxG.sound.play(Paths.sound('scrollMenu'));
				if (ClientPrefs.notetypes > PublicVariables.noteSkins.length - 1)
					ClientPrefs.notetypes = 0;
				ClientPrefs.saveSettings();
				MusicBeatState.switchState(new options.OptionsState());
			}
		}

		if (controls.BACK) {
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.sound('cancelMenu'));
			if (PublicVariables.pauseOptions == true){
				PublicVariables.pauseOptions == false;
				MusicBeatState.switchState(new PlayState());
			}else{
				FlxG.sound.playMusic(Paths.music('freakyMenu'));
				MusicBeatState.switchState(new MainMenuState());
			}
		}

		if (controls.ACCEPT) {
			switch(options[curSelected]) {
				case 'Note Colors':
					noteColorsState();
				case 'Controls':
					controlsState();
				case 'Preferences':
					prefsState();
			}
		}
	}

	var daTime:Float = 0.5;
	
	function prefsState()
	{	
		var da:Int = curSelected;
		FlxG.sound.play(Paths.sound('confirmMenu'));
		for (i in 0...grpOptions.members.length)
		{
			if (i == da)
			{
				if (ClientPrefs.flashing){
					FlxFlicker.flicker(grpOptions.members[i], 1, 0.06, false, false);
				}
			}
		}
		new FlxTimer().start(daTime, function(tmr:FlxTimer)
		{
			MusicBeatState.switchState(new options.PreferencesState());
		});
	}

	function controlsState()
	{	
		for (item in grpOptions.members) {
			item.alpha = 0;
		}
		openSubState(new options.ControlsSubstate());
	}

	function noteColorsState()
	{	
		for (item in grpOptions.members) {
			item.alpha = 0;
		}
		openSubState(new options.NoteColorsSubstate());
	}
	
	function changeSelection(change:Int = 0) {
		curSelected += change;
		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
			}
		}
	}
}

