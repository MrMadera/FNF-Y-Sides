package states;

import objects.AttachedSprite;
import flixel.addons.display.FlxBackdrop;

class CreditsState2 extends MusicBeatState
{

	var bg:FlxSprite;

	var owner:FlxSprite;
	var coOwner:FlxSprite;
	var devs:FlxSprite;

	var gbv:FlxSprite;
	var madera:FlxSprite;
	var foxy:FlxSprite;
	var eli:FlxSprite;

	var psych:FlxSprite;
	var icons:FlxBackdrop;

	override function create() {

		bg = new FlxSprite(-80).makeGraphic(1280, 720, 0xFFEEE4FF);
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);

		icons = new FlxBackdrop(Paths.image('mainmenu/icons'), XY);
		icons.velocity.set(10, 10);
		icons.alpha = 0.45;
		icons.antialiasing = ClientPrefs.data.antialiasing;
		add(icons);

		owner = new FlxSprite(150, 90);
		owner.loadGraphic(Paths.image('credits2/owners'));
		owner.updateHitbox();
		add(owner);

		coOwner = new FlxSprite(650, 60);
		coOwner.loadGraphic(Paths.image('credits2/coOwners'));
		coOwner.updateHitbox();
		add(coOwner);

		gbv = new FlxSprite(150, 200);
		gbv.frames = Paths.getSparrowAtlas('credits2/people/gbv');
		gbv.animation.addByPrefix('idle', 'gbv_neutral', 24, false);
		gbv.animation.addByPrefix('select', 'gbv_selected', 24, false);
		gbv.animation.play('idle');
		add(gbv);

		madera = new FlxSprite(300, 200);
		madera.frames = Paths.getSparrowAtlas('credits2/people/madera');
		madera.animation.addByPrefix('idle', 'madera_neutral', 24, false);
		madera.animation.addByPrefix('select', 'madera_selected', 24, false);
		madera.animation.play('idle');
		add(madera);
	
		foxy = new FlxSprite(700, 200);
		foxy.frames = Paths.getSparrowAtlas('credits2/people/foxy');
		foxy.animation.addByPrefix('idle', 'foxy_neutral', 24, false);
		foxy.animation.addByPrefix('select', 'foxy_selected', 24, false);
		foxy.animation.play('idle');
		add(foxy);

		eli = new FlxSprite(880, 200);
		eli.frames = Paths.getSparrowAtlas('credits2/people/eli');
		eli.animation.addByPrefix('idle', 'eli_neutral', 24, false);
		eli.animation.addByPrefix('select', 'eli_selected', 24, false);
		eli.animation.play('idle');
		add(eli);

		devs = new FlxSprite(500, 1010);
		devs.loadGraphic(Paths.image('credits2/devs'));
		devs.screenCenter(X);
		devs.updateHitbox();
		add(devs);

		psych = new FlxSprite(500, 1510);
		psych.loadGraphic(Paths.image('credits2/psychTeam'));
		psych.screenCenter(X);
		psych.updateHitbox();
		add(psych);
	}

	override function update(elapsed:Float) {
		if (FlxG.keys.justPressed.ESCAPE) {
			FlxG.switchState(new MainMenuState());
		}

		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

		super.update(elapsed);

		FlxG.mouse.visible = true;
	}
}