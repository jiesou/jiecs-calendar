require "LuaGo"
require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "LuaGo"--中文函数库
import "com.中文辅助类.对话框"
import "com.中文辅助类.泡沫对话框"
import "layout"
import "android.view.WindowManager"

activity.setTheme(R.AndLua1)
activity.setTitle("日程倒计时")
activity.setContentView(loadlayout(layout))


activity.setTheme(android.R.style.Theme_DeviceDefault_Light)--设置md主题
activity.ActionBar.hide()--隐藏顶栏


--activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(0xFF8066FF);
--状态栏颜色，如需使用请删除下面代码

if Build.VERSION.SDK_INT >= 19 then
 activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
end
--沉浸状态栏
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION)--小白条适配
--沉浸导航栏

function 写入文件(路径,内容)
 f=File(tostring(File(tostring(路径)).getParentFile())).mkdirs()
 io.open(tostring(路径),"w"):write(tostring(内容)):close()
end

file='/sdcard/Android/data/top.jiecs.calendar/files/ProgramSet/setting'
stylefile='/sdcard/Android/data/top.jiecs.calendar/files/ProgramSet/set'
sitefile='/sdcard/Android/data/top.jiecs.calendar/files/ProgramSet/site'
function Countdown(ends)
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
  elseif day>99999 then
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

theset.setVisibility(View.GONE)
full.onClick=function()
 theset.setVisibility(View.VISIBLE)
 task(1000,function()
  theset.setVisibility(View.GONE)
 end)
end

if File(sitefile).isFile() then
 site=io.open(sitefile):read("*a")
 else
 print('配置文件不存在')
 退出程序()
end
q='name'..site..'"'
b='time'..site..'"'
function Refresh()
 if File(file).isFile() then
  content=io.open(file):read("*a")
  else
  print('配置文件不存在')
  退出程序()
 end
 if File(stylefile).isFile() then
  stylecontent=io.open(stylefile):read("*a")
  else
  写入文件(stylefile,'STRdark"false"int"80"END')
  stylecontent='STRdark"false"int"80"END'
 end
 int=tonumber(stylecontent:match('int"(.-)"'))--刷新间隔
 dark=stylecontent:match('dark"(.-)"')--深色模式
 oled=stylecontent:match('oled"(.-)"')--防烧屏
 darkRefresh()
 name=content:match(q..'(.-)"')--名字
 incident.Text='距离 '..os.date("%Y-%m-%d %H:%M ",time)..name..' 还有'
 time=content:match(b..'(.-)"')--时间
 countdown.Text=Countdown(time)
 nowtime.Text='现在是：'..os.date("%Y-%m-%d %H:%M:%S")
 task(int,function()
  Refresh()
 end)
end
function darkRefresh()
 if dark=='true' then
  drawerLayout.setBackgroundColor(Color.parseColor("#ff000000"))
  countdown.setTextColor(0xffffffff)
  nowtime.setTextColor(0xffffffff)
  incident.setTextColor(0xffffffff)
  隐藏状态栏()
  else
  drawerLayout.setBackgroundColor(Color.parseColor("#ffffffff"))
  countdown.setTextColor(0xff000000)
  nowtime.setTextColor(0xff737373)
  incident.setTextColor(0xff737373)
  activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
 end
end
Refresh()
