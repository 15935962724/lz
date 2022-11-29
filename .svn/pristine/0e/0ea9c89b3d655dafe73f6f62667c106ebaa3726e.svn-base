<%@page contentType="text/html;charset=UTF-8" %><%@ page import="tea.db.DbAdapter" %><%@ page import="tea.entity.site.License" %><%@ page  import="tea.resource.Resource" %><%@page import="tea.entity.node.*" %><%@page import="tea.entity.admin.map.*" %><%@ page import="tea.ui.TeaSession" %><%
request.setCharacterEncoding("UTF-8");

TeaSession teasession=new TeaSession(request);


//addpoint1.gif

%><html>
<head>
<script src="/tea/tea.js" type="text/javascript"></script>

<script type="text/JavaScript" src="http://mapd.mapabc.com/mapengin/mapabcrasterengine/api/gmap.jsp"></script>


<script language="JavaScript" src="http://channel.mapabc.com/channel/mapsrv/js/maintool.js"></script>
<script language="JavaScript" src="http://channel.mapabc.com/channel/mapsrv/js/map.js"></script>
<script language="JavaScript" src="http://channel.mapabc.com/channel/mapsrv/js/jslibmx.js"></script>
<script language="JavaScript" src="http://channel.mapabc.com/channel/mapsrv/js/showAdv.js"></script>
<script language="JavaScript" src="http://channel.mapabc.com/channel/mapsrv/js/jslibytiic.js"></script>


<script language="JavaScript">
var cities="北京;010;fjtekqrposNKGE;hrlphplnJOOE;9000;广州;020;fjqekjmjmqFKOE;gllhkllgoJKKE;8000;上海;021;fkoelopplrJOGE;hjlijlnlnNOOI;9000;天津;022;fjuejmmjsJOOE;hrlhhkslnJKGE;7000;重庆市;023;fitemlskmtNOOE;grllmlthrNGOI;7000;南京;025;fjveoqtkrNKKI;hklgomroJKKI;7000;武汉;027;fjrejotlqNOKM;hillmmkgrFOOM;7000;成都;028;firehnpomvJKKI;hilmmpliNKKM;7000;西安;029;fiveqmokkoJKOM;hmlinlthpJGKM;7000;邯郸;0310;fjrelptiFKKM;hollqqoilNGOI;7000;石家庄;0311;fjreloqktqJKGI;hqlglpmnFGKI;7000;保定;0312;fjselnqkssFKGI;hqlooqsmnJKKI;7000;张家口;0313;fjrepptopoFOKI;iilojnmhpJOKI;7000;承德;0314;fjueqkolpsJKOM;iilpqmomqNKOM;7000;唐山;0315;fjveinrjnJKGM;hrlmkmmoJGGI;7000;廊坊;0316;fjteohqjnrJGOI;hrllkhskoNOGM;7000;秦皇岛;0335;fjwemptlqtJKGI;hrlplospoNKGE;7000;大连;0411;fkoenlnpkuNKOI;hqlpjiqjnJGOI;7000;太原;0351;fjpemklkspFKKM;hplommlimJOKM;7000;沈阳;024;fkqelkogooFOGI;ijlohmqnoJGGM;7000;郑州;0371;fjqennngoNKOI;hmlnnismtJGGM;7000;安阳;0372;fjreklqgtuFGOI;holhiimgqJKOM;7000;新乡;0373;fjqepptotNKKI;hnljhipktNOGE;7000;许昌;0374;fjqepkohktNKOM;hmlgjjkopNGOI;7000;平顶山;0375;fjqekhnlppJKOM;hllnjonplNOGM;7000;哈尔滨;0451;fktenmmhsuNOGM;inlnnimnnFKGI;7000;开封;0378;fjreklkiluFOGM;hmlnpqnhJOOE;7000;洛阳;0379;fjpelhklmuNOOM;hmlmmnqolNOGM;7000;焦作;0391;fjqejmtproNKGI;hnlihmrkpNOOI;7000;鞍山;0412;fkqehhmjooNGOI;ijlhimrmNOGE;7000;抚顺;0413;fkqeqjojqoNKOI;ijlonornlFOKM;7000;本溪;0414;fkqeookkrwNOKE;ijliqhqonFGOI;7000;丹东;0415;fkrekqolsNKOI;iilhjolpoJKOM;7000;锦州;0416;fkoeilrmsvFKOI;ijlhjnkpmNGOI;7000;营口;0417;fkpejjmmqtFGKI;iilmnhmnqNKKM;7000;辽阳;0419;fkqeiothnwNOOI;ijlioornsNOKM;7000;盘锦;0427;fkpeholgpNKKM;ijlhipsgsFOOI;7000;葫芦岛;0429;fknepmqilpNOOI;iilnlplhlNOOM;7000;吉林;0432;fktemoljorNGOE;illolmsjrNOGM;7000;延吉;0433;fkwelqrmpsFGOM;ikloqlllmFKKI;7000;四平;0434;fkrepksnmJKGI;illlhponFKKI;7000;齐齐哈尔;0452;fkqeqkrhqvJKOE;ipljliporFKOM;7000;牡丹江;0453;fkwenjqjrpJKKM;imllponiqNKGE;7000;佳木斯;0454;flnekntlsNOOI;iolohoolsNKOE;7000;大庆;0459;fkrepplplpJOOM;iolminmlnNOGM;7000;呼和浩特;0471;fjoennqmpJOKM;iilohpmmmNGOI;7000;包头;0472;fiwepolisrFOGE;iilmniqlFOOM;7000;无锡;0510;fknekhllotJKKI;hjllpimFKOM;7000;镇江;0511;fjwellmkmwFOOM;hkliiikkpFKOI;7000;苏州;0512;fknenksmtNOKI;hjljjhpksNGGM;7000;南通;0513;fknepokknrNOOE;hklgiiqinFOOI;7000;扬州;0514;fjwelimoqsNOGI;hklkiqonoJGKM;7000;盐城;0515;fkneiktilpNOKM;hlljoqnoNOOM;7000;徐州;0516;fjueionppqJKOM;hmlimppntFOKI;7000;连云港;0518;fjweiomonoNKOI;hmllqmspoFKKI;7000;常州;0519;fjweqoopktJOOE;hjlnnqrnJKKI;7000;泰州;0523;fjweqjkoouJOKM;hklkniqmmFOGI;7000;济南;0531;fjuehjkltvNOKE;holmmqnloFOGI;7000;青岛;0532;fknekkolnpJKOM;holgmmplnJOOM;7000;淄博;0533;fjvehmkgrNOOE;holohnnjoFOKM;7000;德州;0534;fjtekhpjluNKOM;hplkloqgmJGKM;7000;烟台;0535;fkoekpsmnsFOOE;hplljothNKKM;7000;潍坊;0536;fjweiilhqrJGKM;holnijnjlNOGI;7000;泰安;0538;fjueiklprwNGOM;holhqkqnnFKKE;7000;东营;0546;fjvenonhtuJKGI;hplkipngoNKOI;7000;合肥;0551;fjuejqpnpsNOOM;hjlonqnkpJOKI;7000;蚌埠;0552;fjuelhlnotNKKI;hklpkhmjqFOOM;7000;芜湖;0553;fjveknsosvNOKM;hjljliphoNGKM;7000;马鞍山;0555;fjvemhmgnqJKGM;hjlmqjtprNKKI;7000;安庆;0556;fjuehmkorsJOOM;hilljokglNKKM;7000;黄山;0559;fjvekhpkmqNKKI;grlnijqgnNGOM;7000;巢湖;0565;fjuepnnppqJKKM;hjlmhjrloJKGI;7000;九华山;0566;fjuelqngqtNOOI;hilmnknilNKOE;7000;杭州;0571;fkneiomprqJGOM;hilioktnqNGKI;7000;湖州;0572;fknehqqpmuJOKM;hiloohpprNKGI;7000;嘉兴;0573;fkneomslooNGKI;hilnmktiJOOI;7000;宁波;0574;fkoemlnptrNOOI;grlonpnjpJKGE;7000;绍兴;0575;fknemqmptoJKGM;hilghkpplJOGM;7000;台州;0576;fkoelmppkrNKKE;gqlmohrprNGKI;7000;温州;0577;fknenkrlluNKOI;gqlgjokhtFOOI;7000;金华;0579;fknehomkmtNKKE;grljhjkjtJOOI;7000;舟山;0580;fkpekhtjppJOKM;grlpmjrjnJOKM;7000;长春;0431;fksekjontqJGKE;illopnsmmJGKM;7000;福州;0591;fjwekhqkkwFOKM;golgonlgoJKGM;7000;厦门;0592;fjveihlpopJOGM;gmlkoqmnpNOKE;7000;宁德岛;0593;fjwemlsomtJOKI;golmmiqFOGM;7000;莆田市;0594;fjwehhpoopFKOI;gnlkkmqltNKKE;7000;泉州;0595;fjvempollsJGOM;gmlpjqpJOOI;7000;漳州市;0596;fjuennppsuNOKE;gmllijnlNKOI;7000;威海;0631;fkpeimpomtFGGE;hpllhhqllNKKI;7000;汕尾岛;0660;fjsekolgtsJGKI;gklnpllpmJKKM;7000;阳江;0662;fjoeqpnmmsFOKI;gjlooitllJKOI;7000;揭阳;0663;fjtekntnsrJOKM;gllljopmlNKKM;7000;茂名;0668;fjneqjonlvNKKE;gjlmnjrjpFGKI;7000;襄樊;0710;fjpeikpiqFGGI;hklgnjkhtNOOI;7000;鄂州;0711;fjreqhnmrwNKGM;hiljpqrppNKOI;7000;黄石;0714;fjsehmnoluFGKI;hiliijnloNKOI;7000;荆州;0716;fjpejlpjqqFKOI;hiljjmmilNOKM;7000;宜昌;0717;fjoejqoopuNOGE;hilnhilnlFKOM;7000;十堰;0719;fjneopmgksNKKE;hklmmmngqNKKM;7000;荆门;0724;fjpeiqqhrvNOOI;hjlgjorklNKGE;7000;岳阳;0730;fjqeihshtuJGOM;grljnnnhqNKOM;7000;长沙;0731;fjqehhtjouNOOM;gqlihpomsNKGM;7000;湘潭;0732;fjpeqilkpoNKOM;gplompqkrJKKM;7000;株洲;0733;fjqeiltkotFOOI;gplolhqkoNOKE;7000;衡阳;0734;fjpenimimuJOKI;goloqnmlJOGM;7000;常德市;0736;fjoeohmmrpFOOM;grlgknqjqJKKM;7000;凤凰城;0743;fiwenhkmmqNGOI;gplplomhsNGKM;7000;张家界;0744;fjneloqptFOKI;grlhiqqnrNOOE;7000;江门;0750;fjpenqllqrNGOE;gkljnhnooNOKE;7000;韶关;0751;fjqemqqoowJGKI;gmlnqmklmJOOM;7000;惠州;0752;fjrekqtmlqJGKM;gllgqksgoJGKM;7000;梅州市;0753;fjteiirlmpJOKI;gmliqksgpFKKI;7000;汕头;0754;fjteojnnnrNGOE;glljnhlgnJKKM;7000;深圳;0755;fjrehmplrqJGOM;gkllljlktNOKI;7000;珠海;0756;fjqempnnsuJOOM;gklinhrkmJGOE;7000;佛山;0757;fjqeiiklnvJOOI;gllgjhrppNGOM;7000;肇庆;0758;fjpelopnmpNGOM;gllgoknoNOOE;7000;湛江;0759;fjneljklrqJGKI;gjlhqpsltNOOM;7000;中山;0760;fjqekolloqNKGI;gklljltptNOKI;7000;潮州;0768;fjtenlmgktNKGI;gllmoingqFOOE;7000;东莞;0769;fjqeomtjooJGGI;gllgkpojsFGOE;7000;防城港;0770;fivekmkpmoFKGI;gjlmjkoisJKOM;7000;南宁市;0771;fivekirgsoJOOM;gklohnmmoJOKM;7000;柳州;0772;fiwelimmkvJKOI;gmljhnrloJOKE;7000;桂林;0773;fjnejpooquFOKI;gnlipjqnnFOKI;7000;北海市;0779;fiweijmprsNOOM;gjlkoprnpJOKM;7000;南昌市;0791;fjsepqrjqsJOKE;gqlmoprlrNOKM;7000;九江;0792;fjseqqkjtsFKOI;grlnimpmqNKGI;7000;景德镇;0798;fjuejiootvNOOE;grliqktoqJKOM;7000;自贡市;0813;fireookioqNOGM;grljmknolFGOI;7000;绵阳;0816;fireoooiqsNOKM;hjlkmmsnqNOGI;7000;泸州;0830;fiselmllqpFOGM;gqlopmkhpNGKE;7000;宜宾;0831;firenjsmttFOOI;gqlnmqmiqJOKM;7000;内江市;0832;fisehnmplvNGOE;grllpjpNGGM;7000;资阳;0832;firenmkmrvFGOM;hilhjppmoJKOM;7000;乐山;0833;fiqeolqjrqNGKM;grllpnqhoNOOM;7000;眉山;0833;fiqepjqhqrJKGM;hilgkpslpNGKM;7000;贵阳;0851;fiteohsmluJGOI;gollnotlpFOKI;7000;昆明;0871;fipeohnjJKGI;gnlglqspnJOGM;7000;玉溪;0877;fipemkppmtFGKM;gmljlollqJOKM;7000;海口;0898;fjnekjkhtvJKKM;gilgkjngnNKGM;7000;三亚;0899;fiweminmlsNKOI;fqlikmphrJOKI;7000;咸阳;0910;fiveohtosNOKM;hmljjnropJKOI;7000;延安;0911;fiwelqqlNKOM;hollqkniNOKM;7000;宝鸡;0917;fiueiksospFGOM;hmljnqsglJOGM;7000";
var citycode="010";

function MM_showHideLayers() { //v6.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}

</script>
</head>
<BODY>



<form action="/jsp/admin/map/MapSearchResult.jsp" target="MapSearchResult">
<input type="hidden" name="area" value=""/>
<input name="q" value="" /><input type="submit" value="GO" />
</form>

<iframe name="MapSearchResult" src="about:blank"></iframe>
















<%--
<script language="JavaScript" src="http://channel.mapabc.com/channel/citylist.js">
document.all.item("citylist").value = citycode;
</script>
--%>
<SELECT style="display:none" id=citylist onchange=javascrip:selectCity(); name=citylist><OPTION value="" selected>请选择城市名</OPTION><OPTION value=010>　北京</OPTION><OPTION value=021>　上海</OPTION><OPTION value=020>　广州</OPTION><OPTION value=022>　天津</OPTION><OPTION value=023>　重庆</OPTION><OPTION value="">广东省：</OPTION><OPTION value=0755>　├深圳</OPTION><OPTION value=0769>　├东莞</OPTION><OPTION value=0760>　├中山</OPTION><OPTION value=0757>　├佛山</OPTION><OPTION value=0754>　├汕头</OPTION><OPTION value=0759>　├湛江</OPTION><OPTION value=0756>　├珠海</OPTION><OPTION value=0752>　├惠州</OPTION><OPTION value=0750>　├江门</OPTION><OPTION value=0768>　├潮州</OPTION><OPTION value="">黑龙江省：</OPTION><OPTION value=0451>　├哈尔滨</OPTION><OPTION value=0454>　├佳木斯</OPTION><OPTION value=0459>　├大庆</OPTION><OPTION value=0452>　├齐齐哈尔</OPTION><OPTION value="">河北省：</OPTION><OPTION value=0311>　├石家庄</OPTION><OPTION value=0312>　├保定</OPTION><OPTION value=0315>　├唐山</OPTION><OPTION value=0314>　├承德</OPTION><OPTION value=0316>　├廊坊</OPTION><OPTION value=0335>　├秦皇岛</OPTION><OPTION value=0310>　├邯郸</OPTION><OPTION value="">江苏省：</OPTION><OPTION value=025>　├南京</OPTION><OPTION value=0519>　├常州</OPTION><OPTION value=0516>　├徐州</OPTION><OPTION value=0514>　├扬州</OPTION><OPTION value=0510>　├无锡</OPTION><OPTION value=0512>　├苏州</OPTION><OPTION value=0518>　├连云港</OPTION><OPTION value=0511>　├镇江</OPTION><OPTION value=0523>　├泰州</OPTION><OPTION value="">广西省：</OPTION><OPTION value=0771>　├南宁</OPTION><OPTION value="">福建省：</OPTION><OPTION value=0591>　├福州</OPTION><OPTION value=0592>　├厦门</OPTION><OPTION value=0595>　├泉州</OPTION><OPTION value="">江西省：</OPTION><OPTION value=0791>　├南昌</OPTION><OPTION value="">河南省：</OPTION><OPTION value=0371>　├郑州</OPTION><OPTION value=0378>　├开封</OPTION><OPTION value=0379>　├洛阳</OPTION><OPTION value=0374>　├许昌</OPTION><OPTION value=0375>　├平顶山</OPTION><OPTION value="">山西省：</OPTION><OPTION value=0351>　├太原</OPTION><OPTION value="">贵州省：</OPTION><OPTION value=0851>　├贵阳</OPTION><OPTION value="">山东省：</OPTION><OPTION value=0531>　├济南</OPTION><OPTION value=0631>　├威海</OPTION><OPTION value=0538>　├泰安</OPTION><OPTION value=0533>　├淄博</OPTION><OPTION value=0536>　├潍坊</OPTION><OPTION value=0535>　├烟台</OPTION><OPTION value=0532>　├青岛</OPTION><OPTION value="">海南省：</OPTION><OPTION value=0898>　├海口</OPTION><OPTION value=0899>　├三亚</OPTION><OPTION value="">四川省：</OPTION><OPTION value=028>　├成都</OPTION><OPTION value=0816>　├绵阳</OPTION><OPTION value=0832>　├资阳</OPTION><OPTION value="">安徽省：</OPTION><OPTION value=0551>　├合肥</OPTION><OPTION value="">吉林省：</OPTION><OPTION value=0432>　├吉林</OPTION><OPTION value=0431>　├长春</OPTION><OPTION value=0434>　├四平</OPTION><OPTION value=0433>　├延吉</OPTION><OPTION value="">内蒙古：</OPTION><OPTION value=0471>　├呼和浩特</OPTION><OPTION value="">浙江省：</OPTION><OPTION value=0571>　├杭州</OPTION><OPTION value=0573>　├嘉兴</OPTION><OPTION value=0574>　├宁波</OPTION><OPTION value=0577>　├温州</OPTION><OPTION value=0575>　├绍兴</OPTION><OPTION value=0580>　├舟山</OPTION><OPTION value="">辽宁省：</OPTION><OPTION value=0411>　├大连</OPTION><OPTION value=0413>　├抚顺</OPTION><OPTION value=024>　├沈阳</OPTION><OPTION value=0417>　├营口</OPTION><OPTION value=0415>　├丹东</OPTION><OPTION value=0416>　├锦州</OPTION><OPTION value=0412>　├鞍山</OPTION><OPTION value="">云南省：</OPTION><OPTION value=0871>　├昆明</OPTION><OPTION value=0877>　├玉溪</OPTION><OPTION value="">湖北省：</OPTION><OPTION value=027>　├武汉</OPTION><OPTION value=0711>　├鄂州</OPTION><OPTION value=0714>　├黄石</OPTION><OPTION value="">湖南省：</OPTION><OPTION value=0731>　├长沙</OPTION><OPTION value=0732>　├湘潭</OPTION><OPTION value=0730>　├岳阳</OPTION><OPTION value="">陕西省：</OPTION><OPTION value=029>　├西安</OPTION></SELECT>



<div id="cc" style="border:1px solid gray;margin:0px 5px 0 0px;float:left;padding:0;width:500;height:400;">
<!---2.5大地图 并初始化-->
<script language="JavaScript" type="text/JavaScript">

var ccity = "010";

var centx="";
var centy="";
if (ccity!= null || ccity!=""){

document.all.item("citylist").value = ccity;
    var selName = document.all.item("citylist").value;
	var sel = document.all.item("citylist").selectedIndex;
        var x="";
		var y="";
		var curname="北京";
			if(selName==""){
			  alert("请选择城市!!");
			}

		if(sel>0&&selName!=""){

			var arrcities = cities.split(';');
			var arrl = arrcities.length;
			for(var ii=0;ii<arrl;ii++){

			  if(selName==arrcities[ii]){

				curname=arrcities[ii-1];
				x=arrcities[ii+1];
				y=arrcities[ii+2];
			  }

			}
			centx = x;
			centy = y;
		}
}


var showsmallmap = "false";
var callbackURL ="http://channel.mapabc.com/channel/mapsrv/getmapcallback.jsp";
var mapInitPara1 = new MMapOptions(); //大地图 参数对象
var newmapwin_Timer;

      mapInitPara1.viewAdjustType="zoom";
      mapInitPara1.mapZoom=8;
	  mapInitPara1.mapWidth="550";
	  mapInitPara1.mapHeight="458";
	  mapInitPara1.mapWinId	="mapobj"; //onMappletInited(mapname)等方法 里的mapname参数
	  if(centx!="" && centx!="null" && centx!=null){

		  mapInitPara1.centerCoord=  centx+","+centy;

	  }

      mapInitPara1.callbackURL = callbackURL;     //----------------------------------------上传到服务器需要修改路径
	  //mapInitPara1.buspostURL = "http://192.168.5.153:8080/mc/023com/getbuspost.jsp"

function NewMapWin(mapinit_p){
	var map_obj;
		if(newmapwin_Timer!=null){
		  clearTimeout(newmapwin_Timer);
		 }
		if(mapinit_p!=null && mapinit_p!="" && mapinit_p!="null" && mapinit_p!="undefined"){
			try{
			map_obj = new MMap (mapinit_p);
			return map_obj;
			}
			catch(e){
			newmapwin_Timer = setTimeout(function (){NewMapWin(mapinit_p);},100);
			}
	   }
}


var mapobj = new NewMapWin(mapInitPara1);


var twoMapAllInited=0;



function onMappletInited(mapname){

		twoMapAllInited++;

		if(showsmallmap=="true"){
		mapobj.bindMapObj("mapObj2","move");
		mapobj.bindMapObj("mapObj2","zoom","3");
		mapObj2.bindMapObj("mapobj","move");
		mapObj2.bindMapObj("mapobj","zoom","-3");
		document.getElementById('arrow').innerHTML='<img src="images/arrow1.gif" width="17" height="17" onclick="jClose()"/>';
		}
        mapobj.setAnimate("false","false");
	    mapobj.setRightClickAction(false);

        var pointlable1 = new LabelStyle();
		pointlable1.xOffset =0;
		pointlable1.yOffset =0;
		pointlable1.backgroundColor ="NAN";
		pointlable1.fontColor ="#ff0000";
		pointlable1.fontOutlineColor ="#ffff00";

	//////// 设置点的样式 ////////////////////
		var onePointStyle1 = new PointStyle();
		onePointStyle1.labelStyle=pointlable1;
		onePointStyle1.accuracy=9;
		onePointStyle1.showLabel=true;
		onePointStyle1.pointType="API_Coord";
		onePointStyle1.labelContent ="" ;
	    onePointStyle1.iconoffset_left=-10;
        onePointStyle1.iconoffset_top=-23;

        onePointStyle1.showtip=false;

		mapobj.setMouseDrawPointStyle(onePointStyle1,true); //设置右键标点的点样式
		mapobj.setRightClickAction(true); //设置右键为标点





		if(twoMapAllInited!=0){
			mapobj.submit();
			if(showsmallmap=="true"){
			setTimeout("mapObj2.submit()",1000);
			}
		}
	  }

//展开窗口


function makeLarge(divNode)
{
      var width   = parseInt(divNode.style.width);
      var height  = parseInt(divNode.style.height);
      divNode.style.width   = 2*width   +"px";
      divNode.style.height  = 2*height  +"px";
}
function jOpen()
{
		var divNode = document.getElementById('smallmapwin');
		var time = 0;
		var interval = setInterval(function(){

		if(time!=3)
		{
		divNode.style.display="";
		makeLarge(divNode);
		time++;
		}else
		{
		time = 0;
		clearInterval(interval);
		}
		},20);
		var arrow=document.getElementById('arrow');
		arrow.innerHTML='<img src="images/arrow1.gif" width="17" height="17" onclick="jClose()"/>';
}

//折叠窗口
function makeSmall(divNode){
var width = parseInt(divNode.style.width);
var height = parseInt(divNode.style.height);
divNode.style.width = parseInt(width/2) +"px";
divNode.style.height = parseInt(height/2) +"px";
}


function jClose(){
var divNode = document.getElementById('smallmapwin');
var time = 0;
var interval = setInterval(
  function(){

	if(time!=3){
		makeSmall(divNode);
		time++;
	}
	else{
		time = 0;
		clearInterval(interval);
	}
	if(time==2){
		divNode.style.display="none";
	}
 },20);
		var arrow=document.getElementById('arrow');
	    arrow.innerHTML='<img src="images/arrow2.gif"  width="17" height="17" onclick="jOpen()"/>';
}


//加点方法

function addpion(x,y,index,iconURL,comname,addr,tel,url,tip){
	//alert("start");
var labelStyleObj = new LabelStyle(); //创建点的label样式对象
var onePointObj	= new PointObject();  //创建点对象
var tipParaObj1 = new TipParam();     //创建点的tip参数对象
var aTipStyle1 = new TipStyle();      //创建点的tip样式对象

//-------新增 2007-01-12
var ntip ="true";
if(tip!=null){
   ntip =tip;
}
//-------新增


	aTipStyle1.tipID = index;
	aTipStyle1.tipWidth = 200;
	aTipStyle1.tipTemplate =  "<table width=100%><tr><td><span style=font-size:11><tipcont>fieldOne</tipcont></span></td></tr><tr><td><span style=font-size:11><tipcont>fieldTwo</tipcont></span></td></tr><tr><td><span style=font-size:11><tipcont>field3</tipcont></span></td></tr><tr><td><span style=font-size:11><tipcont>field4</tipcont></span></td></tr><tr style='font-size:11px'><td align=left valign=top><a href=\\\"http://www.mapabc.com/vote/start_dm1.html?rf=021 \\\" target=\\\"_blank\\\"><img id=\\\"img\\\" style=\\\"cursor:pointer\\\" src=\\\"http://channel.mapabc.com/openmap/666.gif\\\" border=\\\"0\\\" onmousemove=\\\"document.all.item('img').src='http://channel.mapabc.com/openmap/55.gif'\\\" onmouseout=\\\"document.all.item('img').src='http://channel.mapabc.com/openmap/666.gif'\\\"/></a></td></tr></table>";

	   if(addr==" " || addr==""){
		  addr="暂无信息";
		  }
       if(tel==" " || tel==""){
		  tel="暂无信息";
		  }

	   if(url==" " || url==""){
		  url = "没有网站信息";
		  }

    tipParaObj1.fieldOne = "名称： "+comname;
	tipParaObj1.fieldTwo = "地址： "+addr;
	tipParaObj1.field3 =   "电话： "+tel;
	tipParaObj1.field4 =   "网站： "+url;


	/* 设置 Tip的样式*/
    tipParaObj1.tipID = index;
	labelStyleObj.backgroundColor = 'NAN';


	onePointObj.serialid = index;  //设置每个点的ID
	onePointObj.coord = x+","+y;

	/* 创建点的样式对象，并进行设置*/
	onePointObj.pointStyle	= new PointStyle();
	onePointObj.pointStyle.pointType = 'API_Coord';
	onePointObj.pointStyle.labelContent = 'create Point';//showLabel = true;时显示
	onePointObj.pointStyle.labelStyle = labelStyleObj;
	onePointObj.pointStyle.iconoffset_left = -12;
	onePointObj.pointStyle.iconoffset_top = -10;
	onePointObj.pointStyle.showtip = ntip;
	onePointObj.pointStyle.maxdisscroll = 14;
	onePointObj.pointStyle.iconURL = iconURL;

	onePointObj.pointStyle.tipID = index;
	onePointObj.pointStyle.tipParam = tipParaObj1;

    //**************添加创建的tip样式对象***********************************/
    mapobj.addTipStyle(aTipStyle1);

	mapobj.addPoint(onePointObj);
}


//添加线方法
function addLine(xarr,yarr,seid){

//-------新增 2007-01-12
var serid = "one";
serid = seid;
//-------新增

/**************创建线的label对象，并对label的样式进行设置 *******************
var polyLableOne = new LabelStyle();
polyLableOne.fontSize= "20"; // 数值型，标注显示的字体大小
polyLableOne.isBold = false; // 布尔型，标注文字是否显示为粗体
polyLableOne.isBorder = false; // 布尔型，标注是否有边框
polyLableOne.fontColor = "#1F1F1F"; // 字符串型，标注文字的颜色
polyLableOne.backgroundColor = "NAN"; // 字符串型标注文字的颜色
polyLableOne.fontOutlineColor = "NAN"; // 字符串型，标注文字轮廓颜色
polyLableOne.positionNum=1; // 数值型,标注的位置类型
polyLableOne.xOffset = 20; // 数值型，在指定的位置类型确定的基准位置基础上的x方向偏移量
polyLableOne.yOffset = 5; // 数值型，在指定的位置类型确定的基准位置基础上的y方向偏移量
***/

/************创建线样式对象并设置线的样式 ***************/
var polySytleOne = new GraphyStyle();
polySytleOne.graphyType="polyline"; // polyline，polygon，rectangle; ellipse，circle
//polySytleOne.labelContent = "北京图盟科技---mapabc"; // 字符串型，标注要显示的文字
polySytleOne.lineColor="#FF1817"; // 字符串型,线颜色或面的边框线颜色
polySytleOne.lineOpacity="0.65"; // 字符串型，0-1之间一小数，线透明度或面的边框线透明度
polySytleOne.lineWeight=6; // 数值型，线宽度或面的边框线宽度
polySytleOne.lineDashStyle="dashStyle"; // 字符串型表示线形为怎样的虚线
polySytleOne.isLabel= false; // 布尔型，true表示有标注，false表示没有标注
//polySytleOne.labelStyle = polyLableOne; // 引用labelstyle对象。
//polySytleOne.surfaceStyle= surfaceStyleOne ; // 引用面填充样式对象。只有在画面，画框的时候有效
polySytleOne.showtip = true; // 点击是否弹出TIP窗口
polySytleOne.tipPosition = "0"; // 字符串型，tip的显示位置

var polyObjOne = new PolyObject();
polyObjOne.serialid= serid; // id
polyObjOne.coordX=xarr ; // x坐标
polyObjOne.coordY=yarr ; // y坐标
polyObjOne.polyStyle= polySytleOne;
mapobj.addPoly(polyObjOne);
}

//----------------------------------------------------------地图邮件需要文件--------------------------------------------//
function setMouseDrawPointStyle(lable){
	var slable = "点";
		slable = lable;
	var pointlable1 = new LabelStyle();
		pointlable1.xOffset =0;
		pointlable1.yOffset =0;
		pointlable1.backgroundColor ="NAN";
		pointlable1.fontColor ="#ff0000";
		pointlable1.fontOutlineColor ="#ffff00";

	//////// 设置点的样式 ////////////////////
		var onePointStyle1 = new PointStyle();
		onePointStyle1.labelStyle=pointlable1;
		onePointStyle1.accuracy=9;
		onePointStyle1.showLabel=true;
		onePointStyle1.pointType="API_Coord";
		onePointStyle1.labelContent =slable ;
	    onePointStyle1.iconoffset_left=-15;
        onePointStyle1.iconoffset_top=-43;

        onePointStyle1.showtip=false;
		//onePointStyle1.isSimple = false; //画单点或多点（鼠标右键标点时有效）    false 为单点即 点N次右键只能显示最后一个标点

		mapobj.setMouseDrawPointStyle(onePointStyle1,true); //设置右键标点的点样式
		mapobj.setRightClickAction(true); //设置右键为标点
}

var bitMapURL="";
var ID = "";
var MZoomV="";

function onGetMapZoom(mapName,mapZoomValue){
	MZoomV = mapZoomValue;
}

function onGetBitMapURL(mapname,bitmapurl){
	bitMapURL = bitmapurl;
}




function onClickByRightButton (mapname,id,x,y){
	ID = id ;
	//getBitMapURL1();
}

function mapRemoveAll(){
	mapobj.removeAllPoint();
	mapobj.submit();
	ID = "";
}

function getBitMapURL1(){
	mapobj.getMapZoom();
	mapobj.getBitMapURL("jpg","auto","auto",255);
	mapobj.submit();
}

//----------------------------------------------------------地图邮件需要文件--------------------------------------------//

</script>


</div>
<%--
<input type="button" value="HTML" onClick="html.value=''; html.value=document.body.innerHTML;">
<textarea name="html" cols="50" rows="5"></textarea>
--%>
</BODY>
</html>

