package substates;

import states.FreeplayState;
import states.StoryMenuState;

import objects.Character;

class WinScreen extends MusicBeatSubstate
{
    public var purpleBg:FlxSprite;
    public var boyfriend:Character;
    public var songNameSprite:FlxSprite;
    public var scoreChart:FlxSprite;

    public var scoreText:FlxText;
    public var missesText:FlxText;
    public var ratingText:FlxText;

    override function create() 
    {
        super.create();

        purpleBg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFFEEE4FF);
        purpleBg.alpha = 0;
        add(purpleBg);

        FlxTween.tween(purpleBg, {alpha: 1}, 0.4);

        boyfriend = new Character(950, 150, 'bf-WinScreen');
        boyfriend.antialiasing = ClientPrefs.data.antialiasing;
        boyfriend.isPlayer = true;

        var rating = PlayState.instance.ratingPercent * 100;
        if(rating >= 90)
        {
            boyfriend.playAnim('90%');
        }
        else if(rating >= 75 && rating < 90)
        {
            boyfriend.playAnim('75%');
        }
        else if(rating >= 65 && rating < 75)
        {
            boyfriend.playAnim('65%');
        }
        else if(rating >= 55 && rating < 65)
        {
            boyfriend.playAnim('55%');
        }
        else
        {
            boyfriend.playAnim('0%');
        }

        boyfriend.animation.finishCallback = function(name:String)
        {
            boyfriend.playAnim('${name}loop');
        }
        add(boyfriend);

        var songName = PlayState.instance.curSong;
        songNameSprite = new FlxSprite(20, 15).loadGraphic(Paths.image('songCards/$songName'));
        songNameSprite.antialiasing = ClientPrefs.data.antialiasing;
        add(songNameSprite);

        scoreChart = new FlxSprite(0, 210).makeGraphic(400, 450, 0xFF000000);
        scoreChart.x = songNameSprite.x + songNameSprite.width / 2 - scoreChart.width / 2;
        scoreChart.alpha = 0.5;
        add(scoreChart);

        var score:Int = 0;
        var misses:Int = 0;
        var rating:Int = 0;
        
        if(PlayState.isStoryMode)
        {
            score = PlayState.campaignScore;
            misses = PlayState.campaignMisses;
            rating = Std.int(PlayState.campaignRating / PlayState.instance.totalSongsPlayed);
        }
        else
        {
            score = PlayState.instance.songScore;
            misses = PlayState.instance.songMisses;
            rating = Std.int(PlayState.instance.ratingPercent * 100);
        }
        
        scoreText = new FlxText(scoreChart.x + 4, scoreChart.y + 4, 398, 'Score: 0');
		scoreText.setFormat(Paths.font("FredokaOne-Regular.ttf"), 35);
        add(scoreText);
        
        missesText = new FlxText(scoreChart.x + 4, scoreText.y + scoreText.height + 10, 398, 'Misses: 0');
		missesText.setFormat(Paths.font("FredokaOne-Regular.ttf"), 35);
        add(missesText);

        ratingText = new FlxText(scoreChart.x + 4, missesText.y + missesText.height + 10, 398, 'Rating: 0');
		ratingText.setFormat(Paths.font("FredokaOne-Regular.ttf"), 35);
        add(ratingText);

        new FlxTimer().start(0.5, function(tmr:FlxTimer)
        {
            FlxTween.num(0, score, 0.5, {ease: FlxEase.linear}, function(v:Float)
            {
                scoreText.text = 'Score: ${Std.int(v)}';
            });
            FlxTween.num(0, misses, 0.5, {ease: FlxEase.linear}, function(v:Float)
            {
                missesText.text = 'Misses: ${Std.int(v)}';
            });
            FlxTween.num(0, rating, 0.5, {ease: FlxEase.linear}, function(v:Float)
            {
                ratingText.text = 'Rating: ${Std.int(v)}%';
            });
        });
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