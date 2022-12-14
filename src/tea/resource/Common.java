package tea.resource;

import java.io.*;
import java.util.*;
import tea.entity.*;

public interface Common
{
    public static String REAL_PATH = Http.REAL_PATH;

    public static final String LANGUAGE[] =
            {"English",//0
			"Simplified",//1
			"Traditional",//2
			"Japanese",//3
			"Korean",//4
			"French","German","Spanish","Portuguese","Italian"};
    public static final String CHATSET[] =
            {"_en","_zh_CN","_zh_TW","_ja_JP","_ko_KR","_fr","_de","_es","_pt","_it"};
//pt-葡萄牙语言，es-西班牙，de德国，fr法国，kokr朝鲜，ja_jp德国日本，zh_tw中国台湾，zh_ch中国，en英国。
    public static final String CURRENCY[] =
            {"US$","RMB","HK$","NT$","EURO","JY","CC"};
//us 美元 $ ，rmb人民币，hk港币，nt ，euro，jy，cc
    // 省市、户口所在地、期望工作地点
    public static final String PROVINCE[] =
            {"000", // 境外"},
            "010", // 北京"},
            "020", // 上海"},
            "030", // 天津"},
            "040", // 内蒙古"},
            "050", // 山西"},
            "060", // 河北"},
            "070", // 辽宁"},
            "080", // 吉林"},
            "090", // 黑龙江"},
            "100", // 江苏"},
            "110", // 安徽"},
            "120", // 山东"},
            "130", // 浙江"},
            "140", // 江西"},
            "150", // 福建"},
            "160", // 湖南"},
            "170", // 湖北"},
            "180", // 河南"},
            "190", // 广东"},
            "200", // 海南"},
            "210", // 广西"},
            "220", // 贵州"},
            "230", // 四川"},
            "240", // 云南"},
            "250", // 陕西"},
            "260", // 甘肃"},
            "270", // 宁夏"},
            "280", // 青海"},
            "290", // 新疆"},
            "300", // 西藏"},
            "320", // 重庆"},
            "330", // 香港"},
            "340", // 澳门"}
    };
    //csv城市编号
    public static final String CSVCITYS[][] =
            {
            {"00","-----------"},
            {"01","北京市"},
            {"02","天津市"},
            {"03","上海市"},
            {"04","重庆省"},
            {"05","内蒙古"},
            {"06","山西省"},
            {"07","河北省"},
            {"08","辽宁省"},
            {"09","安徽省"},
            {"10","山东省"},
            {"11","浙江省"},
            {"12","江西省"},
            {"13","湖南省"},
            {"14","江苏省"},
            {"15","海南省"},
            {"16","青海省"},
            {"17","湖北省"},
            {"18","西藏省"},
            {"19","广西省"},
            {"20","贵州省"},
            {"21","河南省"},
            {"22","福建省"},
            {"23","广东省"},
            {"24","宁夏省"},
            {"25","吉林省"},
            {"26","新疆省"},
            {"27","黑龙江"},
            {"28","四川省"},
            {"29","云南省"},
            {"30","陕西省"},
            {"31","甘肃省"},
            {"32","港,澳,台"}
    };

    //csv城市编号
    public static final String CSVDMCITYS[][] =
            {
            {"00","--"},
            {"01","A"},
            {"02","T"},
            {"03","V"},
            {"04","C"},
            {"05","N"},
            {"06","X"},
            {"07","K"},
            {"08","L"},
            {"09","W",},
            {"10","D"},
            {"11","Z"},
            {"12","I"},
            {"13","P"},
            {"14","F"},
            {"15","V"},
            {"16","B"},
            {"17","P"},
            {"18","B"},
            {"19","G"},
            {"20","Q"},
            {"21","H"},
            {"22","U"},
            {"23","G"},
            {"24","M"},
            {"25","J"},
            {"26","B"},
            {"27","E"},
            {"28","R"},
            {"29","Y"},
            {"30","S"},
            {"31","O"},
            {"32","X"}
    };

    // 个人身份
    public static final String ZZPRIDN[][] =
            {
            {"01","工人"},
            {"02","农民"},
            {"03","学生"},
            {"04","干部"},
            {"05","公务员"},
            {"06","现役军人"},
            {"07","失业者"},
            {"09","其他"}
    };
    // 家庭出身
    public static final String ZZFMBKG[][] =
            {
            {"01","工人"},
            {"02","社员"},
            {"03","农民"},
            {"04","雇农"},
            {"05","贫农"},
            {"06","下中农"},
            {"07","中农"},
            {"08","上中农"},
            {"09","富农"},
            {"10","干部"},
            {"11","革命军人"},
            {"12","革命烈士"},
            {"13","学生"},
            {"14","职员"},
            {"15","城市贫民"},
            {"16","自由职业者"},
            {"17","店员"},
            {"18","小手工业者"},
            {"19","小商贩"},
            {"20","商人"},
            {"21","小业主"},
            {"22","游民"},
            {"23","资本家"},
            {"24","资方代理人"},
            {"25","房屋出租者"},
            {"26","块地出租者"},
            {"27","高利贷者"},
            {"28","地主"},
            {"29","富农"},
            {"30","富农 & 商人"},
            {"31","地主 & 商人"},
            {"32","职员 & 地主"},
            {"33","开明地主"},
            {"34","落魄地主"},
            {"35","无英国人可获得的"},
            {"36","反动富农"},
            {"37","当地恶霸"},
            {"38","恶霸 & 地主"},
            {"39","宗教狂热者"},
            {"40","迷信的人"},
            {"41","旧职员"},
            {"42","旧军官"},
            {"43","旧军人"},
            {"44","旧官吏"},
            {"45","旧警官"},
            {"46","手工业者 OC"},
            {"50","牧民"},
            {"51","畜牧业者"},
            {"52","奴隶"},
            {"53","农奴"},
            {"54","领主"},
            {"55","领主代理人"},
            {"56","牧场主"},
            {"57","牧场主代理人"},
            {"58","部落首领"},
            {"59","部落首领"},
            {"60","无英国人可获得的"},
            {"61","无英国人可获得的"},
            {"99","其他"}
    };

    // 民族号码表
    public static final String ZZRACKY[][] =
            {
            {"AC","阿昌族"},
            {"BA","白族"},
            {"BL","布朗族"},
            {"BN","保安族"},
            {"BY","布依族"},
            {"CS","朝鲜族"},
            {"DA","傣族"},
            {"DE","德族"},
            {"DO","侗族"},
            {"DR","独龙族"},
            {"DU","达翰尔族"},
            {"DX","东乡族"},
            {"EW","鄂温克族"},
            {"GI","京族"},
            {"GL","仡佬族"},
            {"GS","高山族"},
            {"HA","汉族"},
            {"HU","回族"},
            {"HZ","赫哲族"},
            {"JN","基诺族"},
            {"JP","景颇族"},
            {"KG","柯尔克孜族"},
            {"KZ","哈萨克族"},
            {"LB","珞巴族"},
            {"LH","拉祜族"},
            {"LI","黎族"},
            {"LS","傈僳族"},
            {"MA","满族"},
            {"MB","门巴族"},
            {"MG","蒙古族"},
            {"MH","苗族"},
            {"ML","仫佬族"},
            {"MN","毛南族"},
            {"NU","怒族"},
            {"NX","纳西族"},
            {"OR","鄂伦春族"},
            {"PM","普米族"},
            {"QI","羌族"},
            {"RS","俄罗斯族"},
            {"SH","畲族"},
            {"SL","萨拉族"},
            {"SU","水族"},
            {"TA","塔吉克族"},
            {"TJ","土家族"},
            {"TT","塔塔尔族"},
            {"TU","土族"},
            {"UG","维吾尔族"},
            {"UZ","乌孜别克族"},
            {"VA","佤族"},
            {"XB","锡伯族"},
            {"YA","瑶族"},
            {"YG","裕固族"},
            {"YI","彝族"},
            {"ZA","藏族"},
            {"ZH","壮族"}
    };
    // 政治面貌
    public static final String PCODE[][] =
            {
            {"01","中国共产党党员"},
            {"02","中国共产党预备党员"},
            {"03","中国共产主义青年团团员"},
            {"04","成员/中国国民党革命委员会"},
            {"05","中国民主同盟盟员"},
            {"06","成员/中国民主建国会"},
            {"07","成员/中国民主促进会"},
            {"08","党员/中国农工民主党"},
            {"09","中国致公党党员"},
            {"10","九三学社社员"},
            {"11","台湾民主自治同盟盟员"},
            {"12","无党派民主人士"},
            {"13","群众"}
    };
    // 行业代码
    public static final String ZCSZY[][] =
            {
            {"0001","农、林、牧、渔业"},
            {"0002","采掘业"},
            {"0003","制造业"},
            {"0004","电力、煤气及水的生产"},
            {"0005","建筑业"},
            {"0006","地质勘察业、水利管理"},
            {"0007","交通运输、仓储及邮电"},
            {"0008","批发和零售贸易、餐饮"},
            {"0009","金融、保险业"},
            {"0010","房地产业"},
            {"0011","社会服务业"},
            {"0012","卫生、体育和社会福利"},
            {"0013","教育、文化艺术及广播"},
            {"0014","科学研究和综合技服业"},
            {"0015","国家，政党和社会团体"},
            {"0016","其他行业"}
    };
    // http://www.salesforce.com/行业代码
    public static final String SALES_CALLING[] =
            {"--------","农业","服装","银行","生物技术","化学","通讯","建筑","咨询","教育","电子","能源","工程","娱乐","环境","金融","食品与饮料","政府","卫生保健","酒店","保险","机械",
            "制造业","媒体","非盈利事业","其他","休闲娱乐","零售","航运","技术","电信","运输","公用事业"};
    // 现职位级别
    public static final String ZZWJB[][] =
            {
            {"01","高级决策层(CEO, EVP, GM...)"},
            {"02","高级职位(管理类)"},
            {"03","高级职位(非管理类)"},
            {"04","中级职位(两年以上工作经验)"},
            {"05","初级职位(两年以下工作经验)"},
            {"06","学生"}
    };
    //B-picture 工作类型
    public static final String JOBSTYLE[][] =
            {
            {"01","大学教师"},
            {"02","行政主管/经理"},
            {"03","艺术总监"},
            {"04","博客/网络工作者"},
            {"05","企业老板"},
            {"06","设计师"},
            {"07","自由职业者-请填写具体类型："},
            {"08","营销经理"},
            {"09","摄影师"},
            {"10","图片买家"},
            {"11","图片校订者"},
            {"12","图片搜索员"},
            {"13","学生"},
            {"14","教师(小学/中学/高中)"},
            {"00","其他-请填写具体类型："}
    };
    //BP-公司类型
    public static final String COMPANYSTYLE[][] =
            {
            {"01","广告公司"},
            {"02","设计公司"},
            {"03","公关/市场/展览/咨询"},
            {"04","杂志社"},
            {"05","报社"},
            {"06","出版社"},
            {"07","互联网公司"},
            {"08","印刷/包装/喷绘制作公司"},
            {"09","IT、电子和信息技术"},
            {"10","汽车行业"},
            {"11","纺织、服装行业"},
            {"12","医药和生物制品"},
            {"13","食品与饮料行业"},
            {"14","服务业（餐饮、酒店等）"},
            {"15","金融保险"},
            {"16","房地产、建筑行业"},
            {"17","零售行业"},
            {"18","能源（石油、电力、化工）"},
            {"19","交通运输业"},
            {"20","农林牧渔行业"},
            {"21","摄影师"},
            {"22","个人"},
            {"23","其他"}
    };

    public static final String PHOTOYEAR[][] =
            {
            {"01","1-4年"},
            {"02","5-10年"},
            {"03","10年以上"},
            {"04","业余摄影师"}
    };

    public static final String PHMETERIA[][] =
            {
            {"1","风景风光"},
            {"2","城市人文"},
            {"3","乡土人文"},
            {"4","纪实专题"},
            {"5","新闻"},
            {"6","模特肖像(棚拍)"},
            {"7","明星"},
            {"8","财经"},
            {"9","体育"}
    };

    public static final String PHVECTOR[][] =
            {
            {"1","大幅面正片(页片)"},
            {"2","120全景正片(6x12以上)"},
            {"3","120正片"},
            {"4","135正片"},
            {"5","负片"},
            {"6","数码"}
    };


    // 专业工种
    public static final String ZGZ[][] =
            {
            {"01","勘探"},
            {"02","开发"},
            {"03","钻井/采油"},
            {"04","工程"},
            {"05","石油炼化"},
            {"06","综合"},
            {"9A","物探（工）"},
            {"9B","钻井（工）"},
            {"9C","测井（工）"},
            {"9D","海洋采油（工）"},
            {"9E","井下作业（工）"},
            {"9F","化工（工）"},
            {"9G","分析化验（工）"},
            {"9H","海洋工程施工（工）"},
            {"9I","工程施工（工）"},
            {"9J","机械制造（工）"},
            {"9K","机械修理（工）"},
            {"9L","仪器仪表（工）"},
            {"9M","电气（工）"},
            {"9N","供水供热（工）"},
            {"9O","通信（工）"},
            {"9P","交通运输（工）"},
            {"9Q","物资供销（工）"},
            {"9R","健康安全环保（工）"},
            {"9S","技术监督（工）"},
            {"9T","计算机（工）"},
            {"9U","新闻出版（工）"},
            {"9V","后勤服务（工）"},
            {"9X","石油加工（工）"}
    };
    public static final String FAMST_TYPE[] =
            {"未知","单身","已婚","寡居","离异","分居"};
    public static final String CARDT_TYPE[] =
            {"身份证","护照","军官证","士兵证"};
    public static final String[] DEGREE_TYPE = { "高中及以下", "大专", "本科", "研究生及以上" };

    public static final String[] AGE_TYPE = { "", "0-20", "21-25", "26-30", "31-40", "41-50", "51-60", "above60" };

}
