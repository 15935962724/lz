-- 品牌管理
CREATE TABLE [dbo].[shopbrand](
	[brand] [int] NOT NULL,
	[name0] [varchar](200) NULL,
	[name1] [varchar](200) NULL,
	[logo] [varchar](200) NULL,
	[content0] [ntext] NULL,
	[content1] [ntext] NULL,
	[sequence] [int] NULL,
	[time] [datetime] NULL,
	[sync] [varchar](100) NULL,
 CONSTRAINT [PK_shopbrand] PRIMARY KEY CLUSTERED 
(
	[brand] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'品牌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopbrand', @level2type=N'COLUMN',@level2name=N'brand'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopbrand', @level2type=N'COLUMN',@level2name=N'name0'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopbrand', @level2type=N'COLUMN',@level2name=N'content0'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'顺序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopbrand', @level2type=N'COLUMN',@level2name=N'sequence'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopbrand', @level2type=N'COLUMN',@level2name=N'time'

-- 分类管理
CREATE TABLE [dbo].[shopcategory](
	[category] [int] NOT NULL,
	[father] [int] NULL,
	[path] [varchar](200) NULL,
	[name0] [varchar](100) NULL,
	[name1] [varchar](100) NULL,
	[price] [int] NULL,
	[pcolor] [bit] NULL,
	[psize] [bit] NULL,
	[hidden] [bit] NULL,
	[sequence] [int] NULL,
	[brand] [varchar](1000) NULL,
	[time] [datetime] NULL,
	[sync] [varchar](100) NULL,
 CONSTRAINT [PK_shopcategory] PRIMARY KEY CLUSTERED 
(
	[category] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopcategory', @level2type=N'COLUMN',@level2name=N'category'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopcategory', @level2type=N'COLUMN',@level2name=N'father'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'路径' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopcategory', @level2type=N'COLUMN',@level2name=N'path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopcategory', @level2type=N'COLUMN',@level2name=N'name0'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'价格区域' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopcategory', @level2type=N'COLUMN',@level2name=N'price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'颜色' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopcategory', @level2type=N'COLUMN',@level2name=N'pcolor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'尺码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopcategory', @level2type=N'COLUMN',@level2name=N'psize'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'显示/隐藏' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopcategory', @level2type=N'COLUMN',@level2name=N'hidden'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'顺序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopcategory', @level2type=N'COLUMN',@level2name=N'sequence'

-- 价格
CREATE TABLE [dbo].[shopprice](
	[price] [int] NOT NULL,
	[area] [varchar](200) NULL,
	[maxi] [int] NULL,
 CONSTRAINT [PK_shopprice] PRIMARY KEY CLUSTERED 
(
	[price] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'价格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopprice', @level2type=N'COLUMN',@level2name=N'price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'区域' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopprice', @level2type=N'COLUMN',@level2name=N'area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最大价格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopprice', @level2type=N'COLUMN',@level2name=N'maxi'

-- 属性管理
CREATE TABLE [dbo].[shopattrib](
	[attrib] [int] NOT NULL,
	[category] [int] NULL,
	[type] [tinyint] NULL,
	[need] [bit] NULL,
	[query] [bit] NULL,
	[name0] [varchar](100) NULL,
	[name1] [varchar](100) NULL,
	[content0] [text] NULL,
	[content1] [text] NULL,
	[sequence] [int] NULL,
 CONSTRAINT [PK_shopattrib] PRIMARY KEY CLUSTERED 
(
	[attrib] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'属性' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopattrib', @level2type=N'COLUMN',@level2name=N'attrib'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopattrib', @level2type=N'COLUMN',@level2name=N'category'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类型:文本框;文本域;复选框;单选框;下拉框;' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopattrib', @level2type=N'COLUMN',@level2name=N'type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'必填' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopattrib', @level2type=N'COLUMN',@level2name=N'need'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'查询' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopattrib', @level2type=N'COLUMN',@level2name=N'query'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopattrib', @level2type=N'COLUMN',@level2name=N'name0'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopattrib', @level2type=N'COLUMN',@level2name=N'content0'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'顺序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopattrib', @level2type=N'COLUMN',@level2name=N'sequence'

-- 产地管理
CREATE TABLE [dbo].[shoporigin](
	[origin] [int] NOT NULL,
	[name0] [varchar](200) NULL,
	[name1] [varchar](200) NULL,
	[hits] [int] NULL,
 CONSTRAINT [PK_shoporigin] PRIMARY KEY CLUSTERED 
(
	[origin] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品产地' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shoporigin', @level2type=N'COLUMN',@level2name=N'origin'

-- 商品管理
CREATE TABLE [dbo].[shopproduct](
	[product] [int] NOT NULL,
	[member] [int] NULL,
	[brand] [int] NULL,
	[category] [int] NULL,
	[name0] [varchar](200) NULL,
	[name1] [varchar](200) NULL,
	[supply] [money] NULL,
	[list] [money] NULL,
	[price] [money] NULL,
	[code] [varchar](100) NULL,
	[inventory] [int] NULL,
	[picture] [varchar](800) NULL,
	[state] [tinyint] NULL,
	[recommend] [varchar](200) NULL,
	[origin] [int] NULL,
	[gross] [float] NULL,
	[content0] [ntext] NULL,
	[content1] [ntext] NULL,
	[spec0] [ntext] NULL,
	[spec1] [ntext] NULL,
	[pack0] [ntext] NULL,
	[pack1] [ntext] NULL,
	[hits] [int] NULL,
	[sales] [int] NULL,
	[praise] [tinyint] NULL,
	[time] [datetime] NULL,
	[sync] [varchar](100) NULL,
	[yucode] [nvarchar](50) NULL,
	[color] [nvarchar](50) NULL,
	[size] [nvarchar](50) NULL,
	[packing] [nvarchar](50) NULL,
	[Place] [nvarchar](50) NULL,
	[commend] [nvarchar](500) NULL,
	[popularity] [int] NULL,
	[shopid] [int] NULL,
	[farming] [int] NULL,
	[indexshow] [int] NULL,
	[pcode] [int] NULL,
	[model_id] [int] NULL,
 CONSTRAINT [PK_shopproduct] PRIMARY KEY CLUSTERED 
(
	[product] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'品牌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopproduct', @level2type=N'COLUMN',@level2name=N'brand'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品分类' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopproduct', @level2type=N'COLUMN',@level2name=N'category'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopproduct', @level2type=N'COLUMN',@level2name=N'name0'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'进货价' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopproduct', @level2type=N'COLUMN',@level2name=N'supply'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标价' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopproduct', @level2type=N'COLUMN',@level2name=N'list'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'销售价' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopproduct', @level2type=N'COLUMN',@level2name=N'price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商家编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopproduct', @level2type=N'COLUMN',@level2name=N'code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'库存' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopproduct', @level2type=N'COLUMN',@level2name=N'inventory'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'|图片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopproduct', @level2type=N'COLUMN',@level2name=N'picture'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否下架' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopproduct', @level2type=N'COLUMN',@level2name=N'state'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'推荐配件' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopproduct', @level2type=N'COLUMN',@level2name=N'recommend'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品产地' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopproduct', @level2type=N'COLUMN',@level2name=N'origin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品毛重' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopproduct', @level2type=N'COLUMN',@level2name=N'gross'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopproduct', @level2type=N'COLUMN',@level2name=N'content0'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'规格参数 ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopproduct', @level2type=N'COLUMN',@level2name=N'spec0'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'包装清单' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopproduct', @level2type=N'COLUMN',@level2name=N'pack0'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'浏览量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopproduct', @level2type=N'COLUMN',@level2name=N'hits'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'销量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopproduct', @level2type=N'COLUMN',@level2name=N'sales'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'好评度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopproduct', @level2type=N'COLUMN',@level2name=N'praise'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'规格/型号id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'shopproduct', @level2type=N'COLUMN',@level2name=N'model_id'



