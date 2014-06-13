package {
import feathers.controls.Label;
import feathers.themes.AeonDesktopTheme;

public class ExtendedAeonDesktopTheme extends AeonDesktopTheme {
    override protected function labelInitializer(label:Label):void {
        super.labelInitializer(label);
        label.textRendererProperties.textFormat.color = 0xffffff;
    }
}
}
