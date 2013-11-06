//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.subsystem;

import flambe.controls.TextField;

/**
 * Functions related to the environment's control elements
 */
interface ControlsSystem
{
    /**
     * True if the environment supports Controls.
     */
    var supported (get, null) :Bool;

    /**
     * Creates a new text field in viewport bounds, in pixels. Fails with an assertion if
     * this environment doesn't support Controls.
     */
    function createTextField (x :Float, y :Float, width :Float, height :Float) :TextField;

}
