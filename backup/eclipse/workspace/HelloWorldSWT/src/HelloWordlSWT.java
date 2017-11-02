import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.widgets.Shell;


public class HelloWordlSWT {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Display display = new Display();
		Shell shell = new Shell(display);
		shell.setText("Hello World!");
		shell.open();
		while (!shell.isDisposed());{
			if(!display.readAndDispatch())
				display.sleep();
		}
		display.dispose();
	}

}
