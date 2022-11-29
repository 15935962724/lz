package tea.ui.util;

import freemarker.cache.StringTemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;

import java.io.File;
import java.io.StringWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 执行指定的freemarker模板，并返回html结果。
 */
public class FreeMarkerTransfer {
    
    private static final Map<String, Configuration> CONFIG_MAP = new ConcurrentHashMap<String, Configuration>();
    
    /**
     * 需要传递给FreeMarker的参数
     */
    private Map<Object, Object> params = new HashMap<Object, Object>();
    
    /**
     * freemarker模板所在的目录
     */
    private String templateDir = "";
    
    /**
     * @param tmplDir 模板文件的路径
     */
    public FreeMarkerTransfer(String tmplDir) {
        templateDir = tmplDir;
    }
    
    /**
     * 增加需要传递给模板的变量，这些变量可以直接在模板中调用
     * 
     * @param name 变量的名称。
     * @param var 变量对应的对象。
     */
    public void addVariable(String name , Object var) {
        params.put(name, var);
    }
    
    /**
     * 将freemarker文件的执行结果输出到writer对象中
     * 
     * @param writer 输出
     * @param template freemarker文件
     */
    public void write(Writer writer , String template) {
        try {
            getConfig(templateDir).getTemplate(template).process(params, writer);
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage(), e);
        }
    }
    
    /**
     * 将freemarker文件的执行结果输出成
     * 
     * @param template 模板名称
     * @return freemarker文件的执行结果
     */
    public String write2Str(String template) {
        StringWriter writer = new StringWriter();
        this.write(writer, template);
        return writer.toString();
    }
    
    /**
     * 设置传递给FreeMarker的参数。
     * 
     * @param bean 传递给FreeMarker的参数
     */
    public void setParams(Map<Object, Object> bean) {
        this.params = bean;
    }
    
    /**
     * 根据指定目录从缓存中取得Configuration对象，如果缓存中不存在，则重新创建。
     * 
     * @param tmplDir ftl模板所在的路径（先对于操作系统的绝对路径）。
     * @return 取得FreeMarker的配置文件
     * @throws Exception 构造config对象时产生的错误
     */
    private static Configuration getConfig(String tmplDir) throws Exception {
        Configuration config = CONFIG_MAP.get(tmplDir);
        if (config != null) {
            return config;
        }
        
        config = new Configuration();
        config.setObjectWrapper(new DefaultObjectWrapper());
        config.setDirectoryForTemplateLoading(new File(tmplDir));
//        config.setEncoding(Locale.CHINA, "UTF-8");
        config.setDefaultEncoding("UTF-8");
        CONFIG_MAP.put(tmplDir, config);
        
        return config;
    }

    /**
     * 根据模板内容和实际数据解析生成html文本
     * @param ftlContent 模板内容
     * @param data 数据
     * @return html文本
     */
    public static String getHtmlFromTmplString(String ftlContent, Map data) {
        if(!ftlContent.contains("<html xmlns:v='urn:schemas-microsoft-com") && !ftlContent.contains("<?xml")){
            StringBuffer head = new StringBuffer(
                    "<html xmlns:v='urn:schemas-microsoft-com:vml'xmlns:o='urn:schemas-microsoft-com:office:office'xmlns:w='urn:schemas-microsoft-com:office:word'xmlns:m='http://schemas.microsoft.com/office/2004/12/omml'xmlns='http://www.w3.org/TR/REC-html40'  xmlns='http://www.w3.org/1999/xhtml' > ");
            head.append("<head>");
            head.append(" <!--[if gte mso 9]><xml><w:WordDocument><w:View>Print</w:View><w:TrackMoves>false</w:TrackMoves><w:TrackFormatting/><w:ValidateAgainstSchemas/><w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid><w:IgnoreMixedContent>false</w:IgnoreMixedContent><w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText><w:DoNotPromoteQF/><w:LidThemeOther>EN-US</w:LidThemeOther><w:LidThemeAsian>ZH-CN</w:LidThemeAsian><w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript><w:Compatibility><w:BreakWrappedTables/><w:SnapToGridInCell/><w:WrapTextWithPunct/><w:UseAsianBreakRules/><w:DontGrowAutofit/><w:SplitPgBreakAndParaMark/><w:DontVertAlignCellWithSp/><w:DontBreakConstrainedForcedTables/><w:DontVertAlignInTxbx/><w:Word11KerningPairs/><w:CachedColBalance/><w:UseFELayout/></w:Compatibility><w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel><m:mathPr><m:mathFont m:val='Cambria Math'/><m:brkBin m:val='before'/><m:brkBinSub m:val='--'/><m:smallFrac m:val='off'/><m:dispDef/><m:lMargin m:val='0'/> <m:rMargin m:val='0'/><m:defJc m:val='centerGroup'/><m:wrapIndent m:val='1440'/><m:intLim m:val='subSup'/><m:naryLim m:val='undOvr'/></m:mathPr></w:WordDocument></xml><![endif]-->");
            head.append("<meta charset='UTF-8'>");
            head.append("<meta name=ProgId content=Word.Document>");
            head.append("<meta name=Generator content='Microsoft Word 14'>");
            head.append("<meta name=Originator content='Microsoft Word 14'>");
            head.append("</head>");
            head.append("<body style='tab-interval: 21pt; text-justify-trim: punctuation;'>");
            ftlContent = head.toString() + ftlContent + "</body></html>";
        }
        // 设置一个字符串模板加载器
        StringTemplateLoader stringLoader = new StringTemplateLoader();
        Configuration STRING_CONFIG = new Configuration();
        STRING_CONFIG.setDefaultEncoding("UTF-8");
        STRING_CONFIG.setTemplateLoader(stringLoader);
        stringLoader.putTemplate("", ftlContent);
        StringWriter writer = new StringWriter();
        try {
            // 获取匿名模板
            STRING_CONFIG.getTemplate("").process(data, writer);
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage(), e);
        }
        return writer.toString();
    }

}
