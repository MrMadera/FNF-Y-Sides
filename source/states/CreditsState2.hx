package states;

import flixel.FlxObject;
import objects.AttachedSprite;
import flixel.addons.display.FlxBackdrop;

class CreditsState2 extends MusicBeatState
{
	public static var watchingCredits:Bool = false;
	var bg:FlxSprite;

	var owner:FlxSprite;
	var coOwner:FlxSprite;
	var devs:FlxSprite;

	var gbv:FlxSprite;
	var madera:FlxSprite;
	var foxy:FlxSprite;
	var eli:FlxSprite;

	var bunny:FlxSprite;
	var ema:FlxSprite;
	var flash:FlxSprite;
	var hero:FlxSprite;
	var tapi:FlxSprite;

	var psych:FlxSprite;
	var icons:FlxBackdrop;

	var camPos:FlxObject;
	var camPosLerp:FlxObject;
	var topY:Float;
	var bottomY:Float = 850;

	override function create() 
	{
		camPos = new FlxObject(0, 385, 1, 1);
		topY = camPos.y;
		add(camPos);

		camPosLerp = new FlxObject(0, 385, 1, 1);
		add(camPosLerp);

		bg = new FlxSprite(-80).makeGraphic(1280, 720, 0xFFEEE4FF);
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.scrollFactor.set();
		add(bg);

		FlxG.camera.follow(camPosLerp);

		icons = new FlxBackdrop(Paths.image('mainmenu/icons'), XY);
		icons.velocity.set(10, 10);
		icons.alpha = 0.45;
		icons.antialiasing = ClientPrefs.data.antialiasing;
		icons.scrollFactor.set();
		add(icons);

		owner = new FlxSprite(150, 90);
		owner.loadGraphic(Paths.image('credits2/owners'));
		owner.updateHitbox();
		owner.scrollFactor.set(0, 1);
		owner.antialiasing = ClientPrefs.data.antialiasing;
		add(owner);

		coOwner = new FlxSprite(650, 60);
		coOwner.loadGraphic(Paths.image('credits2/coOwners'));
		coOwner.updateHitbox();
		coOwner.scrollFactor.set(0, 1);
		coOwner.antialiasing = ClientPrefs.data.antialiasing;
		add(coOwner);

		gbv = new FlxSprite(120, 200);
		gbv.frames = Paths.getSparrowAtlas('credits2/people/gbv');
		gbv.animation.addByPrefix('idle', 'gbv_neutral', 24, true);
		gbv.animation.addByPrefix('select', 'gbv_selected', 24, true);
		gbv.animation.play('idle');
		gbv.scrollFactor.set(0, 1);
		gbv.antialiasing = ClientPrefs.data.antialiasing;
		add(gbv);

		madera = new FlxSprite(330, 230);
		madera.frames = Paths.getSparrowAtlas('credits2/people/madera');
		madera.animation.addByPrefix('idle', 'madera_neutral', 24, true);
		madera.animation.addByPrefix('select', 'madera_selected', 24, true);
		madera.animation.play('idle');
		madera.scrollFactor.set(0, 1);
		madera.antialiasing = ClientPrefs.data.antialiasing;
		add(madera);
	
		foxy = new FlxSprite(700, 200);
		foxy.frames = Paths.getSparrowAtlas('credits2/people/foxy');
		foxy.animation.addByPrefix('idle', 'sfoxy_neutral', 24, true);
		foxy.animation.addByPrefix('select', 'sfoxy_selected', 24, true);
		foxy.animation.play('idle');
		foxy.scrollFactor.set(0, 1);
		foxy.antialiasing = ClientPrefs.data.antialiasing;
		add(foxy);

		eli = new FlxSprite(880, 200);
		eli.frames = Paths.getSparrowAtlas('credits2/people/eli');
		eli.animation.addByPrefix('idle', 'eli_neutral', 24, true);
		eli.animation.addByPrefix('select', 'eli_selected', 24, true);
		eli.animation.play('idle');
		eli.scrollFactor.set(0, 1);
		eli.antialiasing = ClientPrefs.data.antialiasing;
		add(eli);

		devs = new FlxSprite(500, 510);
		devs.loadGraphic(Paths.image('credits2/devs'));
		devs.screenCenter(X);
		devs.updateHitbox();
		devs.scrollFactor.set(0, 1);
		devs.antialiasing = ClientPrefs.data.antialiasing;
		add(devs);

		bunny = new FlxSprite(20, 600);
		bunny.frames = Paths.getSparrowAtlas('credits2/people/bunny');
		bunny.animation.addByPrefix('idle', 'bunny_neutral', 24, true);
		bunny.animation.addByPrefix('select', 'bunny_selected', 24, true);
		bunny.animation.play('idle');
		bunny.scrollFactor.set(0, 1);
		bunny.antialiasing = ClientPrefs.data.antialiasing;
		add(bunny);

		ema = new FlxSprite(bunny.x + 250, 600);
		ema.frames = Paths.getSparrowAtlas('credits2/people/ema');
		ema.animation.addByPrefix('idle', 'ema_neutral', 24, true);
		ema.animation.addByPrefix('select', 'ema_selected', 24, true);
		ema.animation.play('idle');
		ema.scrollFactor.set(0, 1);
		ema.antialiasing = ClientPrefs.data.antialiasing;
		add(ema);

		flash = new FlxSprite(ema.x + 250, 600);
		flash.frames = Paths.getSparrowAtlas('credits2/people/flash');
		flash.animation.addByPrefix('idle', 'flash_neutral', 24, true);
		flash.animation.addByPrefix('select', 'flash_selected', 24, true);
		flash.animation.play('idle');
		flash.scrollFactor.set(0, 1);
		flash.antialiasing = ClientPrefs.data.antialiasing;
		add(flash);

		hero = new FlxSprite(flash.x + 250, 600);
		hero.frames = Paths.getSparrowAtlas('credits2/people/hero');
		hero.animation.addByPrefix('idle', 'heromax_neutral', 24, true);
		hero.animation.addByPrefix('select', 'heromax_selected', 24, true);
		hero.animation.play('idle');
		hero.scrollFactor.set(0, 1);
		hero.antialiasing = ClientPrefs.data.antialiasing;
		add(hero);

		tapi = new FlxSprite(hero.x + 250, 600);
		tapi.frames = Paths.getSparrowAtlas('credits2/people/tapi');
		tapi.animation.addByPrefix('idle', 'tapi_neutral', 24, true);
		tapi.animation.addByPrefix('select', 'tapi_selected', 24, true);
		tapi.animation.play('idle');
		tapi.scrollFactor.set(0, 1);
		tapi.antialiasing = ClientPrefs.data.antialiasing;
		add(tapi);

		psych = new FlxSprite(500, 1010);
		psych.loadGraphic(Paths.image('credits2/psychTeam'));
		psych.screenCenter(X);
		psych.updateHitbox();
		psych.scrollFactor.set(0, 1);
		psych.antialiasing = ClientPrefs.data.antialiasing;
		add(psych);
	}

	var psychScale:Float = 1;
	override function update(elapsed:Float) {
		if (FlxG.keys.justPressed.ESCAPE && !watchingCredits) {
			FlxG.switchState(new MainMenuState());
		}

		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

		if(FlxG.mouse.wheel != 0 && !watchingCredits) {
			if(FlxG.mouse.wheel > 0) {
				camPos.y -= 100;
				if(camPos.y < topY) 
				{
					camPos.y = topY;
				}
			}

			if(FlxG.mouse.wheel < 0) {
				camPos.y += 100;
				if(camPos.y > bottomY)
				{
					camPos.y = bottomY;
				} 
			}
		}

		camPosLerp.y = FlxMath.lerp(camPosLerp.y, camPos.y, elapsed * 8);

		/*
		automateSprites(gbv, new InfoAboutPerson('gBv2209', 		['Artist', 'Composer'], 		['yt']));
		automateSprites(madera, new InfoAboutPerson('Mr. Madera', 	['Coder'], 						['yt']));
		automateSprites(foxy, new InfoAboutPerson('SFoxyDAC', 		['Animator'], 					['yt']));
		automateSprites(eli, new InfoAboutPerson('EliAnima', 		['Musician'], 					['yt']));
		automateSprites(bunny, new InfoAboutPerson('Bunny', 		['Charter'], 					['yt']));
		automateSprites(ema, new InfoAboutPerson('Zhadnii', 		['Musician'], 					['yt']));
		automateSprites(flash, new InfoAboutPerson('FlashDriveVGM', ['Musician', 'Concept Artist'], ['yt']));
		automateSprites(hero, new InfoAboutPerson('Heromax', 		['Artist'], 					['yt']));
		automateSprites(tapi, new InfoAboutPerson('Tapii', 			['Musician'], 					['yt']));
		*/

		//automateSprites(psych, new CreditsState());

		automateSprites(gbv, 		['gbv2209', 		['Artist', 'Composer'], 		[['yt', 'https://youtube.com'], ['x', 'https://x.com']]]);
		automateSprites(madera, 	['Mr. Madera', 		['Coder'], 						[['yt', 'https://youtube.com']]]);
		automateSprites(foxy, 		['SFoxyDAC', 		['Animator'], 					[['yt', 'https://youtube.com']]]);
		automateSprites(eli, 		['EliAnima', 		['Musician'], 					[['yt', 'https://youtube.com']]]);
		automateSprites(bunny, 		['Bunny', 			['Charter'], 					[['yt', 'https://youtube.com']]]);
		automateSprites(ema, 		['Zhadnii', 		['Musician'], 					[['yt', 'https://youtube.com']]]);
		automateSprites(flash, 		['FlashDriveVGM', 	['Musician', 'Concept Artist'], [['yt', 'https://youtube.com']]]);
		automateSprites(hero, 		['Heromax', 		['Artist'], 					[['yt', 'https://youtube.com']]]);
		automateSprites(tapi, 		['Tapii', 			['Musician'], 					[['yt', 'https://youtube.com']]]);

		var mult = FlxMath.lerp(psych.scale.x, psychScale, elapsed * 7);
		psych.scale.set(mult, mult);

		if(FlxG.mouse.overlaps(psych) && !watchingCredits)
		{
			psychScale = 1.1;
			if(FlxG.mouse.justPressed)
			{
				MusicBeatState.switchState(new CreditsState());	
			}
		}
		else psychScale = 1;

		super.update(elapsed);

		FlxG.mouse.visible = true;
	}

	function automateSprites(spr:FlxSprite, info:Dynamic) {
		if(FlxG.mouse.overlaps(spr) && !watchingCredits) {
			spr.animation.play('select');
			if(FlxG.mouse.justPressed) {
				var xd = new InfoAboutPerson(info[0], info[1], info[2]);
				watchingCredits = true;
				persistentUpdate = true;
				openSubState(xd);
			}
		}
		else spr.animation.play('idle');
	}
}

class InfoAboutPerson extends MusicBeatSubstate
{
	var squareBg:FlxSprite;
	var personName:Alphabet;
	var rolsGrp:FlxTypedGroup<Alphabet>;
	var socialMediasGrp:FlxTypedGroup<FlxSprite>;
	var socialMedias:Array<Dynamic> = [];

	public function new(name:String, rols:Array<String>, avaibleSocialMedias:Array<Dynamic>)
	{
		super();

		socialMedias = avaibleSocialMedias;

		squareBg = new FlxSprite();
		//squareBg.makeGraphic(600, 550, 0xFF000000);
		squareBg.loadGraphic(Paths.image('credits2/background'));
		squareBg.alpha = 0.7;
		squareBg.scrollFactor.set();
		squareBg.screenCenter();
		add(squareBg);

		personName = new Alphabet(0, squareBg.y + 10, name, true);
		personName.x = squareBg.x + squareBg.width / 2 - personName.width / 2;
		personName.scrollFactor.set();
		add(personName);

		rolsGrp = new FlxTypedGroup<Alphabet>();
		add(rolsGrp);

		socialMediasGrp = new FlxTypedGroup<FlxSprite>();
		add(socialMediasGrp);

		for(i in 0...rols.length)
		{
			var rolTxt = new Alphabet(0, 0, rols[i], true);
			rolTxt.setScale(0.7);
			rolTxt.y = personName.y + personName.height + 30 + ((rolTxt.height + 10) * i);
			rolTxt.scrollFactor.set();
			rolTxt.screenCenter(X);
			rolsGrp.add(rolTxt);
		}

		for(i in 0...avaibleSocialMedias.length)
		{
			if(socialMediasGrp.members[i-1] != null) socialMediasGrp.members[i-1].x -= socialMediasGrp.members[i-1].width;

			var socialMediaIcon = new FlxSprite();
			trace('Loading the following social media: ${avaibleSocialMedias[i][0]}');
			switch(avaibleSocialMedias[i][0])
			{
				case 'yt':
					socialMediaIcon.loadGraphic(Paths.image('credits2/icons/yt'));
				case 'disc':
					socialMediaIcon.loadGraphic(Paths.image('credits2/icons/disc'));
				case 'x':
					socialMediaIcon.loadGraphic(Paths.image('credits2/icons/X'));
			}
			socialMediaIcon.scrollFactor.set();
			socialMediaIcon.y = squareBg.y + squareBg.height - socialMediaIcon.height - 10;
			socialMediaIcon.x = squareBg.x + squareBg.width - socialMediaIcon.width - 10;
			socialMediaIcon.ID = i;
			socialMediasGrp.add(socialMediaIcon);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if(controls.BACK)
		{
			CreditsState2.watchingCredits = false;
			close();
		}

		socialMediasGrp.forEach(function(spr:FlxSprite)
		{
			if(FlxG.mouse.overlaps(spr))
			{
				spr.alpha = 1;
				if(FlxG.mouse.justPressed)
				{
					CoolUtil.browserLoad(socialMedias[spr.ID][1]);
				}
			}
			else spr.alpha = 0.7;
		});
	}
}