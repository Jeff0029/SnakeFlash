package Input
{

import flash.events.KeyboardEvent;
import flash.ui.Keyboard;

    public class InputKeyManager
 {
 public static var KeyDictionary:Vector.<Boolean>;
 public static var BACKSPACE:int = Keyboard.BACKSPACE;
 public static var TAB:int = Keyboard.TAB;
 public static var MIDDLE:int = 12;
 public static var ENTER:int = Keyboard.ENTER;
 public static var SHIFT:int = Keyboard.SHIFT;
 public static var CONTROL:int = Keyboard.CONTROL;
 public static var PAUSE:int = 19;
 public static var BREAK:int = 19;
 public static var CAPS_LOCK:int = Keyboard.CAPS_LOCK;
 public static var ESCAPE:int = Keyboard.ESCAPE;
 public static var SPACEBAR:int = Keyboard.SPACE;
 public static var PAGE_UP:int = Keyboard.PAGE_UP;
 public static var PAGE_DOWN:int = Keyboard.PAGE_DOWN;
 public static var END:int = Keyboard.END;
 public static var HOME:int = Keyboard.HOME;
 public static var LEFT_ARROW:int = Keyboard.LEFT;
 public static var UP_ARROW:int = Keyboard.UP;
 public static var RIGHT_ARROW:int = Keyboard.RIGHT;
 public static var DOWN_ARROW:int = Keyboard.DOWN;
 public static var INSERT:int = Keyboard.INSERT;
 public static var DELETE:int = Keyboard.DELETE;
 public static var NUM_0:int = 48;
 public static var NUM_1:int = 49;
 public static var NUM_2:int = 50;
 public static var NUM_3:int = 51;
 public static var NUM_4:int = 52;
 public static var NUM_5:int = 53;
 public static var NUM_6:int = 54;
 public static var NUM_7:int = 55;
 public static var NUM_8:int = 56;
 public static var NUM_9:int = 57;
 public static var A:int = 65;
 public static var B:int = 66;
 public static var C:int = 67;
 public static var D:int = 68;
 public static var E:int = 69;
 public static var F:int = 70;
 public static var G:int = 71;
 public static var H:int = 72;
 public static var I:int = 73;
 public static var J:int = 74;
 public static var K:int = 75;
 public static var L:int = 76;
 public static var M:int = 77;
 public static var N:int = 78;
 public static var O:int = 79;
 public static var P:int = 80;
 public static var Q:int = 81;
 public static var R:int = 82;
 public static var S:int = 83;
 public static var T:int = 84;
 public static var U:int = 85;
 public static var V:int = 86;
 public static var W:int = 87;
 public static var X:int = 88;
 public static var Y:int = 89;
 public static var Z:int = 90;
 public static var LEFT_WINDOWS:int = 91;
 public static var RIGHT_WINDOWS:int = 92;
 public static var MENU:int = 93;
 public static var NUMPAD_0:int = Keyboard.NUMPAD_0;
 public static var NUMPAD_1:int = Keyboard.NUMPAD_1;
 public static var NUMPAD_2:int = Keyboard.NUMPAD_2;
 public static var NUMPAD_3:int = Keyboard.NUMPAD_3;
 public static var NUMPAD_4:int = Keyboard.NUMPAD_4;
 public static var NUMPAD_5:int = Keyboard.NUMPAD_5;
 public static var NUMPAD_6:int = Keyboard.NUMPAD_6;
 public static var NUMPAD_7:int = Keyboard.NUMPAD_7;
 public static var NUMPAD_8:int = Keyboard.NUMPAD_8;
 public static var NUMPAD_9:int = Keyboard.NUMPAD_9;
 public static var NUMPAD_MULTIPLY:int = Keyboard.NUMPAD_MULTIPLY;
 public static var NUMPAD_ADD:int = Keyboard.NUMPAD_ADD;
 public static var NUMPAD_SUBTRACT:int = Keyboard.NUMPAD_SUBTRACT;
 public static var NUMPAD_DECIMAL:int = Keyboard.NUMPAD_DECIMAL;
 public static var NUMPAD_DIVIDE:int = Keyboard.NUMPAD_DIVIDE;
 public static var F1:int = Keyboard.F1;
 public static var F2:int = Keyboard.F2;
 public static var F3:int = Keyboard.F3;
 public static var F4:int = Keyboard.F4;
 public static var F5:int = Keyboard.F5;
 public static var F6:int = Keyboard.F6;
 public static var F7:int = Keyboard.F7;
 public static var F8:int = Keyboard.F8;
 public static var F9:int = Keyboard.F9;
 public static var F10:int = Keyboard.F10;
 public static var F11:int = Keyboard.F11;
 public static var F12:int = Keyboard.F12;
 public static var F13:int = Keyboard.F13;
 public static var F14:int = Keyboard.F14;
 public static var F15:int = Keyboard.F15;
 public static var NUM_LOCK:int = 144;
 public static var SCROLL_LOCK:int = 145;
 public static var SEMICOLON:int = 186;
 public static var COLON:int = 186;
 public static var EQUALS:int = 187;
 public static var PLUS:int = 187;
 public static var COMMA:int = 188;
 public static var LEFT_ANGLE:int = 188;
 public static var MINUS:int = 189;
 public static var UNDERSCORE:int = 189;
 public static var PERIOD:int = 190;
 public static var RIGHT_ANGLE:int = 190;
 public static var FORWARD_SLASH:int = 191;
 public static var QUESTION_MARK:int = 191;
 public static var BACKQUOTE:int = 192;
 public static var TILDE:int = 192;
 public static var LEFT_BRACKET:int = 219;
 public static var BACKSLASH:int = 220;
 public static var BAR:int = 220;
 public static var RIGHT_BRACKET:int = 221;
 public static var QUOTE:int = 222;

 public static function Init(stage:Main):void
 {
 KeyDictionary = new Vector.<Boolean>();
 stage.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
 stage.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);

 for (var i:int = 0; i < 222; i++)
 {
 KeyDictionary[i] = false;
 }
 }

 private static function onKeyDown(e:KeyboardEvent):void
 {
 if (e.keyCode < 222)
 {
 KeyDictionary[e.keyCode] = true;
 }
 }

 private static function onKeyUp(e:KeyboardEvent):void
 {
 if (e.keyCode < 222)
 {
 KeyDictionary[e.keyCode] = false;
 }
 }

 public static function CheckKeyPress(keycode:int):Boolean
 {
 return KeyDictionary[keycode];
 }



 }
}