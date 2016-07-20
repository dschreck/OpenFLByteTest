package;

import openfl.Assets;
import openfl.display.Sprite;
import openfl.utils.ByteArray;
import openfl.utils.Endian;
import openfl.utils.IDataInput;

class Main extends Sprite {
    var _stream:ByteArray;

    public function new() {
        super();

        var _request:String = "assets/cubetest_a.f3d";

        _stream = Assets.getBytes(_request);
        trace('Input length = ${_stream.length}');
        parse(_stream);

    }

    private function parse(bytes:IDataInput):Void {
        bytes.endian = Endian.LITTLE_ENDIAN;

        var m:String = bytes.readMultiByte(3, "");
        var v:Int = bytes.readShort();
        var a:Int = bytes.readUnsignedInt();
        var b:UInt = bytes.readUnsignedInt();

        var ba:ByteArray = new ByteArray();
        bytes.readBytes(ba);

        ba.endian = Endian.LITTLE_ENDIAN;
        ba.position = 0;

        var compressed:ByteArray = new ByteArray();
        compressed.endian = Endian.LITTLE_ENDIAN;
        ba.readBytes(compressed);
        compressed.inflate();
        ba = compressed;

        trace('Output length = ${ba.length}');
        trace("Complete");
    }
}
