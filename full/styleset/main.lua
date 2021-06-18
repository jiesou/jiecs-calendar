require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "LuaGo"--中文函数库
import "com.中文辅助类.对话框"
import "com.中文辅助类.泡沫对话框"
import "layout"
import "android.text.InputType"
import "android.text.method.DigitsKeyListener"
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
intText.setInputType(InputType.TYPE_CLASS_NUMBER)
intText.setKeyListener(DigitsKeyListener.getInstance("0123456789"))


stylefile='/sdcard/Android/data/top.jiecs.calendar/files/ProgramSet/set'
function 写入文件(路径,内容)
 f=File(tostring(File(tostring(路径)).getParentFile())).mkdirs()
 io.open(tostring(路径),"w"):write(tostring(内容)):close()
end

if File(stylefile).isFile() then
 content=io.open(stylefile):read("*a")
 else
 print('配置文件不存在')
 退出程序()
end
int=content:match('int"(.-)"')--刷新间隔
intText.Text=int
dark=content:match('dark"(.-)"')--深色模式
if dark=='true' then
 darkSwitch.setImageBitmap(loadbitmap('check_box_black.png'))
 darkn='true'
 else
 darkSwitch.setImageBitmap(loadbitmap('check_box_selections.png'))
 darkn='false'
end

darkSwitch.onClick=function()
 if darkn==nil or darkn=='false' then
  darkSwitch.setImageBitmap(loadbitmap('check_box_black.png'))
  darkn='true'
  else
  darkSwitch.setImageBitmap(loadbitmap('check_box_selections.png'))
  darkn='false'
 end
end

function onKeyDown(c,e)
 if c==4 then
  --返回键事件
  contentn=content
  if darkn==nil then darkn='false' end
  intn=tonumber(tostring(intText.getText()))
  if intn<1 then
   intn='1'
   elseif intn>1000 then
   intn='1000'
   else
   intn=tostring(intn)
  end
  local front1=contentn:match('(.+)dark"')--深色模式
  local behind1=contentn:match('"int(.+)')
  contentn=front1..'dark"'..darkn..'"int'..behind1
  local front1=contentn:match('(.+)int"')--刷新延迟
  local behind1=contentn:match('"E(.+)')
  contentn=front1..'int"'..intn..'"E'..behind1
  写入文件(stylefile,contentn)
 end
end
