<%@page import="tea.db.DbAdapter"%></span>
<%@page import="tea.entity.node.Node"%></span>
<%@page import="tea.entity.node.Specimen"%></span>
<%@page import="tea.entity.node.Animal"%></span>
<%@page import="tea.entity.node.Infrared"%></span>
<%@page import="tea.entity.node.Reserve"%></span>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%></span>
<div class="con">
<div class="platformSource" style="display:inline;">
    <div class="title"><a href="/xhtml/papc/folder/2-1.htm">平台资源</a></div>
    <div class="img"><img src="/res/papc/structure/2.jpg"/>
        <div class="announcement"><a href="/xhtml/papc/folder/2-1.htm">月增量<span id="month_2">--</span>条</a></div>
    </div>
    
    <div class="sonColumn">
        <ul>
            <li><a href="/xhtml/papc/folder/13100752-1.htm">保护区名录</a><span id="num"><%=Reserve.count(" and node IN (SELECT node FROM node WHERE hidden = 0)") %></span></li>
            <li><a href="/xhtml/papc/folder/13100951-1.htm">红外相机数据库</a><span id="num"><%=Infrared.count(" and pstime IS NOT NULL AND wzname!=''") %></span></li>
            <li><a href="/xhtml/papc/folder/13113661-1.htm">物种名录</a><span id="num"><%=Animal.count("") %></span></li>
            <li><a href="/xhtml/papc/folder/21-1.htm">标本库</a><span id="num"><%=Specimen.count("") %></span></li>
            <!--li><a href="/xhtml/papc/folder/946895-1.htm">地理信息库</a></li-->
            <li><a href="/xhtml/papc/category/13113988-1.htm">物种图库</a><span id="num"><%=Node.count(" and (father=13110233 or father =13115002) and hidden=0") %></span></li>
            <li><a href="/xhtml/papc/folder/13113591-1.htm">保护区物种库</a><span id="num"><%=DbAdapter.execute("select count(1) from rplant where rname is not null and  reserve in (select node from reserve)")+DbAdapter.execute("select count(1) from ranimal where rname is not null and  reserve in (select node from reserve)") %></span></li>
            <li><a href="/xhtml/papc/category/49-1.htm">文献资料库</a><span id="num"><%=Node.count(" and (father=49) and hidden=0") %></span></li>
        </ul>
    </div>
</div>

<div class="platformSource">
    <div class="title"><a href="/xhtml/papc/folder/3-1.htm">保护管理</a></div>
    <div class="img"><img src="/res/papc/structure/110.jpg"/>
        <div class="announcement"><a href="/xhtml/papc/folder/3-1.htm">月增量<span id="month_3">--</span>条</a></div>
    </div>
    <div class="sonColumn">
        <ul>
            <li><a href="/xhtml/papc/category/946896-1.htm">社区共管</a><span id="num"><%=Node.count(" and (father=946896) and hidden=0") %></span></li>
            <li><a href="/xhtml/papc/category/946897-1.htm">政策法规</a><span id="num"><%=Node.count(" and (father=946897) and hidden=0") %></span></li>
            <li><a href="/xhtml/papc/category/946898-1.htm">巡护执法</a><span id="num"><%=Node.count(" and (father=946898) and hidden=0") %></span></li>
            <li><a href="/xhtml/papc/category/946899-1.htm">培训课件</a><span id="num"><%=Node.count(" and (father=946899) and hidden=0") %></span></li>
            <li><a href="/xhtml/papc/category/946900-1.htm">科研监测</a><span id="num"><%=Node.count(" and (father=946900) and hidden=0") %></span></li>
            <li><a href="/xhtml/papc/category/946901-1.htm">数字化保护区</a><span id="num"><%=Node.count(" and (father=946901) and hidden=0") %></span></li>
        </ul>
    </div>
</div>

<div class="platformSource">
    <div class="title"><a href="/xhtml/papc/folder/13-1.htm">科普专题</a></div>
    <div class="img"><img src="/res/papc/structure/330.jpg"/>
        <div class="announcement"><a href="/xhtml/papc/folder/13-1.htm">月增量<span id="month_13">--</span>条</a></div>
    </div>

    <div class="sonColumn">
        <ul>
            <li><a href="/xhtml/papc/category/56-1.htm">保护区介绍</a><span id="num"><%=Node.count(" and (father=56) and hidden=0") %></span></li>
            <li><a href="/xhtml/papc/category/57-1.htm">保护区旅游</a><span id="num"><%=Node.count(" and (father=57) and hidden=0") %></span></li>
            <li><a href="/xhtml/papc/category/58-1.htm">保护区影像</a><span id="num"><%=Node.count(" and (father=58) and hidden=0") %></span></li>
            <li><a href="/xhtml/papc/category/59-1.htm">物种介绍</a><span id="num"><%=Node.count(" and (father=59) and hidden=0") %></span></li>
            <li><a href="/xhtml/papc/folder/1849082-1.htm">智能服务终端</a><span id="num"><%=Node.count(" and (father=1849082) and hidden=0") %></span></li>
            <li><a href="/xhtml/papc/folder/1860772-1.htm">热点专题</a><span id="num"><%=Node.count(" and (father=1860772) and hidden=0") %></span></li>
        </ul>
    </div>
</div>
<script>mt.script('/Nodes.do?act=month&nodes=2&nodes=3&nodes=13')</script>

</div>