package {
public class DictionaryTree {
    public function toJSON(k):* {
        return {"_lexicalRoot": _lexicalRoot, "_invertedRoot": _lexicalRoot};
    }

    public var _lexicalRoot:DictionaryTreeVertex;
    public var _invertedRoot:DictionaryTreeVertex;

    public function DictionaryTree() {
        _lexicalRoot = Factory.createDictionaryTreeVertex();
        _invertedRoot = Factory.createDictionaryTreeVertex();
    }

    public function addToLexicalRoot(wrd:String):void {
        var word:Array = wrd.split("");
        fill(_lexicalRoot.setNext(word[0]), word, 1);

        function fill(current:DictionaryTreeVertex, word:Array, index:int):void {
            if (index >= word.length) {
                current.word = word.join("");
                return;
            }
            fill(current.setNext(word[index]), word, index + 1);
        }
    }

    public function addToInvertedRoot(wrd:String):void {
        var invWord:Array = wrd.split("").reverse();
        for (var i:int = 0; i < invWord.length; i++) {
            var word:Array = invWord.slice(i);
            fill(_invertedRoot.setNext(word[0]), word, 1);
        }

        function fill(current:DictionaryTreeVertex, word:Array, index:int):void {
            if (index >= word.length) {
                current.word = word.reverse().join("");
                return;
            }
            fill(current.setNext(word[index]), word, index + 1);
        }
    }
}
}
