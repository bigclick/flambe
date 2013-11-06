//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.controls;

import flambe.animation.AnimatedFloat;
import flambe.util.Disposable;

/**
 * Displays a textfield for user input. In the HTML target, this is implemented with an input tag overlayed on the stage. In
 * AIR/Flash, it uses flash.text.TextField
 */
interface TextField extends Disposable
{
    /**
     * The value of the input.
     */
    var value (default, set) :String;

    /**
     * Viewport X position, in pixels.
     */
    var x (default, null) :AnimatedFloat;

    /**
     * Viewport Y position, in pixels.
     */
    var y (default, null) :AnimatedFloat;

    /**
     * Viewport width, in pixels.
     */
    var width (default, null) :AnimatedFloat;

    /**
     * Viewport height, in pixels.
     */
    var height (default, null) :AnimatedFloat;
	
    /**
     * Set the input font weight to be bold
     */
    var bold (default, set) :Bool;
	
    /**
     * Set the input font style to be italic
     */
    var italic (default, set) :Bool;
}
