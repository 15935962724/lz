<form name="form1" method="get" action="/servlet/ExportNodeToHtml">
  <input type="text" name="Node">
  <input type="submit" name="Submit" value="Submit">
</form>
<%
   java.net.URLConnection conn = new java.net.URL("HTTP", "127.0.0.1", 80, "/abc/").openConnection();
        java.io.InputStream is = conn.getInputStream();
        int len = conn.getContentLength();
        String str;
          byte by[] = new byte[len];
          is.read(by);
          is.close();
str=new String( by);

//org.htmlparser.Parser p=org.htmlparser.Parser.createParser(str,"GBK");
//p.elements();
ParserGetter kit = new ParserGetter();
        javax.swing.text.html.HTMLEditorKit.Parser parser = kit.getParser();

        javax.swing.text.html.HTMLEditorKit.ParserCallback callback = new parseHTML();

        try {
            // 輸入欲分析的網頁
            java.net.URL u = new java.net.URL("http://127.0.0.1/abc/");

            // 讀入網頁
            java.io.InputStream in =new java.io.FileInputStream("D:/Untitled-1.htm"); //u.openStream();
            java.io.InputStreamReader r = new java.io.InputStreamReader(in);

            // 呼叫 parse method 開始進行  Parse HTML
          //  parser.parse(r, callback, true);

        } catch (java.io.IOException e) {
            System.err.println(e);
        }


        org.htmlparser.NodeFilter filter1 = new org.htmlparser.filters.NodeClassFilter(org.htmlparser.tags.ImageTag.class);
        org.htmlparser.Parser p = new org.htmlparser.Parser(("http://127.0.0.1/abc/servlet/Node?node=212"));
        //p.setEncoding("UTF-8");
        //p.setInputHTML(html);

        org.htmlparser.util.NodeList list = p.extractAllNodesThatMatch(filter1);
        for (int i = 0; i < list.size(); i++)
        {
            org.htmlparser.tags.ImageTag it = (org.htmlparser.tags.ImageTag) list.elementAt(i);
            String url = it.getImageURL();
            java.io.File file = new java.io.File(url);

            java.io.InputStream fis = null;
            try
            {
                fis =new java.net.URL(url).openConnection().getInputStream();

                byte by123[] = new byte[(int) file.length()];
                fis.read(by123);
                fis.close();
                /*
                             String ex=file.getName();
                             int in=ex.lastIndexOf(".");
                             if(in!=-1)
                             {
                    ex=ex.substring(in);
                             }else
                    ex="";*/
                String name = "/img/" + System.currentTimeMillis() + file.getName();
              //  zos.putNextEntry(new java.util.zip.ZipEntry(name));
             //   zos.write(by);
                for (int j = it.getAttribute("SRC").length() - name.length(); j > 0; j--)
                {
                    name += " ";
                }
                it.setAttribute("SRC", name);
                int start = it.getStartPosition();
                int end = it.getEndPosition();
               // html = html.substring(0, start) + it.toHtml() + html.substring(end);
            } catch (java.io.FileNotFoundException ex)
            {
                ex.printStackTrace();
            } catch (java.io.IOException ex1)
            {
                ex1.printStackTrace();
            }
        }

%>
<%!
class parseHTML extends javax.swing.text.html.HTMLEditorKit.ParserCallback
{
  boolean inHeader=false;
  public void handleText(char[] text, int position) {
   {
           // 印出 xxxx => <A HREF = ....> xxxx </A>
           // xxxx => HTML Tag A 的文字 (text)
           if(inHeader)
           System.out.println(text);
       }
    }
  public void handleStartTag(javax.swing.text.html.HTML.Tag tag, javax.swing.text.MutableAttributeSet attributes,int position) {

        // 分析 Tag 的重點在這行
         // System.out.println(tag);

        if (tag == javax.swing.text.html.HTML.Tag.IMG) {
                  System.out.println(position);
           System.out.println(tag);
           inHeader=true;
        }
    }
  public void handleEndTag(javax.swing.text.html.HTML.Tag tag, int position) {
        if (tag == javax.swing.text.html.HTML.Tag.IMG) {
            inHeader = false;
        }
    }
public void handleError(String errorMsg, int pos){
  System.out.println(pos+":"+errorMsg);
	}
        public void handleSimpleTag(javax.swing.text.html.HTML.Tag t, javax.swing.text.MutableAttributeSet a, int pos) {
           System.out.println(pos+":"+t);
	}
}
 class ParserGetter extends javax.swing.text.html.HTMLEditorKit {

    //purely to make this methods public
    public javax.swing.text.html.HTMLEditorKit.Parser getParser() {
        return super.getParser();
    }
}

%>

