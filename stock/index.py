# import baostock as bs
# import pandas as pd

# # 登录 baostock
# bs.login()

# # 你想查询的股票代码（例如岩山科技：300663）
# stock_code = "300663"  # 股票代码

# # 查询实时数据
# rs = bs.query_realtime_quotes(stock_code)  # 获取实时数据

# # 检查是否成功
# if rs.error_code == '0':
#     data = rs.get_row_data()
#     if data:
#         # 输出股票的实时信息
#         stock_name = data[0]  # 股票名称
#         stock_price = data[3]  # 当前股价
#         print(f"{stock_name} 当前股价: {stock_price}元")
#     else:
#         print("未获取到实时数据")
# else:
#     print(f"错误代码: {rs.error_code}, 错误信息: {rs.error_msg}")

# # 登出 baostock
# bs.logout()

import baostock as bs
import time
from datetime import datetime

# 登录 baostock
bs.login()

# 你想查询的股票代码（例如岩山科技：300663）
stock_code = "300663"  # 股票代码

# 获取当前时间
def is_market_open():
    """判断当前时间是否在股市开盘时间（9:30 - 15:00）"""
    current_time = datetime.now().time()
    return current_time >= datetime.strptime("09:30", "%H:%M").time() and current_time <= datetime.strptime("15:00", "%H:%M").time()

# 输出实时股价的函数
def get_realtime_price():
    """获取实时股票价格并输出"""
    rs = bs.query_realtime_quotes(stock_code)  # 获取实时数据
    if rs.error_code == '0':
        data = rs.get_row_data()
        if data:
            stock_name = data[0]  # 股票名称
            stock_price = data[3]  # 当前股价
            print(f"{stock_name} 当前股价: {stock_price}元")
        else:
            print("未获取到实时数据")
    else:
        print(f"错误代码: {rs.error_code}, 错误信息: {rs.error_msg}")

# 循环输出股票实时价格
try:
    while True:
        # 判断是否在股市交易时间内
        if is_market_open():
            get_realtime_price()  # 输出实时股价
        else:
            print("股市未开盘或已收盘，当前时间:", datetime.now().strftime('%H:%M:%S'))
            break  # 退出循环（或可以延迟，等到股市开盘再继续）

        # 每秒钟输出一次股价
        time.sleep(1)

except KeyboardInterrupt:
    print("程序已终止")

# 登出 baostock
bs.logout()