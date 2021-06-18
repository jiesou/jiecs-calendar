require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "LuaGo"--中文函数库
import "com.中文辅助类.对话框"
import "com.中文辅助类.泡沫对话框"
import "layout"
import "android.widget.TimePicker$OnTimeChangedListener"
import "java.io.File"

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
--沉淀状态栏
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION)--小白条适配
--沉浸导航栏
file='/sdcard/Android/data/top.jiecs.calendar/files/ProgramSet/setting'
site=io.open('/sdcard/Android/data/top.jiecs.calendar/files/ProgramSet/site'):read("*a")

function 写入文件(路径,内容)
 f=File(tostring(File(tostring(路径)).getParentFile())).mkdirs()
 io.open(tostring(路径),"w"):write(tostring(内容)):close()
end

if File(file).isFile() then
 content=io.open(file):read("*a")
 else
 print('配置文件不存在')
 退出程序()
end

if site=='1' then
 title.Text='时间一设置'
 elseif site=='2' then
 title.Text='时间二设置'
 elseif site=='3' then
 title.Text='时间三设置'
 elseif site=='4' then
 title.Text='时间四设置'
end

q='ime'..site..'"'
if site=='4' then
 b='"E'
 else
 b='"name'..tointeger(site+1)..'"'
end

function onKeyDown(c,e)
 if c==4 then
  --返回键事件
  day=date.getDayOfMonth()--获取选择的天数
  month=date.getMonth ()--获取选择的月份
  year=date.getYear()--获取选择的年份
  hour=time.getCurrentHour()--获取选择的时
  min=time.getCurrentMinute()--获取选择的分
  time=os.time({day=day,month=month+1,year=year,hour=hour,min=min})
  front=content:match('(.+)'..q)
  behind=content:match(b..'(.+)')
  contentn=front..q..time..b..behind
  写入文件(file,contentn)
 end
end