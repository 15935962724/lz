package dzews;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class ReadText {

	 public static final void readF1(String filePath) throws IOException {
	  BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(filePath)));
	  int i=1;
	  for (String line = br.readLine(); line != null; line = br.readLine()) {
	   System.out.println(i+":"+line);
	   i++;
	  }
	  br.close();

	 }

	 public static final void readF2(String filePath) throws IOException
	 {
		  FileReader fr = new FileReader(filePath);
		  BufferedReader bufferedreader = new BufferedReader(fr);
		  String instring;
		  while ((instring = bufferedreader.readLine().trim()) != null) {
		   if (0 != instring.length()) {
		    System.out.println(instring);
		   }
		  }
		  fr.close();
	 }
//	 public static void main (String [] arge)
//	 {
//		 /*
//		 try {
//
//			ReadText.readF1("c://b.txt");
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		*/
//	 }

}
