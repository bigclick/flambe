//
// Flambe - Rapid game development
// https://github.com/aduros/flambe/blob/master/LICENSE.txt

package flambe.script;

import flambe.animation.Easing;
import flambe.animation.Property;
import flambe.animation.Tween;
import flambe.Entity;
import flambe.math.FMath;

class AnimateTo
    implements Action
{
    public function new (property :PFloat, to :Float, seconds :Float, easing :EasingFunction)
    {
        _property = property;
        _to = to;
        _duration = FMath.toInt(1000*seconds);
        _easing = easing;
    }

    public function update (dt :Int, actor :Entity) :Bool
    {
        if (_tween == null) {
            _tween = new Tween(_property._, _to, _duration, _easing);
            _property.behavior = _tween;
            _property.update(dt); // Fake an update to account for this frame
        }
        if (_property.behavior != _tween) {
            _tween = null;
            return true;
        }
        return false;
    }

    private var _tween :Tween;

    private var _property :PFloat;
    private var _to :Float;
    private var _duration :Int;
    private var _easing :EasingFunction;
}
