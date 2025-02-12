import baostock as bs
import pandas as pd

# 登录 baostock
bs.login()

# 你想查询的股票代码（例如岩山科技：300663）
stock_code = "300663"  # 股票代码

# 查询实时数据
rs = bs.query_realtime_quotes(stock_code)  # 获取实时数据

# 检查是否成功
if rs.error_code == '0':
    data = rs.get_row_data()
    if data:
        # 输出股票的实时信息
        stock_name = data[0]  # 股票名称
        stock_price = data[3]  # 当前股价
        print(f"{stock_name} 当前股价: {stock_price}元")
    else:
        print("未获取到实时数据")
else:
    print(f"错误代码: {rs.error_code}, 错误信息: {rs.error_msg}")

# 登出 baostock
bs.logout()