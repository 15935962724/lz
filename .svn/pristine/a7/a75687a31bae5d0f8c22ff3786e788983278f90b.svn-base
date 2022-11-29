<%@page import="tea.db.DbAdapter"%>
<%@page import="tea.resource.Resource"%>
<%@page import="tea.entity.node.Book"%>
<%@page import="tea.entity.MT"%>
<%@page import="tea.entity.Http"%>
<%@page import="tea.entity.node.Node"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script src="/tea/view.js" type="text/javascript"></script>
<script src="/tea/mt.js" type="text/javascript"></script>
<%
	Http h = new Http(request, response);
	int pos = h.getInt("pos", 0);
	int size = h.getInt("size", 10);
	StringBuffer sql = new StringBuffer(), par = new StringBuffer(
			"?1=1");
	sql.append(" AND n.type=12 and hidden=0 AND finished=1");
	int recommended = h.getInt("recommended", 0);
	if(recommended>0){
		sql.append(" and n.recommended=1");
	}
	
	String text = h.get("subject");
	if (text != null && !text.equals("")) {
		sql.append(" AND nl.subject like "
				+ DbAdapter.cite("%" + text + "%"));
		par.append("&subject=" + text);
	}
	String subtitle = h.get("subtitle");
	if (subtitle != null && !subtitle.equals("")) {
		sql.append(" AND bl.subtitle like "
				+ DbAdapter.cite("%" + subtitle + "%"));
		par.append("&subtitle=" + subtitle);
	}
	String content = h.get("content");
	if (content != null && !content.equals("")) {
		sql.append(" AND nl.content like "
				+ DbAdapter.cite("%" + content + "%"));
		par.append("&content=" + content);
	}
	int qualification = h.getInt("qualification");
	if (qualification > 0) {
		sql.append(" AND b.type in(SELECT qualification FROM supqualification WHERE qualification="+qualification+" OR father="+qualification+")");
		par.append("&qualification=" + qualification);
	}
	par.append("&pos=");
	int sum = Node.count(sql.toString());
	if(h.getInt("new")==1){
		sql.append(" AND b.publishdate is not null order by b.publishdate desc,n.time desc");
	}
	else{
		sql.append("order by n.time desc");
	}
	
%>
<%if(size==10){ %>
<form name="form1" action="?" method="post">
	<div class="search">
		<p>
			<span style="line-height: 22px;"><img
				src="/res/jskxcbs/structure/201401071539.png" alt="" />图书搜索</span>
		</p>
		<span class="span1"> 书名:<input type="text" class="text"
			value="" name="subject" /> 作者:<input type="text" class="text"
			value="" name="subtitle" /> 内容:<input type="text" class="text"
			value="" name="content" />
		</span> <input type="submit" class="botton1" value="  " />

	</div>
</form>
</div>
<div class="right_con">

	<div class="right_con01"><%=Node.find(h.node).getSubject(h.language)%>（<font
			color="red"><%=sum%></font>）
	</div>
	<%} %>
	<%
	if(sum<1){
		out.print("<div class='msg'>暂无记录</div>");
	}else{%>
	<%
		Enumeration e = Node.find(sql.toString(), pos, size);
		for (int i = 0; e.hasMoreElements(); i++) {
			int node = ((Integer) e.nextElement()).intValue();
			Node n = Node.find(node);
			Book b = Book.find(node);
			if (b != null) {
				String name = MT.f(n.getSubject(h.language), 16);
				//String url="/html/"+n.getCommunity()+"/book/"+node+"-"+h.language+".htm";
				String url = "/html/jskxcbs/folder/14011316-1.htm?node="
						+ node;
	%>


	<div class="right_con02">
		<div class="left">
			<span id="BookIDbigpicture"><a href="<%=url%>"> <img
					border="0"
					src="<%=b.getSmallPicture(h.language) %>" />
			</a></span>
		</div>
		<div class="center">
		<%if(size==10||size==3){ %>
			<span class="span1">
            	<span id="BookIDsubject">
                	<a href="<%=url%>"><%=n.getSubject(h.language)%></a>
                </span>
            </span>
            <span class="span2">
            	<span>作者:</span>
                <span id="BookIDsubtitle"><%=b.getSubTitle(h.language)%></span>
				<span style="padding-left: 20px;"> 开本:</span><span id="BookIDformat"><%=Book.BOOK_SFC[b.getSpecifications()]%></span>
                <span style="padding-left: 20px;">装订:</span> <span id="BookIDbinding"><%=new Resource().getString(h.language,Book.BOOK_BINDING[b.getBinding()])%></span><br />
				<span>印次:</span> <span id="BookIDpublishdate"><%=MT.f(b.getPublishDate(),2)%><%=MT.f(b.getEdition(h.language))%></span>
				<span style="padding-left: 20px;">字数:</span>
                <span id="BookIDamountword"><%=b.getAmountWord()%></span>
            </span>
				<%}else{%>
					<span class="span1">
                    	<span id="BookIDsubject"><a href="<%=url%>" title="<%=n.getSubject(h.language)%>"><%=MT.f(n.getSubject(h.language),16)%></a></span>
                    </span>
                    <span class="span2"> 
                        <span class="ss">作者:</span>
                        <span id="BookIDsubtitle" title="<%=b.getSubTitle(h.language)%>"><%=MT.f(b.getSubTitle(h.language),10)%></span>
					</span>
				<%} %>
				 <span class="span3">
                     <span>定价:</span>
                     <span id="BookIDprice"><%=MT.f(b.getPrice().doubleValue(),2)%></span>
                 </span>
		</div>
		<%if(size==10){ %>
		<div id="Right">
			<span class="span1"><button type="button" value="加入购物车"
					onClick="car.add(<%=n._nNode%>,1,'<%=request.getRequestURI()%>?qualification=<%=qualification%>')"></button></span>
			<span class="span2"><button type="button" value="在线试读" onClick="mt.zx(<%=b.getDocnode()%>)"></button></span>
		</div>
		<%} %>
	</div>
	<%
		}
		}
		if (sum > size&&size==10)
			out.print("<div class='fy'>"
					+ new tea.htmlx.FPNL(h.language, par.toString(), pos,
							sum, size) + "</div>");
	%>
    <%
	}
	%>
	<script>
	mt.zx=function(a){
		if(a>0){
			location='/html/jskxcbs/files/'+a+'-1.htm';
		}else{
			mt.show("此书目前还没上传在线阅读文档！");
		}
	}
	</script>
	