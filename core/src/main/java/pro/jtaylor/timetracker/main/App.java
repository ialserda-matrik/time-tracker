package pro.jtaylor.timetracker.main;

import java.io.IOException;
import java.util.ResourceBundle;
import java.util.jar.Attributes;
import java.util.jar.Manifest;

public class App {

    public static void main( String[] args ) throws IOException {
        System.out.println("Verify Resource bundle");

        // Check filtered resources based on generated build number
        ResourceBundle bundle = ResourceBundle.getBundle( "build" );
        String msg = bundle.getString( "build.message" );
        System.out.println(msg);

        System.out.println("\nVerify Generated MANIFEST.MF Properties" );


    }




}
