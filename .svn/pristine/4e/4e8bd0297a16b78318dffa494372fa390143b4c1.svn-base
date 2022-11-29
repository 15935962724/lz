package tea.htmlx;

import tea.html.*;

// Referenced classes of package tea.htmlx:
//            HtmlX

public class FPNL2 extends HtmlX
{
	public String toString()
	{
		StringBuilder sb = new StringBuilder();
		int sum = _nCount / _nPageSize;
		if(_nCount % _nPageSize != 0)
			sum++;
		sb.append("<!--{total:" + sum + "}-->");
		if(sum < 2)
			return sb.toString();
		if(_strURL.charAt(1) == 'x')
			sb.append("<script>edn.page(" + sum + ")</script>");
		else
		{
			if(_nPos > 1)
			{
				sb.append("<a href='" + _strURL + "' id='CBFirst'>" + getString("CBFirst") + "</a> ");
				sb.append("<a href='" + _strURL.replaceFirst("-1","-" + (_nPos - 1)) + "' id=CBPrev>" + getString("PageUp") + "</a> ");
			}
			int s = _nPos - 5,e = _nPos + 4;
			if(s < 1)
			{
				e = Math.min(e - (s - 1),sum); //前不够，后补
				s = 1;
			}
			if(e > sum)
			{
				s = Math.max(s - (e - sum),1); //后不够，前补
				e = sum;
			}
			for(int i = s;i <= e;i++)
			{
				sb.append(_nPos == i ? "<span class=current>" + i + "</span> " : "<a href='" + _strURL.replaceFirst("-1","-" + i) + "'>" + i + "</a> ");
			}
			if(_nPos < sum)
			{
				sb.append("<a href='" + _strURL.replaceFirst("-1","-" + (_nPos + 1)) + "' id='CBNext'>" + getString("PageDown") + "</a> ");
				sb.append("<a href='" + _strURL.replaceFirst("-1","-" + sum) + "' id='CBLast'>" + getString("CBLast") + "</a> ");
			}
			sb.append("<span id='go'><input size='4' maxlength='4' mask='int' /><input type='button' value='GO' onclick=\"disabled=true;window.open('" + _strURL + "'.replace('-1','-'+Math.min(parseInt(previousSibling.value)||1," + sum + ")),'_self')\"/></span>");
		}
		return sb.toString();
	}

	public FPNL2(int language,String url,int pos,int count)
	{
		super(language);
		_strURL = url;
		_nPos = pos;
		_nCount = count;
		_nPageSize = 25;
	}

	public FPNL2(int i,String url,int pos,int count,int pagesize)
	{
		super(i);
		_strURL = url;
		_nPos = pos;
		_nCount = count;
		_nPageSize = pagesize;
	}

	public void setPage(int i)
	{
		_nPageSize = i;
	}

	public static final int PAGE_SIZE = 25;
	private String _strURL;
	private int _nPos;
	private int _nCount;
	private int _nPageSize;
}
