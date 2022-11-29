package tea.ui.util;

import org.apache.commons.lang.StringUtils;

import java.io.File;
import java.util.Map;

public class FreeMarkerUtils {
	/**
     * 根据模版名称和实际数据解析生成html文本
     * @param filePath 模版文件完整路径
     * @param data 数据
     * @return html文本
     */
    public static String parseText(String filePath, Map data) {

        if (StringUtils.isEmpty(filePath)) {
            return "<font color='#F00'>Template not found.</font>";
        }

        File file = new File(filePath);

        FreeMarkerTransfer trans = new FreeMarkerTransfer(file.getParent());
        trans.setParams(data);
        return trans.write2Str(file.getName());
    }
}
