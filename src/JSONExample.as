package {
import flash.text.TextField;

public class JSONExample extends TextField {
    static var nextId = 10000;
    static var revivable_objects:Array = [];
    public var id;

    public function JSONExample(s:String){
        super.text = s;
        id = ++nextId;
    }
    public function toJSON(k):*
    {
        // To be called internally by the JSON.stringify() method.
        // Save the original object internally.
        // Write out only a generated ID and the text value.
        revivable_objects[id] = this;
        return {"classJSONExample":{"reviveId":id,"contents":this.text}};
    }
    public static function revive(id:int):JSONExample
    {
        // For explicit use in the JSON.parse() method.
        // Revives the object using the ID obtained from the JSON string.
        return revivable_objects[id];
    }
}
}
import flash.text.TextField;

var lastId = 20000;
var tf1:TextField = new TextField();
tf1.text = "Lorem ipsum";
var tf2:TextField = new TextField();
tf2.text = "Laughing cows";
var nt:JSONExample = new JSONExample("It was the best of times; it was the worst of times.");

var obj:Object = {a:tf1, b:nt, c:tf2};
var revivable_objects:Array = new Array();

var json_out = JSON.stringify(obj, function(k,v){
            if (v is JSONExample)
            {
                // Send JSONExample objects to the JSON output.
                // Note that stringify() calls JSONExample.toJSON() to serialize this object.
                return v;
            }
            if (v is TextField)
            {
                // Remove TextField objects from the JSON output.
                // Save the original object for reviving later.
                // Return a new object containing an identification marker
                // and the original object's revival ID.
                revivable_objects[++lastId] = v;
                return {"classTextField":{"reviveId":lastId}};
            }
            return v;
        }
);

trace("json_out: " + json_out);

var json_in = JSON.parse(json_out, function(k,v) {
            if ("classTextField" in v) { // special marker tag from stringify() replacer code
                // Retrieve the original object based on the ID stored in the stringify() replacer function.
                var id = v["classTextField"].reviveId;
                return revivable_objects[id];
            } else if ("classJSONExample" in v){
                // Retrieve the original object based on the ID generated in JSONExample.toJSON().
                return JSONExample.revive(v["classJSONExample"].reviveId);
            }
            return v;
        }
);

if (json_in.a)
{
    if (json_in.a.hasOwnProperty("text"))
    {
        trace("json_in.a: " + json_in.a.text);
    }
}
if (json_in.b)
{
    if (json_in.b.hasOwnProperty("text"))
    {
        trace("json_in.b: " + json_in.b.text);
    }
}

if (json_in.c)
{
    if (json_in.c.hasOwnProperty("text"))
    {
        trace("json_in.c: " + json_in.c.text);
    }
}
