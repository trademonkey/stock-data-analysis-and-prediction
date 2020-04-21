# stock-data-analysis-and-prediction
根据北向和主力资金的行为分析和预测后市股票的涨跌



### 观测 Observation

策略网络观测的就是一只股票的各项参数，比如开盘价、收盘价、成交数量等。部分数值会是一个很大的数值，比如成交金额或者成交量，有可能百万、千万乃至更大，为了训练时网络收敛，观测的状态数据输入时，必须要进行归一化，变换到 `[-1, 1]` 的区间内。

| 参数名称    | 参数描述         | 说明                                |
| ----------- | ---------------- | ----------------------------------- |
| date        | 交易所行情日期   | 格式：YYYY-MM-DD                    |
| code        | 证券代码         | 格式：sh.600000。sh：上海，sz：深圳 |
| open        | 今开盘价格       | 精度：小数点后4位；单位：人民币元   |
| high        | 最高价           | 精度：小数点后4位；单位：人民币元   |
| low         | 最低价           | 精度：小数点后4位；单位：人民币元   |
| close       | 今收盘价         | 精度：小数点后4位；单位：人民币元   |
| preclose    | 昨日收盘价       | 精度：小数点后4位；单位：人民币元   |
| volume      | 成交数量         | 单位：股                            |
| amount      | 成交金额         | 精度：小数点后4位；单位：人民币元   |
| adjustflag  | 复权状态         | 不复权、前复权、后复权              |
| turn        | 换手率           | 精度：小数点后6位；单位：%          |
| tradestatus | 交易状态         | 1：正常交易 0：停牌                 |
| pctChg      | 涨跌幅（百分比） | 精度：小数点后6位                   |
| peTTM       | 滚动市盈率       | 精度：小数点后6位                   |
| psTTM       | 滚动市销率       | 精度：小数点后6位                   |
| pcfNcfTTM   | 滚动市现率       | 精度：小数点后6位                   |
| pbMRQ       | 市净率           | 精度：小数点后6位                   |
| isST        | 是否ST           | 1是，0否                 |


## 🕵️‍♀️ 模拟实验

#### 下载浏览器驱动

| 浏览器  | 下载地址（选择对用的驱动程序下载）                           |
| :-----: | :----------------------------------------------------------- |
| Chrome  | https://sites.google.com/a/chromium.org/chromedriver/downloads |
|  Edge   | https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/ |
| Firefox | https://github.com/mozilla/geckodriver/releases              |
| Safari  | https://webkit.org/blog/6900/webdriver-support-in-safari-10/ |

```sh
# 安装Firefox浏览器驱动，参考
wget https://github.com/mozilla/geckodriver/releases/download/v0.26.0/geckodriver-v0.26.0-linux64.tar.gz
# 下载完之后解压到某个文件夹下
tar -zxvf geckodriver-v0.26.0-linux64.tar.gz -C /opt/software/drivers
# 配置环境变量
vim /etc/profile
# 在文件最后面加入
DRIVERS_HOME=/opt/software/drivers
PATH=$PATH:$DRIVER_HOME
# 保存后使用source让环境变量立即生效
source /etc/profile
```



### 环境安装

```sh
# 虚拟环境
virtualenv -p python3.7 venv
source ./venv/bin/activate
# 安装库依赖
pip install -r requirements.txt
# 退出虚拟环境
# deactivate 
```



### 股票数据获取

股票证券数据集来自于 [baostock](http://baostock.com/baostock/index.php/%E9%A6%96%E9%A1%B5)，一个免费、开源的证券数据平台，提供 Python API。

```bash
>> pip install baostock -i https://pypi.tuna.tsinghua.edu.cn/simple/ --trusted-host pypi.tuna.tsinghua.edu.cn
```

股票数据细节获取代码参考 [get_stock_data.py]()

```python
>> python get_stock_data.py
```

北向沪股通深股通每天涨幅榜top10获取代码参考 [bx_day_rise_top10.py]()

```python
>> python bx_day_rise_top10.py
```

北向沪股通深股通每天买卖成交量top10获取代码参考 [bx_day_volume_top10.py]()

```python
>> python bx_day_volume_top10.py
```

北向沪股通深股通北向历史成交量top10获取代码参考 [bx_history_volumn_top10.py]()

```python
>> python bx_history_volumn_top10.py
```

