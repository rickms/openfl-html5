package flash.events;


import flash.display.InteractiveObject;
import flash.geom.Point;


class MouseEvent extends Event {
	
	
	public static var CLICK:String = "click";
	public static var DOUBLE_CLICK:String = "doubleClick";
	public static var MIDDLE_CLICK:String = "middleClick";
	public static var MIDDLE_MOUSE_DOWN:String = "middleMouseDown";
	public static var MIDDLE_MOUSE_UP:String = "middleMouseUp";
	public static var MOUSE_DOWN:String = "mouseDown";
	public static var MOUSE_MOVE:String = "mouseMove";
	public static var MOUSE_OUT:String = "mouseOut";
	public static var MOUSE_OVER:String = "mouseOver";
	public static var MOUSE_UP:String = "mouseUp";
	public static var MOUSE_WHEEL:String = "mouseWheel";
	public static var RIGHT_CLICK:String = "rightClick";
	public static var RIGHT_MOUSE_DOWN:String = "rightMouseDown";
	public static var RIGHT_MOUSE_UP:String = "rightMouseUp";
	public static var ROLL_OUT:String = "rollOut";
	public static var ROLL_OVER:String = "rollOver";
	
	public var altKey:Bool;
	public var buttonDown:Bool;
	public var commandKey:Bool;
	public var clickCount:Int;
	public var ctrlKey:Bool;
	public var delta:Int;
	public var localX:Float;
	public var localY:Float;
	public var relatedObject:InteractiveObject;
	public var shiftKey:Bool;
	public var stageX:Float;
	public var stageY:Float;
	
	
	public function new (type:String, bubbles:Bool = true, cancelable:Bool = false, localX:Float = 0, localY:Float = 0, relatedObject:InteractiveObject = null, ctrlKey:Bool = false, altKey:Bool = false, shiftKey:Bool = false, buttonDown:Bool = false, delta:Int = 0, commandKey:Bool = false, clickCount:Int = 0) {
		
		super (type, bubbles, cancelable);
		
		this.shiftKey = shiftKey;
		this.altKey = altKey;
		this.ctrlKey = ctrlKey;
		this.bubbles = bubbles;
		this.relatedObject = relatedObject;
		this.delta = delta;
		this.localX = localX;
		this.localY = localY;
		this.buttonDown = buttonDown;
		this.commandKey = commandKey;
		this.clickCount = clickCount;
		
	}
	
	
	public static function __create (type:String, event:js.html.MouseEvent, local:Point, target:InteractiveObject):MouseEvent {
		
		var __mouseDown = false;
		var delta = 2;
		
		if (type == MouseEvent.MOUSE_WHEEL) {
			
			var mouseEvent:Dynamic = event;
			if (mouseEvent.wheelDelta) { /* IE/Opera. */
				#if (!haxe_210 && !haxe3)
				if (js.Lib.isOpera)
					delta = Std.int (mouseEvent.wheelDelta / 40);
				else
				#end
					delta = Std.int (mouseEvent.wheelDelta / 120);
			} else if (mouseEvent.detail) { /** Mozilla case. */
				
				Std.int (-mouseEvent.detail);
				
			}
			
		}
		
		// source: http://unixpapa.com/js/mouse.html
		if (type == MouseEvent.MOUSE_DOWN || type == MouseEvent.MOUSE_MOVE) {
			
			__mouseDown = if (event.which != null) 
				event.which == 1
			else if (event.button != null) 
				#if (haxe_210 || haxe3)
				(event.button == 0) 
				#else
				(js.Lib.isIE && event.button == 1 || event.button == 0) 
				#end
			else false;
			
		} else if (type == MouseEvent.MOUSE_UP) {
			
			if (event.which != null) 
				if (event.which == 1)
					__mouseDown = false;
			else if (event.button != null) 
				#if (haxe_210 || haxe3)
				if (event.button == 0)
				#else
				if (js.Lib.isIE && event.button == 1 || event.button == 0) 
				#end
					__mouseDown = false;
			else 
				__mouseDown = false;
			
		}
		
		var pseudoEvent = new MouseEvent (type, true, false, local.x, local.y, null, event.ctrlKey, event.altKey, event.shiftKey, __mouseDown, delta);
		pseudoEvent.stageX = Lib.current.stage.mouseX;
		pseudoEvent.stageY = Lib.current.stage.mouseY;
		pseudoEvent.target = target;
		
		return pseudoEvent;
		
	}
	
	
	public function updateAfterEvent ():Void {
		
		
		
	}
	
	
}