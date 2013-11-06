//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.platform.html;

import js.Browser;

import flambe.animation.AnimatedFloat;
import flambe.subsystem.ControlsSystem;
import flambe.util.Value;
import flambe.controls.TextField;

class HtmlControls
    implements ControlsSystem
{
    public var supported (get, null) :Bool;

    public function new (container :Dynamic)
    {
        _container = container;
    }

    public function get_supported () :Bool
    {
        return true;
    }

    public function createTextField (x :Float, y :Float, width :Float, height :Float) :TextField
    {
        var input = Browser.document.createInputElement();
        input.type = "text";
		input.style.position = "absolute";
        input.style.border = "0";
		input.style.outline = "none";
		input.style.color = "#000000";
		input.style.fontSize = "12px";
		
        _container.appendChild(input);

        var view = new HtmlTextField(input, x, y, width, height);
        HtmlPlatform.instance.mainLoop.addTickable(view);
        return view;
    }

    private var _container :Dynamic;
}

class HtmlTextField
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

    public var input (default, null) :Dynamic;

    public function new (input :Dynamic, x :Float, y :Float, width :Float, height :Float)
    {
        this.input = input;

		this.input.oninput = function(_) { _.stopPropagation(); this.value = _.target.value;}

        var onBoundsChanged = function (_,_) updateBounds();
        this.x = new AnimatedFloat(x, onBoundsChanged);
        this.y = new AnimatedFloat(y, onBoundsChanged);
        this.width = new AnimatedFloat(width, onBoundsChanged);
        this.height = new AnimatedFloat(height, onBoundsChanged);
        updateBounds();

    }

    public function dispose ()
    {
        if (input == null) {
            return; // Already disposed
        }
        input.parentNode.removeChild(input);
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
        input.style.left = x._ + "px";
        input.style.top = y._ + "px";
        input.style.width = width._ + "px";
        input.style.height = height._ + "px";
    }
	
    private function set_bold (value :Bool) :Bool
    {
        if (input == null) {
            return false; // Already disposed
        }
		bold = value;
		if(value) {
			input.style.fontWeight = 'bold';
		} else {
			input.style.fontWeight = 'normal';
		}
		
		return value;
    }
	
    private function set_italic (value :Bool) :Bool
    {
        if (input == null) {
            return false; // Already disposed
        }
		italic = value;
		if(value) {
			input.style.fontStyle = 'italic';
		} else {
			input.style.fontStyle = 'normal';
		}
		
		return value;
        
    }

    private function set_value (value :String) :String
    {
        if (input == null) {
            return ""; // Already disposed
        }
		trace ("Got it" + value);
        input.value = value;
		
		return value;
    }
}
