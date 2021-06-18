require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "LuaGo"--中文函数库
import "com.中文辅助类.对话框"
import "com.中文辅助类.泡沫对话框"
import "layout"
import "java.io.File"--导入File类
activity.setTheme(R.AndLua1)
activity.setTitle("日程倒计时")
activity.setContentView(loadlayout(layout))
activity.ActionBar.hide()--隐藏顶栏
activity.setTheme(android.R.style.Theme_DeviceDefault_Light)--设置md主题

activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(0xffffff);
--状态栏颜色，如需使用请删除下面代码
if Build.VERSION.SDK_INT >= 19 then
 activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
end
--沉淀状态栏
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION)--小白条适配
--沉浸导航栏

file='/sdcard/Android/data/top.jiecs.calendar/files/ProgramSet/setting'
function 写入文件(路径,内容)
 f=File(tostring(File(tostring(路径)).getParentFile())).mkdirs()
 io.open(tostring(路径),"w"):write(tostring(内容)):close()
end
function counttime(ends)
 --当前时间
 now=os.time()
 --相差总秒数
 local s=ends-now
 --计算，输出
 local day=tointeger(Math.floor(s/60/60/24))--天
 local hour=tointeger(Math.floor(s/60/60%24))--时
 local min=tointeger(Math.floor(s/60%60))--分
 local sec=tointeger(Math.floor(s%60))--秒
 if day<0 then
  return '已到达'
  elseif day>999 then
  return '数据过大'
  elseif day==0 and hour==0 and min==0 then
  return sec.."秒"
  elseif day==0 and hour==0 then
  return min.."分"..sec.."秒"
  elseif day==0 then
  return hour.."时"..min.."分"..sec.."秒"
  else
  return day.."天"..hour.."时"..min.."分"..sec.."秒"
 end
end
counttime(1624669200)
function Refresh()
 if File(file).isFile() then
  content=io.open(file):read("*a")
  else
  写入文件(file,'STRname1"事件"time1"0"name2"事件"time2"0"name3"事件"time3"0"name4"事件"time4"0"END')
  content='STRname1"事件"time1"0"name2"事件"time2"0"name3"事件"time3"0"name4"事件"time4"0"END'
 end

 name1=content:match('name1"(.-)"')--名字1
 name1View.Text=name1
 time1=content:match('time1"(.-)"')--时间1
 if time1=='0' then
  card1.setVisibility(View.GONE)
  else
  card1.setVisibility(View.VISIBLE)
  time1View.Text=counttime(time1)
 end

 name2=content:match('name2"(.-)"')--名字2
 name2View.Text=name2
 time2=content:match('time2"(.-)"')--时间2
 if time2=='0' then
  card2.setVisibility(View.GONE)
  else
  card2.setVisibility(View.VISIBLE)
  time2View.Text=counttime(time2)
 end

 name3=content:match('name3"(.-)"')--名字3
 name3View.Text=name3
 time3=content:match('time3"(.-)"')--时间3
 if time3=='0' then
  card3.setVisibility(View.GONE)
  else
  card3.setVisibility(View.VISIBLE)
  time3View.Text=counttime(time3)
 end

 name4=content:match('name4"(.-)"')--名字4
 name4View.Text=name4
 time4=content:match('time4"(.-)"')--时间4
 if time4=='0' then
  card4.setVisibility(View.GONE)
  else
  card4.setVisibility(View.VISIBLE)
  time4View.Text=counttime(time4)
 end

 task(1000,function()
  Refresh()
 end)
end

Refresh()

sitefile='/sdcard/Android/data/top.jiecs.calendar/files/ProgramSet/site'
time1View.onClick=function()
 写入文件(sitefile,'1')
 进入子页面('full')
end
time2View.onClick=function()
 写入文件(sitefile,'2')
 进入子页面('full')
end
time3View.onClick=function()
 写入文件(sitefile,'3')
 进入子页面('full')
end
time4View.onClick=function()
 写入文件(sitefile,'4')
 进入子页面('full')
end

