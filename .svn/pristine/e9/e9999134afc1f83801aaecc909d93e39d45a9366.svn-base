package tea.service;

import java.awt.Frame;
import java.io.*;
import java.math.BigDecimal;
import java.net.URL;
import java.net.URLConnection;
import java.util.Date;
import java.util.StringTokenizer;
import tea.entity.node.Stock;
import tea.entity.node.StockQuote;
import tea.entity.site.License;

class Update extends Service implements Runnable
{

    public Update(int i, int j)
    {
        super(i, j);
    }

    public void run()
    {
        while(Robot._blStarted)
        {
            setTitle(" Updating");
            long l = System.currentTimeMillis();
            clearLog();
            addLog(" Start");
            addLog(" Update marke quotes");
            setStatus(" Update market quotes");
            try
            {
                new StringBuilder();
                int i = Stock.count("");
                for(int j = 0; j < i; j += 100)
                {
                	Stock s = Stock.find(j);//
                    try
                    {
                        URL url = new URL("http://quote.yahoo.com/d/quotes.csv?f=sl1c1ohgv&s=" + s.code);
                        URLConnection urlconnection = url.openConnection();
                        urlconnection.setUseCaches(false);
                        BufferedReader bufferedreader = new BufferedReader(new InputStreamReader(urlconnection.getInputStream()));
                        String s1;
                        while((s1 = bufferedreader.readLine()) != null)
                        {
                            StringTokenizer stringtokenizer = new StringTokenizer(s1, ",\"+");
                            if(stringtokenizer.countTokens() == 7)
                                try
                                {
                                    String s2 = stringtokenizer.nextToken();
                                    BigDecimal bigdecimal = new BigDecimal(stringtokenizer.nextToken());
                                    BigDecimal bigdecimal1 = new BigDecimal(stringtokenizer.nextToken());
                                    BigDecimal bigdecimal2 = bigdecimal.add(bigdecimal1);
                                    BigDecimal bigdecimal3 = bigdecimal1.multiply(new BigDecimal(100D)).divide(bigdecimal2, 4);
                                    BigDecimal bigdecimal4 = new BigDecimal(stringtokenizer.nextToken());
                                    BigDecimal bigdecimal5 = new BigDecimal(stringtokenizer.nextToken());
                                    BigDecimal bigdecimal6 = new BigDecimal(stringtokenizer.nextToken());
                                    int k = 0;
                                    if(!s2.startsWith("^"))
                                        try
                                        {
                                            k = Integer.parseInt(stringtokenizer.nextToken());
                                        }
                                        catch(Exception _ex) { }
                                    StockQuote stockquote = StockQuote.find(s2);
                                    stockquote.set(bigdecimal, bigdecimal1, bigdecimal3, k, bigdecimal4, bigdecimal6, bigdecimal5);
                                }
                                catch(Exception _ex) { }
                        }
                        bufferedreader.close();
                    }
                    catch(Exception exception2)
                    {
                        System.err.println("UpdateMarket: " + exception2);
                    }
                }

            }
            catch(Exception exception)
            {
                System.err.println("UpdateMarket: " + exception);
            }
            addLog(" Clear temporary data");
            setStatus(" Clear temporary data");
            try
            {
                License.getInstance().clear();
            }
            catch(Exception exception1)
            {
                System.err.println("Clear temporary: " + exception1);
            }
            addLog(" Stop");
            System.currentTimeMillis();
            long l1 = l + 0x1b7740L;
            long l2 = l1 - System.currentTimeMillis();
            if(l2 > 0L)
            {
                setStatus("  Idling until " + new Date(l1));
                try
                {
                    Thread.sleep(l2);
                }
                catch(Exception _ex) { }
            }
        }
    }
}
