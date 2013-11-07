package ;

/**
 * ...
 * @author EzeQL
 */
import ru.stablex.ui.UIBuilder;

class Init
{


    
     macro static public function init () : Void{

        //register classes for usage in xml.
        //UIBuilder.regClass("com.example.CustomExt");

        //create xml-based classes for custom widgets
        UIBuilder.buildClass("src/ui/item.xml", "Item");

    }
    
}