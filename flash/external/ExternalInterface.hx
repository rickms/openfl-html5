package flash.external;


class ExternalInterface {
	
	
	public static var available = false;
	public static var marshallExceptions = false;
	
	
	public static function addCallback (functionName:String, closure:Dynamic):Void {
				
		// FYI: new functionality
		// add the named function as a method on the containing HTMLElement in order that
		// it can be called from the containing page, as in Flash.
		//flash.Lib.addCallback (functionName, closure);
		
	}
	
	
	public static function call (functionName:String, ?p1:Dynamic, ?p2:Dynamic, ?p3:Dynamic, ?p4:Dynamic, ?p5:Dynamic):Dynamic {
		// FYI: new functionality
		// call the named function on the containing page, as in Flash
		var callResponse:Dynamic = null;
		
		if (p1 == null) {
			
			callResponse = js.Lib.eval (functionName) ();
			
		} else if (p2 == null) {
			
			callResponse = js.Lib.eval (functionName) (p1);
			
		} else if (p3 == null) {
			
			callResponse = js.Lib.eval (functionName) (p1, p2);
			
		} else if (p4 == null) {
			
			callResponse = js.Lib.eval (functionName) (p1, p2, p3);
			
		} else if (p5 == null) {
			
			callResponse = js.Lib.eval (functionName) (p1, p2, p3, p4);
			
		} else {
			
			callResponse = js.Lib.eval (functionName) (p1, p2, p3, p4, p5);
			
		}
		
		return callResponse;

		// FYI: old functionality
		// simply call from the Map of functions instead of calling on the containing page as in Flash
		//if (mCallbacks == null || !mCallbacks.exists(functionName)) return null;
		//return Reflect.callMethod(null, mCallbacks.get(functionName), [ p1, p2, p3, p4, p5 ]);
	}
	
	
}