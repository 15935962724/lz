package tea.htmlx;

/**
 * <p>
 * Title: 企业发展网络系统平台
 * </p>
 * 
 * <p>
 * Description:
 * </p>
 * 
 * <p>
 * Copyright: Copyright (c) 2004
 * </p>
 * 
 * @version 2004
 */
public class CountrySelection extends HtmlX
{  
	//"CF","PM","RE", 
	public static final String COUNTRY_TYPE[] = { "AA","AD", "AE", "AF", "AG", "AI", "AL", "AM", "AN", "AO", "AQ", "AR", "AS", "AT", "AU", "AW", "AZ", "BA", "BB", "BD", "BE", "BF", "BG", "BH", "BI", "BJ",
			"BM", "BN", "BO", "BR", "BS", "BT", "BV", "BW", "BY", "BZ", "CA", "CC", "CD",  "CG", "CH", "CI", "CK", "CL", "CM", "CN", "CO", "CR", "CS", "CU", "CV", "CX", "CY", "CZ", "DE", "DJ",
			"DK", "DM", "DO", "DZ", "EC", "EE", "EG", "EH", "ER", "ES", "ET", "FI", "FJ", "FK", "FM", "FO", "FR", "GA", "GB", "GD", "GE", "GF", "GH", "GI", "GL", "GM", "GN", "GP", "GQ", "GR", "GS",
			"GT", "GU", "GW", "GY", "HK", "HM", "HN", "HR", "HT", "HU", "ID", "IE", "IL", "IN", "IO", "IQ", "IR", "IS", "IT", "JM", "JO", "JP", "KE", "KG", "KH", "KI", "KM", "KN", "KP", "KR", "KW",
			"KY", "KZ", "LA", "LB", "LC", "LI", "LK", "LR", "LS", "LT", "LU", "LV", "LY", "MA", "MC", "MD", "MG", "MH", "MK", "ML", "MM", "MN", "MO", "MP", "MQ", "MR", "MS", "MT", "MU", "MV", "MW",
			"MX", "MY", "MZ", "NA", "NC", "NE", "NF", "NG", "NI", "NL", "NO", "NP", "NR", "NU", "NZ", "OM", "PA", "PE", "PF", "PG", "PH", "PK", "PL",  "PN", "PR", "PS", "PT", "PW", "PY", "QA",
			"RO", "RU", "RW", "SA", "SB", "SC", "SD", "SE", "SG", "SH", "SI", "SJ", "SK", "SL", "SM", "SN", "SO", "SR", "ST", "SV", "SY", "SZ", "TC", "TD", "TF", "TG", "TH", "TJ", "TK", "TL",
			"TM", "TN", "TO", "TP", "TR", "TT", "TV",
			// "TW",//台湾
			"TZ", "UA", "UG", "UM", "US", "UY", "UZ", "VA", "VC", "VE", "VG", "VI", "VN", "VU", "WF", "WS", "YE", "YT", "YU", "ZA", "ZM", "ZW" };

	String name;
	String value; 
   
	public CountrySelection(String name, int _nLanguage)
	{
		this(name, _nLanguage, "CN");
	}

	public CountrySelection(int _nLanguage, String value)
	{
		this(null, _nLanguage, value);
	}

	public CountrySelection(String name, int _nLanguage, String value)
	{
		super(_nLanguage);
		this.name = name;
		if (value != null && value.length() > 0)
		{
			this.value = value;
		} else
		{
			this.value = "";
		}
	}

	public String toString()
	{
		if (name != null)
		{
			tea.html.DropDown dropdown = new tea.html.DropDown(name, value);
			for (int loop = 0; loop < COUNTRY_TYPE.length; loop++)
			{
				dropdown.addOption(COUNTRY_TYPE[loop], getString("Country." + COUNTRY_TYPE[loop]));
			} 
			
			return dropdown.toString();
		} else
		{
			for (int loop = 0; loop < COUNTRY_TYPE.length; loop++)
			{
				if (COUNTRY_TYPE[loop].equals(value))
				{
					return getString("Country." + COUNTRY_TYPE[loop]);
				}
			}
			return value;
		}
	}
}
