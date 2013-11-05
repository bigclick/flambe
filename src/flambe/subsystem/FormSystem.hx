//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.subsystem;

import flambe.form.TextField;

/**
 * Functions related to the environment's form elements
 */
interface FormSystem
{
    /**
     * True if the environment supports Forms.
     */
    var supported (get, null) :Bool;

    /**
     * Creates a new text field in viewport bounds, in pixels. Fails with an assertion if
     * this environment doesn't support Forms.
     */
    function createTextField (x :Float, y :Float, width :Float, height :Float) :TextField;

}
