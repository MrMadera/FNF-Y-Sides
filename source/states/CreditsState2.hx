package states;

import objects.AttachedSprite;
import flixel.addons.display.FlxBackdrop;

class CreditsState2 extends MusicBeatState
{

	var owner:FlxSprite;
	var bg:FlxSprite;
	var coOwner:FlxSprite;
	var devs:FlxSprite;
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

		devs = new FlxSprite(500, 310);
		devs.loadGraphic(Paths.image('credits2/devs'));
		devs.screenCenter(X);
		devs.updateHitbox();
		add(devs);

		psych = new FlxSprite(500, 510);
		psych.loadGraphic(Paths.image('credits2/psychTeam'));
		psych.screenCenter(X);
		psych.updateHitbox();
		add(psych);
	}

	override function beatHit() {

		FlxTween.cancelTweensOf(owner);
		FlxTween.cancelTweensOf(devs);
		FlxTween.cancelTweensOf(coOwner);
		FlxTween.cancelTweensOf(psych);

		FlxTween.tween(owner, {y: 80}, 2, {ease: FlxEase.circOut});
		owner.y = 90;

		FlxTween.tween(coOwner, {y: 50}, 2, {ease: FlxEase.circOut});
		coOwner.y = 60;

		FlxTween.tween(devs, {y: 300}, 2, {ease: FlxEase.circOut});
		devs.y = 310;

		FlxTween.tween(psych, {y: 500}, 2, {ease: FlxEase.circOut});
		psych.y = 510;

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