package tea.ui.yl.shop;

import com.google.common.collect.Lists;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFClientAnchor;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import tea.entity.Http;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.*;

/**
 * 导出Excel文件（导出“XLSX”格式，支持大数据量导出   @see org.apache.poi.ss.SpreadsheetVersion）
 * @author guodh
 * @version 2016-04-26
 */
public class ExportExcel {
			
	/**
	 * 工作薄对象
	 */
	private SXSSFWorkbook wb;
	
	/**
	 * 工作表对象
	 */
	private Sheet sheet;
	
	/**
	 * 样式列表
	 */
	private Map<String, CellStyle> styles;
	
	
	
	/**
	 * 当前行号
	 */
	private int rownum;
	
	/**
	 * 注解列表（Object[]{ ExcelField, Field/Method }）
	 */
	List<Object[]> annotationList = Lists.newArrayList();
	
	/**
	 * 构造函数
	 * @param title 表格标题，传“空值”，表示无标题
	 * @param cls 实体对象，通过annotation.ExportField获取标题
	 */
	public ExportExcel(String title, String sheetName, Class<?> cls){
		this(title,sheetName, cls, 1);
	}
	
	/**
	 * 构造函数
	 * @param title 表格标题，传“空值”，表示无标题
	 * @param cls 实体对象，通过annotation.ExportField获取标题
	 * @param type 导出类型（1:导出数据；2：导出模板）
	 * @param groups 导入分组
	 */
	public ExportExcel(String title, String sheetName, Class<?> cls, int type, int... groups){
		// Get annotation field 
		Field[] fs = cls.getDeclaredFields();
		for (Field f : fs){
			ExcelField ef = f.getAnnotation(ExcelField.class);
			if (ef != null && (ef.type()==0 || ef.type()==type)){
				if (groups!=null && groups.length>0){
					boolean inGroup = false;
					for (int g : groups){
						if (inGroup){
							break;
						}
						for (int efg : ef.groups()){
							if (g == efg){
								inGroup = true;
								annotationList.add(new Object[]{ef, f});
								break;
							}
						}
					}
				}else{
					annotationList.add(new Object[]{ef, f});
				}
			}
		}
		// Get annotation method
		Method[] ms = cls.getDeclaredMethods();
		for (Method m : ms){
			ExcelField ef = m.getAnnotation(ExcelField.class);
			if (ef != null && (ef.type()==0 || ef.type()==type)){
				if (groups!=null && groups.length>0){
					boolean inGroup = false;
					for (int g : groups){
						if (inGroup){
							break;
						}
						for (int efg : ef.groups()){
							if (g == efg){
								inGroup = true;
								annotationList.add(new Object[]{ef, m});
								break;
							}
						}
					}
				}else{
					annotationList.add(new Object[]{ef, m});
				}
			}
		}
		// Field sorting
		Collections.sort(annotationList, new Comparator<Object[]>() {
			public int compare(Object[] o1, Object[] o2) {
				return new Integer(((ExcelField)o1[0]).sort()).compareTo(
						new Integer(((ExcelField)o2[0]).sort()));
			};
		});
		// Initialize
		List<String> headerList = Lists.newArrayList();
		for (Object[] os : annotationList){
			String t = ((ExcelField)os[0]).title();
			// 如果是导出，则去掉注释
			if (type==1){
				String[] ss = StringUtils.split(t, "**", 2);
				if (ss.length==2){
					t = ss[0];
				}
			}
			headerList.add(t);
		}
		initialize(title, headerList,sheetName);
	}
	
	/**
	 * 构造函数
	 * @param title 表格标题，传“空值”，表示无标题
	 * @param headers 表头数组
	 */
	public ExportExcel(String title, String[] headers, String sheetName) {
		initialize(title, Lists.newArrayList(headers),sheetName);
	}
	
	/**
	 * 构造函数
	 * @param title 表格标题，传“空值”，表示无标题
	 * @param headerList 表头列表
	 */
	public ExportExcel(String title, List<String> headerList, String sheetName) {//ss
		initialize(title, headerList,sheetName);
	}
	

	public ExportExcel() {//ss
		this.wb = new SXSSFWorkbook(500);
	}
	
	/**
	 * 初始化函数
	 * @param title 表格标题，传“空值”，表示无标题
	 * @param headerList 表头列表
	 */
	public void initialize(String title, List<String> headerList,String sheetName) {
		this.wb = new SXSSFWorkbook(500);
		this.sheet = wb.createSheet(sheetName);
		this.styles = createStyles(wb);
		// Create title
		if (StringUtils.isNotBlank(title)){
			Row titleRow = sheet.createRow(rownum++);
			titleRow.setHeightInPoints(30);
			Cell titleCell = titleRow.createCell(0);
			titleCell.setCellStyle(styles.get("title"));
			titleCell.setCellValue(title);
			sheet.addMergedRegion(new CellRangeAddress(titleRow.getRowNum(),
					titleRow.getRowNum(), titleRow.getRowNum(), headerList.size()-1));
		}
		// Create header
		if (headerList == null){
			throw new RuntimeException("headerList not null!");
		}
		Row headerRow = sheet.createRow(rownum++);
		headerRow.setHeightInPoints(16);
		for (int i = 0; i < headerList.size(); i++) {
			Cell cell = headerRow.createCell(i);
			cell.setCellStyle(styles.get("header"));
			String[] ss = StringUtils.split(headerList.get(i), "**", 2);
			if (ss.length==2){
				cell.setCellValue(ss[0]);
				Comment comment = this.sheet.createDrawingPatriarch().createCellComment(
						new XSSFClientAnchor(0, 0, 0, 0, (short) 3, 3, (short) 5, 6));
				comment.setString(new XSSFRichTextString(ss[1]));
				cell.setCellComment(comment);
			}else{
				cell.setCellValue(headerList.get(i));
			}
			sheet.autoSizeColumn(i);
		}
		for (int i = 0; i < headerList.size(); i++) {  
			int colWidth = sheet.getColumnWidth(i)*2;
	        sheet.setColumnWidth(i, colWidth < 3000 ? 3000 : colWidth);  
		}
//		System.out.println("Initialize success.");
	}
	
	/**
	 * 初始化函数
	 * @param title 表格标题，传“空值”，表示无标题
	 * @param headerList 表头列表
	 */
	public void initializeSheet(String title, List<String> headerList,String sheetName) {
		rownum=0;
		this.sheet = wb.createSheet(sheetName);
		this.styles = createStyles(wb);
		// Create title
		if (StringUtils.isNotBlank(title)){
			Row titleRow = sheet.createRow(rownum++);
			titleRow.setHeightInPoints(30);
			Cell titleCell = titleRow.createCell(0);
			titleCell.setCellStyle(styles.get("title"));
			titleCell.setCellValue(title);
			sheet.addMergedRegion(new CellRangeAddress(titleRow.getRowNum(),
					titleRow.getRowNum(), titleRow.getRowNum(), headerList.size()-1));
		}
		// Create header
		if (headerList == null){
			throw new RuntimeException("headerList not null!");
		}
		Row headerRow = sheet.createRow(rownum++);
		headerRow.setHeightInPoints(16);
		for (int i = 0; i < headerList.size(); i++) {
			Cell cell = headerRow.createCell(i);
			cell.setCellStyle(styles.get("header"));
			String[] ss = StringUtils.split(headerList.get(i), "**", 2);
			if (ss.length==2){
				cell.setCellValue(ss[0]);
				Comment comment = this.sheet.createDrawingPatriarch().createCellComment(
						new XSSFClientAnchor(0, 0, 0, 0, (short) 3, 3, (short) 5, 6));
				comment.setString(new XSSFRichTextString(ss[1]));
				cell.setCellComment(comment);
			}else{
				cell.setCellValue(headerList.get(i));
			}
			sheet.autoSizeColumn(i);
		}
		for (int i = 0; i < headerList.size(); i++) {  
			int colWidth = sheet.getColumnWidth(i)*2;
	        sheet.setColumnWidth(i, colWidth < 3000 ? 3000 : colWidth);
		}
//		System.out.println("Initialize success.");
	}
	
	/**
	 * 初始化函数
	 * @param title 表格标题，传“空值”，表示无标题
	 * @param headerList 表头列表
	 */
	/*public void initializeSheetf18(String title, List<String> headerList,String sheetName,String date) {
		rownum=0;
		this.sheet = wb.createSheet(sheetName);
		this.styles = createStyles(wb);
		// Create title
		//if (StringUtils.isNotBlank(title)){
			Row titleRow = sheet.createRow(rownum++);
			titleRow.setHeightInPoints(30);
			Cell titleCell = titleRow.createCell(0);
			titleCell.setCellStyle(styles.get("title"));
			titleCell.setCellValue(title);
			sheet.addMergedRegion(new CellRangeAddress(titleRow.getRowNum(),
					titleRow.getRowNum(), titleRow.getRowNum(), 7));
			//System.out.println(titleRow.getRowNum()+"-"+titleRow.getRowNum()+"-"+titleRow.getRowNum());
		//}
			titleCell = titleRow.createCell(8);
			titleCell.setCellValue("编号：");
			sheet.addMergedRegion(new CellRangeAddress(0,
					0, 8, 11));
		// Create header
		if (headerList == null){
			throw new RuntimeException("headerList not null!");
		}
		
		
		
		Row headerRow2 = sheet.createRow(rownum++);
		Cell cell = headerRow2.createCell(0);
		cell.setCellValue("产品名称：氟[18F]脱氧葡糖注射液");
		cell = headerRow2.createCell(4);
		cell.setCellValue("发货日期："+date);
		*//*cell = headerRow2.createCell(1);
		cell.setCellValue("订货日期");*//*
		sheet.addMergedRegion(new CellRangeAddress(1,
				1, 0, 3));
		sheet.addMergedRegion(new CellRangeAddress(1,
				1, 4, 11));
		
		headerRow2 = sheet.createRow(rownum++);
		cell = headerRow2.createCell(0);
		cell.setCellValue("序号");
		cell = headerRow2.createCell(1);
		cell.setCellValue("医院名称");
		cell = headerRow2.createCell(2);
		cell.setCellValue("第1批("+BatchConfig.batchARR[1]+")");
		cell = headerRow2.createCell(3);
		cell.setCellValue("");
		cell = headerRow2.createCell(4);
		cell.setCellValue("第2批("+BatchConfig.batchARR[2]+")");
		cell = headerRow2.createCell(5);
		cell.setCellValue("");
		cell = headerRow2.createCell(6);
		cell.setCellValue("第3批("+BatchConfig.batchARR[3]+")");
		cell = headerRow2.createCell(7);
		cell.setCellValue("");
		cell = headerRow2.createCell(8);
		cell.setCellValue("第4批("+BatchConfig.batchARR[4]+")");
		cell = headerRow2.createCell(9);
		cell.setCellValue("");
		cell = headerRow2.createCell(10);
		cell.setCellValue("第5批("+BatchConfig.batchARR[5]+")");
		
		sheet.setDefaultColumnWidth(5);		
		cell = headerRow2.createCell(11);	
		cell.setCellValue("");
		
		sheet.addMergedRegion(new CellRangeAddress(2,
				3, 1,1));
		sheet.addMergedRegion(new CellRangeAddress(2,
				3, 0,0));
		
		headerRow2 = sheet.createRow(rownum++);
		cell = headerRow2.createCell(0);
		cell.setCellValue("序号");
		cell = headerRow2.createCell(1);
		cell.setCellValue("医院名称");
		cell = headerRow2.createCell(2);
		cell.setCellValue("订货量");
		cell = headerRow2.createCell(3);
		cell.setCellValue("时间");
		cell = headerRow2.createCell(4);
		cell.setCellValue("订货量");
		cell = headerRow2.createCell(5);
		cell.setCellValue("时间");
		cell = headerRow2.createCell(6);
		cell.setCellValue("订货量");
		cell = headerRow2.createCell(7);
		cell.setCellValue("时间");
		cell = headerRow2.createCell(8);
		cell.setCellValue("订货量");
		cell = headerRow2.createCell(9);
		cell.setCellValue("时间");
		cell = headerRow2.createCell(10);
		cell.setCellValue("订货量");
		cell = headerRow2.createCell(11);
		cell.setCellValue("时间");
		
		
		sheet.addMergedRegion(new CellRangeAddress(2,
				2, 2,3));
		sheet.addMergedRegion(new CellRangeAddress(2,
				2, 4,5));
		sheet.addMergedRegion(new CellRangeAddress(2,
				2, 6,7));
		sheet.addMergedRegion(new CellRangeAddress(2,
				2, 8,9));
		sheet.addMergedRegion(new CellRangeAddress(2,
				2, 10,11));
		*//*for (int i = 0; i < headerList.size(); i++) {
			Cell cell = headerRow.createCell(i);
			cell.setCellStyle(styles.get("header"));
			String[] ss = StringUtils.split(headerList.get(i), "**", 2);
			if (ss.length==2){
				cell.setCellValue(ss[0]);
				Comment comment = this.sheet.createDrawingPatriarch().createCellComment(
						new XSSFClientAnchor(0, 0, 0, 0, (short) 3, 3, (short) 5, 6));
				comment.setString(new XSSFRichTextString(ss[1]));
				cell.setCellComment(comment);
			}else{
				cell.setCellValue(headerList.get(i));
			}
			sheet.autoSizeColumn(i);
		}
		for (int i = 0; i < headerList.size(); i++) {  
			int colWidth = sheet.getColumnWidth(i)*2;
	        sheet.setColumnWidth(i, colWidth < 3000 ? 3000 : colWidth);
		}*//*
//		System.out.println("Initialize success.");
	}*/
	
	
	
	/**
	 * 初始化函数
	 * @param title 表格标题，传“空值”，表示无标题
	 * @param headerList 表头列表
	 */
	public void initializeSheetf1835(String title, List<String> headerList,String sheetName,String date) {

		//this.styles = createStyles(wb);
		//this.sheet = wb.createSheet(sheetName);
		this.styles = createStyles(wb);
		// Create title
		//if (StringUtils.isNotBlank(title)){
		Row titleRow = sheet.createRow(rownum++);
		Cell titleCell = titleRow.createCell(0);
		titleCell.setCellValue("");
		
			titleRow = sheet.createRow(rownum++);
			titleRow.setHeightInPoints(30);
			titleCell = titleRow.createCell(0);
			titleCell.setCellStyle(styles.get("title"));
			titleCell.setCellValue(title);
			/*sheet.addMergedRegion(new CellRangeAddress(titleRow.getRowNum(),
					titleRow.getRowNum(), titleRow.getRowNum(), 9));*/
			sheet.addMergedRegion(new CellRangeAddress(titleRow.getRowNum(),
					titleRow.getRowNum(), 0,5));
			//System.out.println(titleRow.getRowNum()+"-"+titleRow.getRowNum()+"-"+titleRow.getRowNum());
		//}
		
		
		Row headerRow2 = sheet.createRow(rownum++);
		Cell cell = headerRow2.createCell(0);
		cell.setCellValue("序号");
		cell.setCellStyle(styles.get("header"));
		cell = headerRow2.createCell(1);
		cell.setCellValue("客户名称");
		cell.setCellStyle(styles.get("header"));
		cell = headerRow2.createCell(2);
		cell.setCellValue("订货量/mCi");
		cell.setCellStyle(styles.get("header"));
		cell = headerRow2.createCell(3);
		cell.setCellValue("标定至");
		cell.setCellStyle(styles.get("header"));
		cell = headerRow2.createCell(4);
		cell.setCellValue("配送司机");
		cell.setCellStyle(styles.get("header"));
		cell = headerRow2.createCell(5);
		cell.setCellValue("备注");
		cell.setCellStyle(styles.get("header"));
	}
	
	
	/**
	 * 创建表格样式
	 * @param wb 工作薄对象
	 * @return 样式列表
	 */
	private Map<String, CellStyle> createStyles(Workbook wb) {
		Map<String, CellStyle> styles = new HashMap<String, CellStyle>();
		
		CellStyle style = wb.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		Font titleFont = wb.createFont();
		titleFont.setFontName("Arial");
		titleFont.setFontHeightInPoints((short) 16);
		titleFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
		style.setFont(titleFont);
		styles.put("title", style);

		style = wb.createCellStyle();
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setRightBorderColor(IndexedColors.GREY_50_PERCENT.getIndex());
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setLeftBorderColor(IndexedColors.GREY_50_PERCENT.getIndex());
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setTopBorderColor(IndexedColors.GREY_50_PERCENT.getIndex());
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBottomBorderColor(IndexedColors.GREY_50_PERCENT.getIndex());
		Font dataFont = wb.createFont();
		dataFont.setFontName("Arial");
		dataFont.setFontHeightInPoints((short) 12);
		style.setFont(dataFont);
		styles.put("data", style);
		
		
		style = wb.createCellStyle();
		style.cloneStyleFrom(styles.get("data"));
		style.setAlignment(CellStyle.ALIGN_LEFT);
		styles.put("data1", style);

		style = wb.createCellStyle();
		style.cloneStyleFrom(styles.get("data"));
		style.setAlignment(CellStyle.ALIGN_CENTER);
		styles.put("data2", style);

		style = wb.createCellStyle();
		style.cloneStyleFrom(styles.get("data"));
		style.setAlignment(CellStyle.ALIGN_RIGHT);
		styles.put("data3", style);
		
		style = wb.createCellStyle();
		style.cloneStyleFrom(styles.get("data"));
//		style.setWrapText(true);
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
		style.setFillPattern(CellStyle.SOLID_FOREGROUND);
		Font headerFont = wb.createFont();
		headerFont.setFontName("Arial");
		headerFont.setFontHeightInPoints((short) 12);
		headerFont.setBoldweight(Font.BOLDWEIGHT_BOLD);
		headerFont.setColor(IndexedColors.BLACK.getIndex());
		style.setFont(headerFont);
		styles.put("header", style);
		
		return styles;
	}

	/**
	 * 添加一行
	 * @return 行对象
	 */
	public Row addRow(){
		return sheet.createRow(rownum++);
	}
	

	/**
	 * 添加一个单元格
	 * @param row 添加的行
	 * @param column 添加列号
	 * @param val 添加值
	 * @return 单元格对象
	 */
	public Cell addCell(Row row, int column, Object val){
		return this.addCell(row, column, val, 0, Class.class);
	}
	
	public Cell addCell(Row row, int column, Object val, int align ){
		return this.addCell(row, column, val,align , Class.class);
	}
	
	/**
	 * 添加一个单元格
	 * @param row 添加的行
	 * @param column 添加列号
	 * @param val 添加值
	 * @return 单元格对象
	 */
	public Cell addCellNum(Row row, int column, Object val){
		return this.addCellNum(row, column, val, 0, Class.class);
	}
	
	/**
	 * 添加一个单元格
	 * @param row 添加的行
	 * @param column 添加列号
	 * @param val 添加值
	 * @return 单元格对象
	 */
	public Cell addCellUser(Row row, int column, Object val){
		return this.addCell(row, column, val, 0, Class.class);
	}
	
	/**
	 * 添加一个单元格
	 * @param row 添加的行
	 * @param column 添加列号
	 * @param val 添加值
	 * @param align 对齐方式（1：靠左；2：居中；3：靠右）
	 * @return 单元格对象
	 */
	public Cell addCell(Row row, int column, Object val, int align, Class<?> fieldType){
		Cell cell = row.createCell(column);
		CellStyle style = styles.get("data"+(align>=1&&align<=3?align:""));
		try {
			if (val == null){
				cell.setCellValue("");
			} else if (val instanceof String) {
				cell.setCellValue((String) val);
			} else if (val instanceof Integer) {
				cell.setCellValue((Integer) val);
			} else if (val instanceof Long) {
				cell.setCellValue((Long) val);
			} else if (val instanceof Double) {
				cell.setCellValue((Double) val);
			} else if (val instanceof Float) {
				cell.setCellValue((Float) val);
			} else if (val instanceof Date) {
				DataFormat format = wb.createDataFormat();
	            style.setDataFormat(format.getFormat("yyyy-MM-dd"));
				cell.setCellValue((Date) val);
			} else {
				if (fieldType != Class.class){
					cell.setCellValue((String)fieldType.getMethod("setValue", Object.class).invoke(null, val));
				}else{
					cell.setCellValue((String)Class.forName(this.getClass().getName().replaceAll(this.getClass().getSimpleName(), 
						"fieldtype."+val.getClass().getSimpleName()+"Type")).getMethod("setValue", Object.class).invoke(null, val));
				}
			}
		} catch (Exception ex) {
			//log.info("Set cell value ["+row.getRowNum()+","+column+"] error: " + ex.toString());
			cell.setCellValue(val.toString());
		}
		style.setWrapText(true);
		cell.setCellStyle(style);
		return cell;
	}
	
	
	
	
	/**
	 * 添加一个单元格
	 * @param row 添加的行
	 * @param column 添加列号
	 * @param val 添加值
	 * @param align 对齐方式（1：靠左；2：居中；3：靠右）
	 * @return 单元格对象
	 */
	public Cell addCellNum(Row row, int column, Object val, int align, Class<?> fieldType){
		Cell cell = row.createCell(column);
		CellStyle style = styles.get("data"+(align>=1&&align<=3?align:""));
		try {
			if(column==1){
				cell.setCellValue(val.toString());
			}else{
				cell.setCellValue(Integer.parseInt(val.toString()));
			}
		} catch (Exception ex) {
			//log.info("Set cell value ["+row.getRowNum()+","+column+"] error: " + ex.toString());
			cell.setCellValue(val.toString());
		}
		style.setWrapText(true);
		cell.setCellStyle(style);
		return cell;
	}

	/**
	 * 添加数据（通过annotation.ExportField添加数据）
	 * @return list 数据列表
	 *//*
	public <E> ExportExcel setDataList(List<E> list){
		for (E e : list){
			int colunm = 0;
			Row row = this.addRow();
			StringBuilder sb = new StringBuilder();
			for (Object[] os : annotationList){
				ExcelField ef = (ExcelField)os[0];
				Object val = null;
				// Get entity value
				try{
					if (StringUtils.isNotBlank(ef.value())){
						val = Reflections.invokeGetter(e, ef.value());
					}else{
						if (os[1] instanceof Field){
							val = Reflections.invokeGetter(e, ((Field)os[1]).getName());
						}else if (os[1] instanceof Method){
							val = Reflections.invokeMethod(e, ((Method)os[1]).getName(), new Class[] {}, new Object[] {});
						}
					}
					// If is dict, get dict label
					if (StringUtils.isNotBlank(ef.dictType())){
						val = DictUtils.getDictLabel(val==null?"":val.toString(), ef.dictType(), "");
					}
				}catch(Exception ex) {
					// Failure to ignore
					//log.info(ex.toString());
					val = "";
				}
				this.addCell(row, colunm++, val, ef.align(), ef.fieldType());
				sb.append(val + ", ");
			}
			//log.debug("Write success: ["+row.getRowNum()+"] "+sb.toString());
		}
		return this;
	}*/
	
	/**
	 * 输出数据流
	 * @param os 输出数据流
	 */
	public ExportExcel write(OutputStream os) throws IOException{
		wb.write(os);
		return this;
	}
	
	/**
	 * 输出到客户端
	 * @param fileName 输出文件名
	 */
	public ExportExcel write(HttpServletRequest request, HttpServletResponse response, String fileName) throws IOException{
		response.reset();
        
        
		request.setCharacterEncoding("UTF-8");  
		//response.setContentType(this.getServletContext().getMimeType(fileName));
		
		response.setContentType("application/octet-stream; charset=utf-8");
		
	    String userAgent = request.getHeader("User-Agent");
	    response.reset();
	    if(userAgent != null && userAgent.indexOf("MSIE") == -1) {
	        // FF
	    	String enableFileName = "=?UTF-8?B?" + (new String(org.apache.commons.codec.binary.Base64.encodeBase64(fileName.getBytes("UTF-8")))) + "?=";  
	        response.setHeader("Content-Disposition", "attachment; filename=" + enableFileName); 
	    }else{
	        // IE   
	        String enableFileName = new String(fileName.getBytes("GBK"), "ISO-8859-1");   
	        response.setHeader("Content-Disposition", "attachment; filename=" + enableFileName);
	    }
		
		
		write(response.getOutputStream());
		return this;
	}
	
	/**
	 * 输出到文件
	 *
	 */
	public ExportExcel writeFile(String name) throws FileNotFoundException, IOException{
		FileOutputStream os = new FileOutputStream(name);
		this.write(os);
		return this;
	}
	
	/**
	 * 清理临时文件
	 */
	public ExportExcel dispose(){
		wb.dispose();
		return this;
	}
	
	/**
	 * 导出测试
	 */
	public static void main(String[] args) throws Throwable {
		
		List<String> headerList = Lists.newArrayList();
		for (int i = 1; i <= 10; i++) {
			headerList.add("表头"+i);
		}
		
		List<String> dataRowList = Lists.newArrayList();
		for (int i = 1; i <= headerList.size(); i++) {
			dataRowList.add("数据"+i);
		}
		
		List<List<String>> dataList = Lists.newArrayList();
		for (int i = 1; i <=10; i++) {
			dataList.add(dataRowList);
		}

		ExportExcel ee = new ExportExcel("表格标题", headerList,"Export");
		
		for (int i = 0; i < dataList.size(); i++) {
			Row row = ee.addRow();
			for (int j = 0; j < dataList.get(i).size(); j++) {
				ee.addCell(row, j, dataList.get(i).get(j));
			}
		}
		
		ee.writeFile("F:/export.xlsx");

		ee.dispose();
		
	}
	
	
	/**
	 * 初始化函数
	 * @param title 表格标题，传“空值”，表示无标题
	 * @param headerList 表头列表
	 */
	public void initializeSheetdydaochu(String title, List<String> headerList,String sheetName,Http h) {
		try{
		rownum=0;
		this.sheet = wb.createSheet(sheetName);
		this.styles = createStyles(wb);
		// Create title
		if (StringUtils.isNotBlank(title)){
			Row titleRow = sheet.createRow(rownum++);
			titleRow.setHeightInPoints(30);
			Cell titleCell = titleRow.createCell(0);
			titleCell.setCellStyle(styles.get("title"));
			titleCell.setCellValue(title);
			sheet.addMergedRegion(new CellRangeAddress(titleRow.getRowNum(),
					titleRow.getRowNum(), titleRow.getRowNum(), headerList.size()-1));
		}
		// Create header
		if (headerList == null){
			throw new RuntimeException("headerList not null!");
		}
		
		int hospital_id = h.getInt("hospital_id");
		String [] arr2 = {"辐射水平：","时间：","","","客户："};
		Row headerRow1 = sheet.createRow(rownum++);
		for (int i = 0; i < 5; i++) {
			Cell cell = headerRow1.createCell(i);
		}
		Row headerRow2 = sheet.createRow(rownum++);
		for (int i = 0; i < 5; i++) {
			Cell cell = headerRow2.createCell(i);
			cell.setCellValue(arr2[i]);
		}
		//rownum++;
		
		Row headerRow = sheet.createRow(rownum++);
		headerRow.setHeightInPoints(16);
		for (int i = 0; i < headerList.size(); i++) {
			Cell cell = headerRow.createCell(i);
			cell.setCellStyle(styles.get("header"));
			String[] ss = StringUtils.split(headerList.get(i), "**", 2);
			if (ss.length==2){
				cell.setCellValue(ss[0]);
				Comment comment = this.sheet.createDrawingPatriarch().createCellComment(
						new XSSFClientAnchor(0, 0, 0, 0, (short) 3, 3, (short) 5, 6));
				comment.setString(new XSSFRichTextString(ss[1]));
				cell.setCellComment(comment);
			}else{
				cell.setCellValue(headerList.get(i));
			}
			sheet.autoSizeColumn(i);
		}
		for (int i = 0; i < headerList.size(); i++) {  
			int colWidth = sheet.getColumnWidth(i)*2;
	        //sheet.setColumnWidth(i, colWidth < 3000 ? 3000 : colWidth);  
			sheet.setColumnWidth(i,4200);
		}
		}catch(Exception e){
			
		}
		
//		System.out.println("Initialize success.");
	}
	

	public void tianjiawei(int fhtcount){
		Row headerRow2 = sheet.createRow(rownum++);
		Cell cell = headerRow2.createCell(0);
		cell.setCellValue("防护套数量："+fhtcount);
	}
	
	public void hosheji(int count1,int count2){
		CellStyle style = styles.get("data1");
		Row headerRow2 = sheet.createRow(rownum++);
		Cell cell = headerRow2.createCell(0);
		cell.setCellStyle(style);
		cell.setCellValue("合计");
		cell = headerRow2.createCell(1);
		cell.setCellStyle(style);
		cell.setCellValue(count1+"mCi");
		cell = headerRow2.createCell(2);
		cell.setCellStyle(style);
		cell.setCellValue(count2);
		cell = headerRow2.createCell(3);
		cell.setCellStyle(style);
		cell.setCellValue("");
		cell = headerRow2.createCell(4);
		cell.setCellStyle(style);
		cell.setCellValue("");
	}
	
	public void proheji(double count1,int count2){
		CellStyle style = styles.get("data1");
		Row headerRow2 = sheet.createRow(rownum++);
		Cell cell = headerRow2.createCell(0);
		cell.setCellStyle(style);
		cell.setCellValue("合计");
		cell = headerRow2.createCell(1);
		cell.setCellStyle(style);
		cell.setCellValue(count1);
		cell = headerRow2.createCell(2);
		cell.setCellStyle(style);
		cell.setCellValue(count2);
		cell = headerRow2.createCell(3);
		cell.setCellStyle(style);
		cell.setCellValue("");
	}
	
	public void beizhu(int count1,int count2,int count3,int count4,int count5){
		Row headerRow2 = sheet.createRow(rownum++);
		Cell cell = headerRow2.createCell(0);
		cell.setCellValue("备注");
		cell = headerRow2.createCell(1);
		cell.setCellValue("");
		sheet.addMergedRegion(new CellRangeAddress(headerRow2.getRowNum(),
				headerRow2.getRowNum(), 1,11));
		headerRow2 = sheet.createRow(rownum++);
		cell = headerRow2.createCell(0);
		cell.setCellValue("第一批："+count1+"家/第二批："+count2+"家/第三批："+count3+"家/第四批："+count4+"家/第五批："+count5+"家");
		cell = headerRow2.createCell(1);
		cell.setCellValue("");
		sheet.addMergedRegion(new CellRangeAddress(headerRow2.getRowNum(),
				headerRow2.getRowNum(), 0,11));
		
		headerRow2 = sheet.createRow(rownum++);
		cell = headerRow2.createCell(0);
		cell.setCellValue("复核人：");
		cell = headerRow2.createCell(2);
		cell.setCellValue("制单人：");
		/*sheet.addMergedRegion(new CellRangeAddress(headerRow2.getRowNum(),
				headerRow2.getRowNum(), 1,11));*/
	}
	
	public void beizhu15(String showstr,int row){
		Row headerRow2 = sheet.createRow(rownum++);
		Cell cell = headerRow2.createCell(0);
		cell = headerRow2.createCell(0);
		cell.setCellValue(showstr);
		sheet.addMergedRegion(new CellRangeAddress(headerRow2.getRowNum(),
				headerRow2.getRowNum(), 0,row));
	}
	
	
}
