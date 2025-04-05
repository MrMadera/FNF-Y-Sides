package substates;

import states.FreeplayState;
import states.StoryMenuState;

import objects.Character;

class WinScreen extends MusicBeatSubstate
{
    public var purpleBg:FlxSprite;
    public var boyfriend:Character;

    override function create() 
    {
        super.create();

        purpleBg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFFEEE4FF);
        purpleBg.alpha = 0;
        add(purpleBg);

        FlxTween.tween(purpleBg, {alpha: 0.7}, 0.4);

        boyfriend = new Character(950, 150, 'bf-WinScreen');
        boyfriend.antialiasing = ClientPrefs.data.antialiasing;
        boyfriend.isPlayer = true;
        boyfriend.playAnim('90%');
        boyfriend.animation.finishCallback = function(name:String)
        {
            boyfriend.playAnim('${name}loop');
        }
        add(boyfriend);
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (controls.ACCEPT) 
        {
            close();
            if(PlayState.isStoryMode)
            {
                MusicBeatState.switchState(new StoryMenuState());
            }
            else
            {
                MusicBeatState.switchState(new FreeplayState());
            }
            //FlxG.switchState(new PlayState());
        }
    }
}