require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "LuaGo"--中文函数库
import "com.中文辅助类.对话框"
import "com.中文辅助类.泡沫对话框"
import "layout"
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

activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE|WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN)


file='/sdcard/Android/data/top.jiecs.calendar/files/ProgramSet/setting'
function 写入文件(路径,内容)
 f=File(tostring(File(tostring(路径)).getParentFile())).mkdirs()
 io.open(tostring(路径),"w"):write(tostring(内容)):close()
end

function time(i)
 return os.date("%Y-%m-%d %H:%M",i)
end

function Refresh()
 if File(file).isFile() then
  content=io.open(file):read("*a")
  else
  print('配置文件不存在')
  退出程序()
 end

 time1=content:match('time1"(.-)"')--时间1
 if time1=='0' then
  time1View.Text='点击设置'
  else
  time1View.Text=time(time1)
 end

 time2=content:match('time2"(.-)"')--时间2
 if time2=='0' then
  time2View.Text='点击设置'
  else
  time2View.Text=time(time2)
 end

 time3=content:match('time3"(.-)"')--时间3
 if time3=='0' then
  time3View.Text='点击设置'
  else
  time3View.Text=time(time3)
 end

 time4=content:match('time4"(.-)"')--时间4
 if time4=='0' then
  time4View.Text='点击设置'
  else
  time4View.Text=time(time4)
 end
 task(100,function()
  Refresh()
 end)
end
Refresh()

name1=content:match('name1"(.-)"')--名字1
name1View.Text=name1
name2=content:match('name2"(.-)"')--名字2
name2View.Text=name2
name3=content:match('name3"(.-)"')--名字3
name3View.Text=name3
name4=content:match('name4"(.-)"')--名字4
name4View.Text=name4

function back(i)
 q='name'..i..'"'
 b='"time'..i
end

function onKeyDown(c,e)
 if c==4 then
  --返回键事件
  contentn=content
  name1n=tostring(name1View.getText())
  name2n=tostring(name2View.getText())
  name3n=tostring(name3View.getText())
  name4n=tostring(name4View.getText())
  if name1n~=name1 and time1~='0' then
   back(1)
   local front1=contentn:match('(.+)'..q)
   local behind1=contentn:match(b..'(.+)')
   contentn=front1..q..name1n..b..behind1
  end
  if name2n~=name2 and time2~='0' then
   back(2)
   local front2=contentn:match('(.+)'..q)
   local behind2=contentn:match(b..'(.+)')
   contentn=front2..q..name2n..b..behind2
  end
  if name3n~=name3 and time3~='0' then
   back(3)
   local front3=contentn:match('(.+)'..q)
   local behind3=contentn:match(b..'(.+)')
   contentn=front3..q..name3n..b..behind3
  end
  if name4n~=name4 and time4~='0' then
   back(4)
   local front4=contentn:match('(.+)'..q)
   local behind4=contentn:match(b..'(.+)')
   contentn=front4..q..name4n..b..behind4
  end
  写入文件(file,contentn)
 end
end

filesite='/sdcard/Android/data/top.jiecs.calendar/files/ProgramSet/site'
time1View.onClick=function()
 写入文件(filesite,'1')
 进入子页面('timeset')
end
time2View.onClick=function()
 写入文件(filesite,'2')
 进入子页面('timeset')
end
time3View.onClick=function()
 写入文件(filesite,'3')
 进入子页面('timeset')
end
time4View.onClick=function()
 写入文件(filesite,'4')
 进入子页面('timeset')
end

function clean(i)
 if i==4 then
  q='name4"'
  b='"E'
  else
  q='name'..i..'"'
  b='"name'..i+1
 end
end

c1.onClick=function()
 contentn=content
 clean(1)
 local front1=contentn:match('(.+)'..q)
 local behind1=contentn:match(b..'(.+)')
 local contentn=front1..q..'事件"time1"0'..b..behind1
 写入文件(file,contentn)
 name1View.Text='事件'
end
c2.onClick=function()
 contentn=content
 clean(2)
 local front2=contentn:match('(.+)'..q)
 local behind2=contentn:match(b..'(.+)')
 local contentn=front2..q..'事件"time2"0'..b..behind2
 写入文件(file,contentn)
 name2View.Text='事件'
end
c3.onClick=function()
 contentn=content
 clean(3)
 local front3=contentn:match('(.+)'..q)
 local behind3=contentn:match(b..'(.+)')
 local contentn=front3..q..'事件"time3"0'..b..behind3
 写入文件(file,contentn)
 name3View.Text='事件'
end
c4.onClick=function()
 contentn=content
 clean(4)
 local front4=contentn:match('(.+)'..q)
 local behind4=contentn:match(b..'(.+)')
 local contentn=front4..q..'事件"time4"0'..b..behind4
 写入文件(file,contentn)
 name4View.Text='事件'
end
