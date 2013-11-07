package ;

import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import haxe.Timer;
import ru.stablex.ui.UIBuilder;
import ru.stablex.ui.widgets.Button;
import ru.stablex.ui.widgets.Widget;

/**
 * ...
 * @author 
 */

class Main extends Sprite 
{
	var inited:Bool;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function init() 
	{
		if (inited) return;
		inited = true;

		//initialize StablexUI
        UIBuilder.init();

        //Create UI and attach it to root display object
        var item = cast (Lib.current.addChild( UIBuilder.buildFn('src/ui/position.xml')() ), Widget);
        
        var b:ru.stablex.ui.widgets.Box = cast item.getChild("list");
        
        var f = function() { 
            var r = Std.random(2000);
            var newItem = UIBuilder.create(Item, { } );
            b.addChild(newItem);
            var label = newItem.getChildAs("btn", Button);
            label.label.text = Std.string(r);
            newItem.visible = false; //hide until refreshing. ( not correctly centered)
            var scroll:ru.stablex.ui.widgets.Scroll = cast item.getChild("slist");
            scroll.refresh();
            newItem.visible = true;
            trace('BUG: last shown item should be $r');
			scroll.scrollY = -10000000; //force scroll to bottom
            
        };
        
        var timer = new Timer(1000);
        timer.run = f;
		
		// (your code here)
		
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
	}

	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
