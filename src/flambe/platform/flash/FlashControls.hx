//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.platform.flash;

import flash.Lib;
import flash.text.TextFieldType;
import flash.display.Stage;
import flash.events.Event;
import flash.utils.Object;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import flambe.animation.AnimatedFloat;
import flambe.subsystem.ControlsSystem;
import flambe.util.Value;
import flambe.controls.TextField;

class FlashControls
	implements ControlsSystem
{
	
	public var supported (get, null) :Bool;

    public function new (stage :Stage)
    {
        _stage = stage;
    }
	
    public static function shouldUse () :Bool
    {
        return true;
    }

    public function get_supported ()
    {
        return true;
    }

    public function createTextField (x :Float, y :Float, width :Float, height :Float) :TextField
    {
        var input = new flash.text.TextField();
        input.type = TextFieldType.INPUT;
        input.border = false;
		input.background = true;
		
		_stage.addChild(input);
        //_container.appendChild(input);

        var view = new FlashTextField(input, x, y, width, height);
        FlashPlatform.instance.mainLoop.addTickable(view);
        return view;
    }

    private var _stage :Stage;
}

class FlashTextField
    implements TextField
    implements Tickable
{
    public var value (default, set) :String;
	
    public var x (default, null) :AnimatedFloat;
    public var y (default, null) :AnimatedFloat;
    public var width (default, null) :AnimatedFloat;
    public var height (default, null) :AnimatedFloat;
	
	// Styles
	public var bold (default, set) :Bool;
	public var italic (default, set) :Bool;
	
    public var input (default, null) :flash.text.TextField;
	
	private var textFormat:TextFormat;

    public function new (input :flash.text.TextField, x :Float, y :Float, width :Float, height :Float)
    {
        this.input = input;
		
		textFormat = new TextFormat();
		textFormat.align = TextFormatAlign.LEFT;
		textFormat.font = "Arial";
		textFormat.color = 0x000000;
		textFormat.size = 12;
		this.input.defaultTextFormat = this.textFormat;
		
        var onBoundsChanged = function (_,_) updateBounds();
        this.x = new AnimatedFloat(x, onBoundsChanged);
        this.y = new AnimatedFloat(y, onBoundsChanged);
        this.width = new AnimatedFloat(width, onBoundsChanged);
        this.height = new AnimatedFloat(height, onBoundsChanged);
        updateBounds();

        
		this.input.addEventListener(Event.CHANGE, onTextChange);
    }

    public function dispose ()
    {
        if (input == null) {
            return; // Already disposed
        }
        input = null;
    }

    public function update (dt :Float) :Bool
    {
        x.update(dt);
        y.update(dt);
        width.update(dt);
        height.update(dt);
        return (input == null);
    }

    private function updateBounds ()
    {
        if (input == null) {
            return; // Already disposed
        }
        input.x = x._;
        input.y = y._;
        input.width = width._;
        input.height = height._;
    }

    private function set_value (value :String) :String
    {
        if (input == null) {
            return ""; // Already disposed
        }
        input.text = value;
		
		return value;
    }
	
	private function refreshTextFormat() {
		this.input.defaultTextFormat = this.textFormat;
	}
	
    private function set_bold (value :Bool) :Bool
    {
        if (input == null) {
            return false; // Already disposed
        }
        this.textFormat.bold = value;
		refreshTextFormat();
		
		return value;
    }
	
    private function set_italic (value :Bool) :Bool
    {
        if (input == null) {
            return false; // Already disposed
        }
        this.textFormat.italic = value;
		refreshTextFormat();
		
		return value;
    }
	
	private function onTextChange(e:Event) {
		this.value = this.input.text;
	}
}
