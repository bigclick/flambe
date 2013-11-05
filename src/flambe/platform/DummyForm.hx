//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.platform;

import flambe.subsystem.FormSystem;
import flambe.util.Assert;
import flambe.form.TextField;

class DummyForm
    implements FormSystem
{
    public var supported (get, null) :Bool;

    public function new ()
    {
    }

    public function get_supported ()
    {
        return false;
    }

    public function createTextField (x :Float, y :Float, width :Float, height :Float) :TextField
    {
        Assert.fail("Form.createTextField is unsupported in this environment, check the `supported` flag.");
        return null;
    }
}
