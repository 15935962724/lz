package tea.entity.csvclub;

import java.io.*;
import tea.entity.*;

public class TelephoneFile extends Entity
{
    public TelephoneFile()
    {
    }
    public boolean writeFile(String con, String path)
    {
//File dir=new File(filePath);
        File f = new File(path);
        try
        {
            FileWriter outFile = new FileWriter(f);
            BufferedWriter bufferOut = new BufferedWriter(outFile);
            bufferOut.write(con);
            bufferOut.newLine();
            bufferOut.flush();
            bufferOut.close();
            return true;
        }

        catch (IOException e)
        {
            return false;
        }

    }


}
