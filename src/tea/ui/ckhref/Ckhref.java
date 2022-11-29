package tea.ui.ckhref;

import java.util.regex.Pattern;

public class Ckhref {
	public static String ckhtmlhref(String html){
		 /** html = Regex.Replace(html, @\"<script[^>]*?>.*?</script>\", \"\", RegexOptions.IgnoreCase);
          html = Regex.Replace(html, @\"<(.[^>]*)>\", \"\", RegexOptions.IgnoreCase);
          html = Regex.Replace(html, @\"([\r\n])[\s]+\", \"\", RegexOptions.IgnoreCase);
          html = Regex.Replace(html, @\"-->\", \"\", RegexOptions.IgnoreCase);
          html = Regex.Replace(html, @\"<!--.*\", \"\", RegexOptions.IgnoreCase);
          html = Regex.Replace(html, @\"&(quot|#34);\", \"\\"\", RegexOptions.IgnoreCase);
          html = Regex.Replace(html, @\"&(amp|#38);\", \"&\", RegexOptions.IgnoreCase);
          html = Regex.Replace(html, @\"&(lt|#60);\", \"<\", RegexOptions.IgnoreCase);
          html = Regex.Replace(html, @\"&(gt|#62);\", \">\", RegexOptions.IgnoreCase);
          html = Regex.Replace(html, @\"&(nbsp|#160);\", \" \", RegexOptions.IgnoreCase);
          html = Regex.Replace(html, @\"&(iexcl|#161);\", \"\xa1\", RegexOptions.IgnoreCase);
          html = Regex.Replace(html, @\"&(cent|#162);\", \"\xa2\", RegexOptions.IgnoreCase);
          html = Regex.Replace(html, @\"&(pound|#163);\", \"\xa3\", RegexOptions.IgnoreCase);
          html = Regex.Replace(html, @\"&(copy|#169);\", \"\xa9\", RegexOptions.IgnoreCase);
          html = Regex.Replace(html, @\"&#(\d+);\", \"\", RegexOptions.IgnoreCase);
          html = Regex.Replace(html, @\"<img[^>]*>;\", \"\", RegexOptions.IgnoreCase);**/
		String [] pas= new String []{"<[^>]+>"};
		Pattern p=null;
		for(int i=0;i<pas.length;i++){
			p=Pattern.compile(pas[i],Pattern.CASE_INSENSITIVE);
			html=p.matcher(html).replaceAll("");
		}
		return html;
	}
	/**public static void main(String[] s){
		String s2="<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\"><html><head>"+
"<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"/>"+
"<title>科学研究 </title>"+
"<meta name=\"keywords\" content=\" 科学研究 \"/>"+
"<meta name=\"description\" content=\"\"/>"+
"<link rel=\"Shortcut Icon\" href=\"/res/Home/favicon.ico\"/>"+
"<script language=\"javascript\" src=\"/tea/load.js\"></script><script language=\"javascript\" src=\"/tea/tea.js\"></script><script language=\"javascript\" src=\"/tea/ym/ymPrompt.js\"></script><script language=\"javascript\" src=\"/tea/mt.js\"></script><script>var lang=1,node={id:3,father:1,community:'Home',type:0,hidden:false,child:[48,49,53,57,878,]};member.id='webmaster';</script><link href=\"/res/Home/cssjs/1L1.css\" rel=\"stylesheet\" type=\"text/css\"/><script language=\"javascript\" src=\"/res/Home/cssjs/1L1.js\"></script>"+
"<link href=\"/res/Home/cssjs/5L1.css\" rel=\"stylesheet\" type=\"text/css\"/><script language=\"javascript\" src=\"/res/Home/cssjs/5L1.js\"></script>"+
"<link href=\"/res/Home/cssjs/8L1.css\" rel=\"stylesheet\" type=\"text/css\"/><script language=\"javascript\" src=\"/res/Home/cssjs/8L1.js\"></script>"+
"</head>"+
"<body><input type='image' style='z-index:100;right:1px;position:fixed;top:14px;' id='editmode' onclick=\"window.open('/servlet/Node?node=3&amp;em=1&amp;edit=ON','_top');\" src='/tea/image/public/icon_edit.gif' accesskey='w'/>&nbsp;<script>if(mt.isIE){var editmode=document.getElementById('editmode').style;editmode.position='absolute';setInterval('editmode.top=document.body.scrollTop+14;',100);}</script><div id=\"Body\"><div id=\"Header\"><div class=\"Header_top\">\";ssssssssss</body>";
//		System.out.println((s2));
		System.out.println("*******"+s2.replaceAll("&nbsp;", ""));
	}**/
}
