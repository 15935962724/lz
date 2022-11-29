package tea.html;

import java.util.Enumeration;
import java.util.Vector;


public class Text extends HtmlElement
{

    public void setStrike(boolean flag)
    {
        _blStrike = flag;
    }

    public synchronized String toString()
    {
        StringBuffer sb = new StringBuffer();
        /*  if(super._strId != null || _strFontFace != null || _strFontColor != null || _strClass != null || super._strOnClick != null)
          {
              sb.append("<FONT");
              if(super._strId != null)
                  sb.append(" ID=" + super._strId);
              if(_strFontFace != null)
                  sb.append(" FACE=\"" + _strFontFace + "\"");
              if(_strFontColor != null)
                  sb.append(" COLOR=\"" + _strFontColor + "\"");
              if(_strClass != null)
                  sb.append(" CLASS=\"" + _strClass + "\"");
              if(super._strOnClick != null)
                  sb.append(" onClick=\"" + super._strOnClick + "\"");
              sb.append(">");
          }*/
        if (_blBold)
        {
            sb.append("<b>");
        }
        if (_blItalic)
        {
            sb.append("<i>");
        }
        if (_blStrike)
        {
            sb.append("<strike>");
        }
        if (_blSmall)
        {
            sb.append("<small>");
        }
        if (_strContent != null)
        {
            sb.append(_strContent);
        }
        for (Enumeration enumeration = super._vContents.elements(); enumeration.hasMoreElements(); sb.append(((HtmlElement) enumeration.nextElement()).toString()))
        {
            ;
        }
        if (_blSmall)
        {
            sb.append("</small>");
        }
        if (_blStrike)
        {
            sb.append("</strike>");
        }
        if (_blItalic)
        {
            sb.append("</i>");
        }
        if (_blBold)
        {
            sb.append("</b>");
        }
        // if(super._strId != null || _strFontFace != null || _strFontColor != null || _strClass != null || super._strOnClick != null)
        //     sb.append("</FONT>");
        return sb.toString();
    }

    public Text()
    {
        _strContent = null;
        _blBold = false;
        _blItalic = false;
        _blStrike = false;
        _blSmall = false;
        _strFontColor = null;
        _strFontFace = null;
    }

    public Text(HtmlElement htmlelement)
    {
        super(htmlelement);
        _strContent = null;
        _blBold = false;
        _blItalic = false;
        _blStrike = false;
        _blSmall = false;
        _strFontColor = null;
        _strFontFace = null;
    }

    public Text(String s)
    {
        this();
        _strContent = s;
    }

    public Text(String s, boolean flag)
    {
        this(s);
        setStrike(flag);
    }

    public Text(String s, String s1)
    {
        this(s);
        setFontColor(s1);
    }

    public Text(String s, String s1, String s2)
    {
        this(s);
        setClass(s1);
        setOnClick(s2);
    }

    public Text(String s, String s1, String s2, String s3)
    {
        this(s);
        setClass(s1);
        setId(s2);
        setOnClick(s3);
    }

    public void setBold(boolean flag)
    {
        _blBold = flag;
    }

    public void setSmall(boolean flag)
    {
        _blSmall = flag;
    }

    public void setFontFace(String s)
    {
        _strFontFace = s;
    }

    public void setFontColor(String s)
    {
        _strFontColor = s;
    }

    public void setItalic(boolean flag)
    {
        _blItalic = flag;
    }

    public void setText(String s)
    {
        _strContent = s;
    }

    public void setClass(String s)
    {
        _strClass = s;
    }

    public static int indexOf(String str, String keyword)
    {
        return indexOf(str, keyword, 0);
    }

    public static int indexOf(String str, String keyword, int fromIndex)
    {
        if (str != null)
        {
            int index = str.indexOf(keyword, fromIndex);
            if (index != -1)
            {
                int tagIndex = str.substring(0, index).lastIndexOf("<");
                if (tagIndex != -1)
                {
                    tagIndex = str.substring(tagIndex, index).indexOf(">");
                    if (tagIndex != -1)
                    {
                        return index;
                    } else
                    {
                        return indexOf(str, keyword, index + 1);
                    }
                } else
                {
                    return index;
                }
            }
        }
        return -1;
    }

    public static String replaceAll(String str, String regex, String replacement)
    {
        if (str != null)
        {
            String newStr = new String(str);
            for (int loop = 0; loop < newStr.length(); )
            {
                int index = indexOf(newStr, regex, loop);
                if (index != -1)
                {
                    loop = index + 1 + (replacement.length() - regex.length());
                    newStr = newStr.substring(0, index) + replacement + newStr.substring(index + regex.length());
                } else
                {
                    return newStr;
                }
            }
            return newStr;
        }
        return "";
    }

    public static boolean isCharacter(String str)
    {
        int asc;
        for (int loop = 0; loop < str.length(); loop++)
        {
            asc = (int) str.charAt(loop);
            if (asc > 128 || asc < 0)
            {
                return false;
            }
        }
        return true;
    }

    public static boolean isNumber(String str)
    {
        int asc;
        for (int loop = 0; loop < str.length(); loop++)
        {
            asc = (int) str.charAt(loop);
            if (asc < 48 || asc > 57)
            {
                return false;
            }
        }
        return true;
    }

    public static String toHTML(String s)
    {
        if (s == null)
        {
            return null;
        }
        /*
               String s1 = "";
              boolean flag = false;
            int i = s.length();
                int j = 0;
                do
                {
          if (j >= i)
          {
              flag = true;
              break;
          }
          int k = s.indexOf('\r', j);
          if (k == -1)
          {
              break;
          }
          if (k > j)
          {
              s1 = s1 + s.substring(j, k);
          }
          s1 = s1 + "<br>";
          j = k + 1;
          if (j < i)
          {
              if (j < (i - 1) && s.charAt(j) == '\n')
              {
                  j++;
              }
              for (boolean flag1 = false; !flag1; )
              {
                  if (j < i &&s.charAt(j) == ' ')
                  {
                      s1 = s1 + "&nbsp;"; 
                      j++;
                  } else
                  {
                      flag1 = true;
                  }
              }
          }
                } while (true);
                if (j >= 0 && !flag)
                {
          s1 = s1 + s.substring(j);
                }
                return s1;*/
       return s;//s.replaceAll("   ", " &nbsp; ").replaceAll("\r\n", "<BR>");
    }

    protected String _strContent;
    private boolean _blBold;
    private boolean _blItalic;
    private boolean _blStrike;
    private boolean _blSmall;
    private String _strFontColor;
    private String _strFontFace;
    private String _strClass;
}
