import Sys.*;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;
import com.stencyl.graphics.ScaleMode;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Config;
import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.motion.*;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;
import openfl.ui.Keyboard;

class Debugging extends SceneScript
{
	private static var initialized:Bool;
	private static var enabled:Bool;
	private static var show_fps:Bool;
	private static var back_log:Array<String>;
	private static var log:Array<String>;
	private static var debug_key:String;
	private static var debug_action_keys:Array<String>;
	private static var debug_action_keys_state:Array<Int>;
	private static var debug_action_keys_map:Array<Bool>;
	private static var console_font:Font;
	private static var key_down:Bool;
	private static var showing_num_actors_on_screen:Bool;
	private static var showing_num_actors_in_scene:Bool;

	public static function setControl(_control:String, _keyName:String)
	{
		Input.define(_control, []);
		var keyCode:Int = Reflect.field(Keyboard, _keyName);
		Input.mapKey(keyCode, _control);
	}

	/***** Enable/Disable Behaviour *****/
	public static function ChangeState(_state:Bool)
	{
		enabled = _state;
		if(!enabled) {
			ShowHideConsole(false);
		} else {
			setGameAttribute("Debug", false);
			show_fps = true;
			back_log = new Array<String>();
			log = new Array<String>();
			debug_action_keys = ["","","","","","","","","",""];
			debug_action_keys_state = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];
			debug_action_keys_map = [false,false,false,false,false,false,false,false,false,false];
			console_font = getFont(0);
		}

		/* ======================== When Creating ========================= */
		if(!initialized) {
			setControl(debug_key, "Tilda");

			for(k in 0...10)
			{
				setControl(debug_action_keys[k], ("Debug Key " + (k)));
			}

			if(((getGameAttribute("Debug")) : Bool)) {
				ShowHideConsole(true);
			}

			initialized = true;
		}

	}

	/***** Returns true if the console is open *****/
	public static function IsDebugging():Bool
	{
		return ((getGameAttribute("Debug")) : Bool);
	}

	/***** Hide/Show FPS counter *****/
	public static function FPS(_state:Bool)
	{
		show_fps = _state;
	}

	/***** Adds output to the console *****/
	public static function Log(_text:String)
	{
		if(!enabled) return;
		back_log.push(_text);
	}

	/***** Clears Output of the conole *****/
	public static function Clear()
	{
		if(!enabled) return;
		//back_log = [];
		Utils.clear((back_log : Array<String>));
	}

	/***** Logic Condensor *****/
	public static function LogicConcat(_statement:Bool,_value1:Dynamic,_value2:Dynamic):Dynamic
	{
		if(_statement) {
			return _value1;
		} else {
			return _value2;
		}
	}

	/***** Returns a formatted key value pair as text *****/
	public static function FormattedKeyValue(_key:Dynamic,_val:Dynamic):String
	{
		var key:String = Std.string(_key);
		var value:String = Std.string(_val);
		return ((key) + (((":") + (((" ") + (value))))));
	}

	/***** Returns a formatted coordinate as text *****/
	public static function FormattedCoordinate(_object:Dynamic,_x:Dynamic,_y:Dynamic):String
	{
		var object:String = Std.string(_object);
		var x:String = Std.string(_x);
		var y:String = Std.string(_y);
		return ((((object) + (((":") + (((" ") + ("("))))))) + (((x) + (((((",") + (" "))) + (((y) + (")"))))))));
	}

	/***** Returns a formatted vector as text *****/
	public static function FormattedVector(_object:Dynamic,_x:Dynamic,_y:Dynamic,_z:Dynamic):String
	{
		var object:String = Std.string(_object);
		var x:String = Std.string(_x);
		var y:String = Std.string(_y);
		var z:String = Std.string(_z);
		return ((((object) + (((":") + (((" ") + ("("))))))) + (((x) + (((((",") + (" "))) + (((((y) + (((",") + (((" ") + (z))))))) + (")"))))))));
	}

	private static function CreateLog()
	{
		if(!enabled) return;
		
		log = new Array<String>();

		AddLog(("Stencyl Debug Tool v1.0 "));
		AddLog(("Debugging Scene: ") + (getCurrentSceneName()));

		if(show_fps) {
			AddLog(("FPS: ") + (getStepSize()));
		}

		AddLog(FormattedCoordinate("Screen Size", getScreenWidth(), getScreenHeight()));
		AddLog(FormattedCoordinate("Scene Size", getSceneWidth(), getSceneHeight()));
		
		var device:String = "";

		if(#if flash true #else false #end)
		{
			device = "Flash";
		}

		else if(#if html5 true #else false #end)
		{
			device = "HTML5";
		}

		else if(#if desktop true #else false #end)
		{
			device = "Desktop";
		}

		else if(#if ios true #else false #end)
		{
			device = "iOS";
		}

		else if(#if android true #else false #end)
		{
			device = "Android";
		}

		AddLog(("Running on ") + (device : String));

		if(showing_num_actors_on_screen) {
			var num:Int = 0;

			engine.allActors.reuseIterator = false;
			for(actorOnScreen in engine.allActors)
			{
				if(actorOnScreen != null && !actorOnScreen.dead && !actorOnScreen.recycled && actorOnScreen.isOnScreenCache)
				{
					num = num + 1;
				}
			}

			AddLog(FormattedKeyValue("Number of Actors on Screen", num));
		}

		if(showing_num_actors_in_scene) {
			var num:Int = 0;

			engine.allActors.reuseIterator = false;
			for(actor in engine.allActors)
			{
				if(actor != null && !actor.dead && !actor.recycled)
				{
					num = num + 1;
				}
			}

			AddLog(FormattedKeyValue("Number of Actors in Scene", num));
		}
		
		AddLog((""));

		for(l in back_log)
		{
			AddLog((l : String));
		}
	}

	private static function AddLog(_text:String)
	{
		if(!enabled) return;
		log.push(_text);
	}

	private static function ShowHideConsole(_state:Bool)
	{
		if(_state)
		{
			for(index0 in 0...engine.getNumberOfLayers())
			{
				fadeTileLayerTo(engine.getLayerById(index0), 50/100, 0);
			}
			addTileLayer("Debug", engine.getNumberOfLayers());
			enableDebugDrawing();
			setGameAttribute("Debug", true);
		}
		else
		{
			engine.removeLayer(engine.getLayerByName("Debug"));
			for(index0 in 0...engine.getNumberOfLayers())
			{
				fadeTileLayerTo(engine.getLayerById(index0), 100/100, 0);
			}
			setGameAttribute("Debug", false);
			disableDebugDrawing();
		}
	}

	/***** Returns the state of a given key *****/
	public static function GetDebugKeyState(_index:Int,_state:Int):Bool
	{
		if(_state == debug_action_keys_state[_index]) return true;
		return false;
	}

	public static function SetDebugActionKey(_index:Int,_key:String)
	{
		debug_action_keys[_index] = _key;
	}

	public static function SetDebugKey(_key:String)
	{
		debug_key = _key;
	}

	public static function SetConsoleText(_font:Font)
	{
		console_font = _font;
	}

	public static function isEnabled():Bool
	{
		return enabled;
	}

	/* ======================== When Drawing ========================= */
	public static function PrintConsole(g:G)
	{
		if(((getGameAttribute("Debug")) : Bool))
		{
			CreateLog();
			if(enabled) {
				Script.setDrawingLayer(engine.getLayerByName("Debug"));
				g.setFont(console_font);
				for(index0 in 0...log.length)
				{
					g.drawString("" + log[index0], 10, (10 + (g.font.getHeight()/Engine.SCALE * index0)));
				}
			}
		} 
		
		CheckInput();
	}

	public static function CheckInput()
	{
		if(((getGameAttribute("Debug")) : Bool))
		{
			/* =========================== Close Debug Console =========================== */
			if(isKeyDown(debug_key) && !key_down) {
				key_down = true;
				ShowHideConsole(false);
			}

			for(i in 0...10)
			{
				if(isKeyDown(debug_action_keys[i]) && !debug_action_keys_map[i]) {
					debug_action_keys_map[i] = true;
					debug_action_keys_state[i] = 0;
				}
				else if(isKeyDown(debug_action_keys[i]) && debug_action_keys_map[i]) {
					debug_action_keys_state[i] = 1;
				} else if(!isKeyDown(debug_action_keys[i]) && debug_action_keys_map[i]) {
					debug_action_keys_state[i] = 2;
					debug_action_keys_map[i] = false;
				} else {
					debug_action_keys_state[i] = -1;
				}
			}
		} else {
			/* =========================== Open Debug Console =========================== */
			if(isKeyDown(debug_key) && !key_down) {
				key_down = true;
				enableDebugDrawing();
				setGameAttribute("Debug", true);
				addTileLayer("Debug", engine.getNumberOfLayers());
			}
		}

		if(key_down && !isKeyDown(debug_key)) key_down = false;
	}

	public static function PrintList(_list:Array<Dynamic>)
	{
		for(i in 0..._list.length)
		{
			Log(FormattedKeyValue("" + i, ": " + _list[i]));
		}
	}

	public static function Print2DArray(_list:Array<Dynamic>)
	{
		for(i in 0..._list.length)
		{
			var row:String = "";
			for(j in 0..._list[i].length)
			{
				row = ((row) + (" ") + (_list[i][j]));
			}
			Log(row);
		}	
	}

	public static function ShowNumActors(_splash:Bool,_location:Int)
	{
		if(_location == 0) { //On Screen Actors
			showing_num_actors_on_screen = _splash;
		} else { //In Scene Actors
			showing_num_actors_in_scene = _splash;
		}
	}

}