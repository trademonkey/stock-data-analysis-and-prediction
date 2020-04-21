-- 北向沪股通深股通每天涨幅榜top10
-- 序号	代码	名称		最新价	涨跌幅	成交额	换手率	市盈率	总市值		交易所	dt2			dt		weekday
-- 1	002156	通富微电	24.71	10.02	32.76亿	11.67	1489.34	285.08亿	深证	2020-04-17	20200417

create table if not exists bx_day_rise_top10(
xh int comment '序号',
code int comment '代码',
name string comment '名称',
zxj decimal(10, 2) comment '最新价',
zdf decimal(10, 2) comment '涨跌幅(%)',
cje string comment '成交额',
hsl decimal(10, 2) comment '换手率(%)',
syl decimal(10, 2) comment '市盈率',
zsz string comment '总市值',
jys string comment '交易所(上海、深圳)',
dt2 date comment 'date format yyyy-MM-dd',
dt string comment 'date format yyyyMMdd',
weekday string comment '周几'
)comment '北向每天涨幅榜-沪股通和深股通Top10'
partitioned by (yearmonth string comment '分区年月 format yyyyMM')
row format delimited
fields terminated by '\t'
stored as textfile;


-- 北向沪股通深股通每天买卖成交量top10
-- 排名	代码	股票简称	收盘价		涨跌幅		深股通净买额	深股通买入金额	深股通卖出金额	深股通成交金额	交易所			dt2			dt		weekday
-- 1	600519	贵州茅台	1226.00		2.41		7507.36万		8.02亿			7.26亿			15.28亿			上证			2020-04-17	20200417

create table if not exists bx_day_volumn_top10(
xh int comment '序号',
code int comment '代码',
name string comment '名称',
spj string comment '收盘价',
zdf decimal(10, 2) comment '涨跌幅(%)',
jme string comment '净买额',
mrje string comment '买入金额',
mcje string comment '卖出金额',
cjje string comment '成交金额',
jys string comment '交易所(上海、深圳)',
dt2 date comment 'date format yyyy-MM-dd',
dt string comment 'date format yyyyMMdd',
weekday string comment '周几'
) comment '北向每天成交量榜-沪股通和深股通Top10'
partitioned by (yearmonth string comment '分区年月 format yyyyMMdd')
row format delimited
fields terminated by '\t'
stored as textfile;


-- 股票具体细节
--date,		code,		open,		high,		low,		close,	volume,		amount,			adjustflag,	turn,		tradestatus,	pctChg,		peTTM,		pbMRQ,		psTTM,		pcfNcfTTM,		isST
--2018-01-02,	sz.000837,	6.1600,		6.2100,		6.1200,		6.2000,	3858021,	23835303.9600,	3,			0.662189,	1,				1.307188,	88.561479,	1.523950,	1.428011,	-747.210356,	0
--2020-04-21, sz.000837,	3.9900,		4.0100,		3.9000,		3.9100,	5277402,	20749013.8200,	3,			0.761400,	1,				-2.005000,	-9.111043,	1.062674,	0.856588,	-275.187176,	0

create table if not exists stock_details(
dt date comment '交易所行情日期 (格式：YYYY-MM-DD)',
code string comment '证券代码 (格式：sh.600000。sh：上海，sz：深圳)',
open decimal(20, 4) comment '今开盘价格 (精度：小数点后4位；单位：人民币元)',
high decimal(20, 4) comment '最高价 (精度：小数点后4位；单位：人民币元)',
low decimal(20, 4) comment '最低价 (精度：小数点后4位；单位：人民币元)',
close decimal(20, 4) comment '今收盘价	(精度：小数点后4位；单位：人民币元)',
--preclose decimal(20, 4) comment '昨日收盘价 (精度：小数点后4位；单位：人民币元)',
volume bigint comment '成交数量 (单位：股)',
amount decimal(20, 4) comment '成交金额 (精度：小数点后4位；单位：人民币元)',
adjustflag tinyint comment '复权类型 (默认不复权：3；1：后复权；2：前复权)',
turn decimal(20, 4) comment '换手率 (精度：小数点后6位；单位：%		[指定交易日的成交量(股)/指定交易日的股票的流通股总股数(股)]*100%)',
tradestatus tinyint comment '交易状态 (1：正常交易   0：停牌)',
pctChg decimal(20, 4) comment '涨跌幅[百分比] (精度：小数点后6位；单位：%)	日涨跌幅=[(指定交易日的收盘价-指定交易日前收盘价)/指定交易日前收盘价]*100%',
peTTM decimal(20, 4) comment '滚动市盈率 (精度：小数点后6位)	(指定交易日的股票收盘价/指定交易日的每股盈余TTM)=(指定交易日的股票收盘价*截至当日公司总股本)/归属母公司股东净利润TTM',
pbMRQ decimal(20, 4) comment '市净率 (精度：小数点后6位)		(指定交易日的股票收盘价/指定交易日的每股净资产)=总市值/(最近披露的归属母公司股东的权益-其他权益工具)',
psTTM decimal(20, 4) comment '滚动市销率 (精度：小数点后6位)	(指定交易日的股票收盘价/指定交易日的每股销售额)=(指定交易日的股票收盘价*截至当日公司总股本)/营业总收入TTM',
pcfNcfTTM decimal(20, 4) comment '滚动市现率 (精度：小数点后6位)		(指定交易日的股票收盘价/指定交易日的每股现金流TTM)=(指定交易日的股票收盘价*截至当日公司总股本)/现金以及现金等价物净增加额TTM',
isST tinyint comment '是否ST股，1是，0否'
)comment '股票具体细节'
partitioned by (yearmonth string comment '分区年月 format yyyyMM')
row format delimited
fields terminated by ','
stored as textfile
tblproperties("skip.header.line.count"="1");