package states;

import flixel.FlxSubState;

import flixel.effects.FlxFlicker;
import lime.app.Application;

import objects.Character;

class FlashingState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var bg:FlxSprite;
	var bf:Character;

	var alreadyPressed:Bool = false;

	override function create()
	{
		super.create();

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		bf = new Character(100, 300, 'bf-FlashWarning');
		bf.antialiasing = ClientPrefs.data.antialiasing;
		bf.playAnim('warningFlash');
		bf.animation.finishCallback = function(name:String)
		{
			if(name == 'warningFlash') 
			{
				bf.playAnim('warningFlashLoop');
			} 
			else if(name == 'warningFlashEnd') 
			{
				bf.playAnim('warningFlashEndLoop');
			} 
		}
		add(bf);
	}

	override function update(elapsed:Float)
	{
		if(leftState) {
			super.update(elapsed);
			return;
		}
		var back:Bool = controls.BACK;

		if(!alreadyPressed) {
			if (controls.ACCEPT || back) {
				alreadyPressed = true;
				leftState = true;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if(back) {
					ClientPrefs.data.flashing = true;
					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					doAnimStuff();
				} else {
					ClientPrefs.data.flashing = false;
					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('cancelMenu'));
					doAnimStuff();
				}
			}
		}
		super.update(elapsed);
	}

	function doAnimStuff()
	{
		bf.playAnim('warningFlashEnd', true);
		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			FlxTween.tween(bf, {alpha: 0}, 0.5, {onComplete: function(twn:FlxTween)
			{
				MusicBeatState.switchState(new TitleState());
			}});
			
		});
	}
}
