package states;

import flixel.addons.display.FlxBackdrop;
import flixel.FlxObject;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import states.editors.MasterEditorMenu;
import options.OptionsState;

enum MainMenuColumn {
	LEFT;
	RIGHT;
}

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '1.0.3'; // This is also used for Discord RPC
	public static var curSelected:Int = 0;
	public static var curColumn:MainMenuColumn = LEFT;
	var allowMouse:Bool = true; //Turn this off to block mouse movement in menus

	var menuItems:FlxTypedGroup<FlxSprite>;
	var menuItems2:FlxTypedGroup<FlxSprite>;
	var leftItem:FlxSprite;
	var rightItem:FlxSprite;

	//Centered/Text options
	var optionShit:Array<String> = [
		'story_mode',
		'freeplay',
		'credits'
	];

	var optionShit2:Array<String> = [
		'options',
		'awards'
	];

	var magenta:FlxSprite;
	var camFollow:FlxObject;

	static var showOutdatedWarning:Bool = true;
	override function create()
	{
		super.create();

		#if MODS_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(-80).makeGraphic(1280, 720, 0xFFFFD593);
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).makeGraphic(1280, 720, 0xFFfd719b);
		magenta.antialiasing = ClientPrefs.data.antialiasing;
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		add(magenta);
		
		var icons = new FlxBackdrop(Paths.image('mainmenu/icons'), XY);
		icons.velocity.set(10, 10);
		icons.alpha = 0.45;
		icons.antialiasing = ClientPrefs.data.antialiasing;
		add(icons);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		menuItems2 = new FlxTypedGroup<FlxSprite>();
		add(menuItems2);

		var scale:Float = 0.9;
		for (num => option in optionShit)
		{
			var item:FlxSprite = createMenuItem(option, 55, (num * 205) + 10);
			item.scale.set(scale, scale);
			item.updateHitbox();
			if(num == 1) item.y += 30;
			if(num == 0 || num == 2) item.x += 30;
			//item.y += (4 - optionShit.length) * 70; // Offsets for when you have anything other than 4 items
			//item.screenCenter(X);
		}

		var characters:FlxSprite = new FlxSprite(500, 0);
		characters.frames = Paths.getSparrowAtlas('mainmenu/menu_characters');
		characters.animation.addByPrefix('idle', 'characters', 24, true);
		characters.animation.play('idle');
		characters.antialiasing = ClientPrefs.data.antialiasing;
		characters.screenCenter(Y);
		add(characters);

		for(num => option in optionShit2)
		{
			var item:FlxSprite = createMenuItem(option, FlxG.width - 190, (num * 155) + 200, true);
			item.scale.set(scale, scale);
			item.updateHitbox();
		}
		
		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		// Unlocks "Freaky on a Friday Night" achievement if it's a Friday and between 18:00 PM and 23:59 PM
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18)
			Achievements.unlock('friday_night_play');

		#if MODS_ALLOWED
		Achievements.reloadList();
		#end
		#end

		#if CHECK_FOR_UPDATES
		if (showOutdatedWarning && ClientPrefs.data.checkForUpdates && substates.OutdatedSubState.updateVersion != psychEngineVersion) {
			persistentUpdate = false;
			showOutdatedWarning = false;
			openSubState(new substates.OutdatedSubState());
		}
		#end

		//FlxG.camera.follow(camFollow, null, 0.15);
	}

	function createMenuItem(name:String, x:Float, y:Float, rightColumn:Bool = false):FlxSprite
	{
		var menuItem:FlxSprite = new FlxSprite(x, y);
		menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_$name');
		menuItem.animation.addByPrefix('idle', '$name basic', 24, true);
		menuItem.animation.addByPrefix('selected', '$name white', 24, true);
		menuItem.animation.play('idle');
		menuItem.updateHitbox();
		
		menuItem.antialiasing = ClientPrefs.data.antialiasing;
		rightColumn ? menuItems2.add(menuItem) : menuItems.add(menuItem);
		return menuItem;
	}

	var actualRightColumn:Bool = false;
	var timeNotMoving:Float = 0;
	var selectedSomethin:Bool = false;
	var scrollMultiplier:Float = 2;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
			FlxG.sound.music.volume = Math.min(FlxG.sound.music.volume + 0.5 * elapsed, 0.8);

		final hudMousePos = FlxG.mouse.getScreenPosition(FlxG.cameras.list[FlxG.cameras.list.length - 1]);

		var multX = (hudMousePos.x - (FlxG.width / 2)) / (FlxG.width / 2);
		var multY = (hudMousePos.y - (FlxG.height / 2)) / (FlxG.height / 2);

		FlxG.camera.scroll.x = FlxMath.lerp(FlxG.camera.scroll.x, (multX * scrollMultiplier), elapsed * 10);
		FlxG.camera.scroll.y = FlxMath.lerp(FlxG.camera.scroll.y, (multY * scrollMultiplier), elapsed * 10);

		if (!selectedSomethin)
		{
			var allowMouse:Bool = allowMouse;
			if (allowMouse && ((FlxG.mouse.deltaScreenX != 0 && FlxG.mouse.deltaScreenY != 0) || FlxG.mouse.justPressed)) //FlxG.mouse.deltaScreenX/Y checks is more accurate than FlxG.mouse.justMoved
			{
				allowMouse = false;
				FlxG.mouse.visible = true;
				timeNotMoving = 0;

				var selectedItem:FlxSprite;
				switch(curColumn)
				{
					case LEFT:
						selectedItem = menuItems.members[curSelected];
					case RIGHT:
						selectedItem = menuItems2.members[curSelected];
				}

				var dist2:Float = -1;
				var distItem2:Int = -1;
				for (i in 0...optionShit2.length)
				{
					var memb2:FlxSprite = menuItems2.members[i];
					if(FlxG.mouse.overlaps(memb2))
					{
						var distance:Float = Math.sqrt(Math.pow(memb2.getGraphicMidpoint().x - FlxG.mouse.screenX, 2) + Math.pow(memb2.getGraphicMidpoint().y - FlxG.mouse.screenY, 2));
						if (dist2 < 0 || distance < dist2)
						{
							dist2 = distance;
							distItem2 = i;
							allowMouse = true;
						}
					}
				}

				if(distItem2 != -1 && selectedItem != menuItems2.members[distItem2])
				{
					actualRightColumn = true;
					curColumn = RIGHT;
					curSelected = distItem2;
					changeItem();
				}
				
				var dist:Float = -1;
				var distItem:Int = -1;
				for (i in 0...optionShit.length)
				{
					var memb:FlxSprite = menuItems.members[i];
					if(FlxG.mouse.overlaps(memb))
					{
						var distance:Float = Math.sqrt(Math.pow(memb.getGraphicMidpoint().x - FlxG.mouse.screenX, 2) + Math.pow(memb.getGraphicMidpoint().y - FlxG.mouse.screenY, 2));
						if (dist < 0 || distance < dist)
						{
							dist = distance;
							distItem = i;
							allowMouse = true;
						}
					}
				}

				if(distItem != -1 && selectedItem != menuItems.members[distItem])
				{
					actualRightColumn = false;
					curColumn = LEFT;
					curSelected = distItem;
					changeItem();
				}
			}
			else
			{
				timeNotMoving += elapsed;
				if(timeNotMoving > 2) FlxG.mouse.visible = false;
			}

			if(controls.UI_LEFT_P)
			{
				curColumn = LEFT;
				actualRightColumn = false;
				changeItem(0, actualRightColumn);
			}
	
			if(controls.UI_RIGHT_P)
			{
				curColumn = RIGHT;
				actualRightColumn = true;
				changeItem(0, actualRightColumn);
			}
	
			if(controls.UI_DOWN_P)
			{
				changeItem(1, actualRightColumn);
			}
	
			if(controls.UI_UP_P)
			{
				changeItem(-1, actualRightColumn);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.mouse.visible = false;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT || (FlxG.mouse.justPressed && allowMouse))
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));
				selectedSomethin = true;
				FlxG.mouse.visible = false;

				if (ClientPrefs.data.flashing)
					FlxFlicker.flicker(magenta, 1.1, 0.15, false);

				var item:FlxSprite;
				var option:String;
				switch(curColumn)
				{
					case LEFT:
						option = optionShit[curSelected];
						item = menuItems.members[curSelected];

					case RIGHT:
						option = optionShit2[curSelected];
						item = menuItems2.members[curSelected];
				}

				FlxFlicker.flicker(item, 1, 0.06, false, false, function(flick:FlxFlicker)
				{
					switch (option)
					{
						case 'story_mode':
							MusicBeatState.switchState(new StoryMenuState());
						case 'freeplay':
							MusicBeatState.switchState(new FreeplayState());

						#if MODS_ALLOWED
						case 'mods':
							MusicBeatState.switchState(new ModsMenuState());
						#end

						#if ACHIEVEMENTS_ALLOWED
						case 'awards':
							MusicBeatState.switchState(new AchievementsMenuState());
						#end

						case 'credits':
							MusicBeatState.switchState(new CreditsState());
						case 'options':
							MusicBeatState.switchState(new OptionsState());
							OptionsState.onPlayState = false;
							if (PlayState.SONG != null)
							{
								PlayState.SONG.arrowSkin = null;
								PlayState.SONG.splashSkin = null;
								PlayState.stageUI = 'normal';
							}
						case 'donate':
							CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
							selectedSomethin = false;
							item.visible = true;
						default:
							trace('Menu Item ${option} doesn\'t do anything');
							selectedSomethin = false;
							item.visible = true;
					}
				});
				
				for (memb in menuItems)
				{
					if(memb == item)
						continue;

					FlxTween.tween(memb, {alpha: 0}, 0.4, {ease: FlxEase.quadOut});
				}

				for (memb in menuItems2)
				{
					if(memb == item)
						continue;

					FlxTween.tween(memb, {alpha: 0}, 0.4, {ease: FlxEase.quadOut});
				}
			}
			#if desktop
			if (controls.justPressed('debug_1'))
			{
				selectedSomethin = true;
				FlxG.mouse.visible = false;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);
	}

	function changeItem(change:Int = 0, ?rightColumn:Bool)
	{
		if(rightColumn) curSelected = FlxMath.wrap(curSelected + change, 0, optionShit2.length - 1);
		else curSelected = FlxMath.wrap(curSelected + change, 0, optionShit.length - 1);
		FlxG.sound.play(Paths.sound('scrollMenu'));

		for (item in menuItems)
		{
			item.animation.play('idle');
			item.centerOffsets();
		}

		for (item in menuItems2)
		{
			item.animation.play('idle');
			item.centerOffsets();
		}

		var selectedItem:FlxSprite;
		switch(curColumn)
		{
			case LEFT:
				selectedItem = menuItems.members[curSelected];
			case RIGHT:
				selectedItem = menuItems2.members[curSelected];
		}
		if(selectedItem != null) {
			selectedItem.animation.play('selected');
			selectedItem.centerOffsets();
			camFollow.y = selectedItem.getGraphicMidpoint().y;
		}
	}
}