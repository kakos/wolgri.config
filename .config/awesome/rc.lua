-- awesome (awesome) v3.1-rc3-7-g76b5113 (When Doves Cry)
-- • Build: Nov 22 2008 21:13:58 for i686 by gcc version 4.3.2 (wolgri@acer4520)
-- • D-Bus support: ✔
  
-- Include awesome libraries, with lots of useful function!
require("awful")
require("beautiful")
require("menu")

-- {{{ Variable definitions
-- This is a file path to a theme file which will defines colors.
theme_path = "/usr/local/share/awesome/themes/default/theme"

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    "tile",
--    "tileleft",
--    "tilebottom",
    "tiletop",
    "fairh",
--    "fairv",
--    "magnifier",
    "max",
--    "fullscreen",
--    "spiral",
--    "dwindle",
    "floating"
}

-- Table of clients that should be set floating. The index may be either
-- the application class or instance. The instance is useful when running
-- a console app in a terminal like (Music on Console)
--    xterm -name mocp -e mocp
floatapps =
{
    -- by class
    ["MPlayer"] = true,
    ["pinentry"] = true,
    ["gimp"] = true,
    ["wicd-client.py"] = true,

    -- by instance
    ["mocp"] = true
}

-- Applications to be moved to a pre-defined tag by class or instance.
-- Use the screen and tags indices.
apptags =
{
     ["Swiftfox"] = { screen = 1, tag = 2 },
     ["lilyterm"] = { screen = 1, tag = 1 },
     ["vmware"] = { screen = 1, tag = 5 },
     ["VirtualBox"] = { screen = 1, tag = 5 },
     ["gajim.py"] = { screen = 1, tag = 3 },


}
-- Define if we want to use titlebar on all applications.
use_titlebar = false
-- }}}

-- {{{ Initialization
-- Initialize theme (colors).
beautiful.init(theme_path)

-- Register theme in awful.
-- This allows to not pass plenty of arguments to each function
-- to inform it about colors we want it to draw.
--awful.beautiful.register(beautiful)
-- }}}

-- {{{ Tags
-- Define tags table.
tags = {}
for s = 2, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = {}
    -- Create 9 tags per screen.
    for tagnumber = 1, 2 do
        tags[s][tagnumber] = tag({ name = tagnumber, layout ="floating"  })
        -- Add tags to screen one by one
        tags[s][tagnumber].screen = s
    end
    -- I'm sure you want to see at least one tag.
    tags[s][1].selected = true
end

tags[1] = {}
tags[1][1] = tag({ name = "main", layout = layouts[1] })
tags[1][1].mwfact = 0.5
tags[1][1].screen = 1

tags[1][2] = tag({ name = "www", layout = layouts[1] })
tags[1][2].mwfact = 0.5
tags[1][2].screen = 1

tags[1][3] = tag({ name = "stuff", layout = "floating"})
tags[1][3].mwfact = 0.6
tags[1][3].screen = 1

tags[1][4] = tag({ name = "work", layout = layouts[1] })
tags[1][4].mwfact = 0.6
tags[1][4].screen = 1

tags[1][5] = tag({ name = "virt", layout = "max" })
tags[1][5].mwfact = 0.6
tags[1][5].screen = 1

tags[1][6] = tag({ name = "etc", layout = "floating" })
tags[1][6].mwfact = 0.6
tags[1][6].screen = 1
tags[1][1].selected = true



-- }}}

--{{{ My widgets
--{{{ Spacer
local bg_color = beautiful.bg_normal
tb_space= widget({ type = 'textbox', name = 'tb_space'})
tb_space.width = "4"
tb_space.text = " "

tb_spacer= widget({ type = 'textbox', name = 'tb_spacer',align = 'right' })
tb_spacer.width = "6"
tb_spacer.text = tb_space.text

--}}}
--{{{ Batt
battarywidget = widget({ type = 'progressbar', name = 'battarywidget' })
battarywidget.width = 100
battarywidget.height = 0.8
battarywidget.gap = 1
battarywidget.border_padding = 1
battarywidget.border_width = 1
battarywidget.ticks_count = 10
battarywidget.ticks_gap = 1
battarywidget.vertical = false
battarywidget:bar_properties_set('bat', {
bg = beautiful.fg_urgent,
fg = beautiful.bg_focus,
fg_off = 'red',
reverse = false,
min_value = 0,
max_value = 100
})

--}}}
--{{{ skb
skbwidget = widget({ type = 'textbox', name = 'skbwidget' , align = 'right' })
--}}}
--{{{ temp
tempwidget = widget({ type = 'textbox', name = 'cfreqwidget' , align = 'right' })
--}}}
--{{{ Mhz
cfreqwidget = widget({ type = 'textbox', name = 'cfreqwidget' , align = 'right' })
--}}}
--{{{ Cpu

cpu0graphwidget = widget({ type = 'graph', name = 'cpu0graphwidget', align = 'right' }) 
cpu0graphwidget.height = 1
cpu0graphwidget.width = 100
cpu0graphwidget.bg = beautiful.bg_normal
cpu0graphwidget.border_color = beautiful.fg_urgent
cpu0graphwidget.grow = 'left'

cpu0graphwidget:plot_properties_set('cpu', { 
fg = beautiful.bg_urgent,
style ='line',
--fg_center = 'green', 
--fg_end = 'cyan', 
vertical_gradient = false 
})
cpu1graphwidget = widget({ type = 'graph', name = 'cpu1graphwidget', align = 'right' }) 
cpu1graphwidget.height = 1
cpu1graphwidget.width = 100
cpu1graphwidget.bg = beautiful.bg_normal
cpu1graphwidget.border_color = beautiful.fg_urgent
cpu1graphwidget.grow = 'left'

cpu1graphwidget:plot_properties_set('cpu', { 
fg = beautiful.bg_urgent,
style ='line',
--fg_center = 'green', 
--fg_end = 'cyan', 
vertical_gradient = false 
})
--}}}
--{{{MeM 
memwidget = widget({ type = 'graph', name = 'memwidget', align = 'right' })

memwidget.width = 80
memwidget.height = 1
memwidget.gap = 0
memwidget.border_padding = 0
memwidget.border_width = 0
--memwidget.ticks_count = 0
--memwidget.ticks_gap = 0
memwidget.vertical = false
memwidget.grow = "left"
memwidget:plot_properties_set('mem', { 
fg = beautiful.fg_urgent,
--style ='line',
vertical_gradient = false 
})

--}}}
--{{{ Wifi
essidwidget = widget({ type = 'textbox', name = 'essidwidget',align = 'right' })

lqbarwidget = widget({ type = 'progressbar', name = 'lqbarwidget', align = 'right' })

lqbarwidget.width = 70
lqbarwidget.height = 1
lqbarwidget.gap = 0
lqbarwidget.border_padding = 1
lqbarwidget.border_width = 1
lqbarwidget.ticks_count = 10
lqbarwidget.ticks_gap = 1
lqbarwidget.vertical = false

lqbarwidget:bar_properties_set('lq', {
bg = 'gray20',
fg = 'green',
fg_off = 'gray20',
reverse = false,
min_value = 0,
max_value = 100
})
ratewidget = widget({ type = 'textbox', name = 'ratewidget',align = 'right' })



--}}}
--{{{Date
  datew = widget({type = 'textbox',name = 'datew',align = "right"  })
--}}}
--}}}

--{{{ Bottom panel
-- Create a botbox for each screen and add it
botbox = {}
botbox[1] = wibox({ position = "bottom", name = "botbox" .. 1, fg = beautiful.fg_normal, bg = beautiful.bg_normal })
-- Add widgets to the wibox - order matters
botbox[1].widgets = {
     mylauncher,
     battarywidget,
     tempwidget,tb_spacer,
     cfreqwidget,tb_spacer,
     cpu0graphwidget,tb_spacer,
     cpu1graphwidget,tb_spacer,
     memwidget,tb_spacer,
--     essidwidget,tb_spacer, lqbarwidget,tb_spacer, ratewidget, tb_spacer,
     datew
        }
botbox[1].screen = 1

--}}}

-- {{{ Wibox
-- Create a textbox widget
mytextbox = widget({ type = "textbox", align = "right" })
-- Set the default text in textbox
mytextbox.text = "<b><small> " .. AWESOME_RELEASE .. " </small></b>"

-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu.new({ items = {    {"Applications", menu.debian_menu_Applications , "/usr/share/pixmaps/debian-logo.png"},

{ "awesome", myawesomemenu, beautiful.awesome_icon },
                                        { "open terminal", terminal }
                                      }
                            })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Create a systray
mysystray = widget({ type = "systray", align = "right" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = { button({ }, 1, awful.tag.viewonly),
                      button({ modkey }, 1, awful.client.movetotag),
                      button({ }, 3, function (tag) tag.selected = not tag.selected end),
                      button({ modkey }, 3, awful.client.toggletag),
                      button({ }, 4, awful.tag.viewnext),
                      button({ }, 5, awful.tag.viewprev) }
mytasklist = {}
mytasklist.buttons = { button({ }, 1, function (c) client.focus = c; c:raise() end),
                       button({ }, 3, function () awful.menu.clients({ width=250 }) end),
                       button({ }, 4, function () awful.client.focus.byidx(1) end),
                       button({ }, 5, function () awful.client.focus.byidx(-1) end) }

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = widget({ type = "textbox", align = "left" })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = widget({ type = "imagebox", align = "right" })
    mylayoutbox[s]:buttons({ button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                             button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                             button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                             button({ }, 5, function () awful.layout.inc(layouts, -1) end) })
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist.new(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist.new(function(c)
                                                  return awful.widget.tasklist.label.currenttags(c, s)
                                              end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = wibox({ position = "top", fg = beautiful.fg_normal, bg = beautiful.bg_normal })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = { mylauncher,
                           mytaglist[s],
                           mytasklist[s],
                           mypromptbox[s],
                           mylayoutbox[s],
                           s == 1 and mysystray or nil }
    mywibox[s].screen = s
end
-- }}}

-- {{{ Mouse bindings
awesome.buttons({
    button({ }, 3, function () mymainmenu:toggle() end),
    button({ }, 4, awful.tag.viewnext),
    button({ }, 5, awful.tag.viewprev)
})
-- }}}

-- {{{ Key bindings

--{{{ Bind keyboard digits
-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

for i = 1, keynumber do
    keybinding({ modkey }, i,
                   function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                           awful.tag.viewonly(tags[screen][i])
                       end
                   end):add()
    keybinding({ modkey, "Control" }, i,
                   function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                           tags[screen][i].selected = not tags[screen][i].selected
                       end
                   end):add()
    keybinding({ modkey, "Shift" }, i,
                   function ()
                       if client.focus then
                           if tags[client.focus.screen][i] then
                               awful.client.movetotag(tags[client.focus.screen][i])
                           end
                       end
                   end):add()
    keybinding({ modkey, "Control", "Shift" }, i,
                   function ()
                       if client.focus then
                           if tags[client.focus.screen][i] then
                               awful.client.toggletag(tags[client.focus.screen][i])
                           end
                       end
                   end):add()
end
--}}}
--keybinding({ modkey }, "Left", awful.tag.viewprev):add()
--keybinding({ modkey }, "Right", awful.tag.viewnext):add()
--keybinding({ modkey }, "Escape", awful.tag.history.restore):add()

--{{{ Standard program
keybinding({ modkey }, "Return", function () awful.util.spawn(terminal) end):add()

keybinding({ modkey, "Control" }, "r", function ()
                                           mypromptbox[mouse.screen].text =
                                               awful.util.escape(awful.util.restart())
                                        end):add()
keybinding({ modkey, "Shift" }, "q", awesome.quit):add()

--}}}
--{{{ Fn keys 

keybinding( {none}, "XF86AudioMute", function () awful.util.spawn("amixer -c 0 set Master toggle") end):add()
keybinding( {none}, "XF86AudioRaiseVolume", function () awful.util.spawn("amixset +") end):add()
keybinding( {none}, "XF86AudioLowerVolume", function () awful.util.spawn("amixset -") end):add()
keybinding( {none}, "XF86AudioPlay", function () awful.util.spawn("mpc toggle") end):add()
keybinding( {none}, "XF86AudioNext", function () awful.util.spawn("mpc next") end):add()
keybinding( {none}, "XF86AudioStop", function () awful.util.spawn("mpc stop ") end):add()
keybinding( {none}, "XF86AudioPrev", function () awful.util.spawn("mpc prev ") end):add()
keybinding( {none}, "XF86Sleep", function () awful.util.spawn("sudo pm-suspend --quirk-dpms-on --quirk-vbestate-restore --quirk-vbemode-restore") end):add()
keybinding( {none}, "XF86HomePage", function () awful.util.spawn("sudo cpufreq-set -g ondemand") end):add()
keybinding( {none}, "XF86Start", function () awful.util.spawn("sudo cpufreq-set -g powersave") end):add()
keybinding( {none}, "XF86WWW", function () awful.util.spawn("swiftfox") end):add()
keybinding( {none}, "XF86Mail", function () awful.util.spawn("urxvt -e mutt") end):add()
keybinding( {none}, "XF86Messenger", function () mymainmenu:toggle() end):add()
--}}}
--{{{ Client manipulation
keybinding({ modkey }, "m", awful.client.maximize):add()
keybinding({ modkey }, "F5", function () client.focus.fullscreen = not client.focus.fullscreen end):add()
keybinding({ modkey }, "w", function () client.focus:kill() end):add()
keybinding({ modkey }, "Left", function () awful.client.focus.byidx(1); client.focus:raise() end):add()
keybinding({ modkey }, "Right", function () awful.client.focus.byidx(-1);  client.focus:raise() end):add()
keybinding({ modkey, "Shift" }, "Left", function () awful.client.swap.byidx(1) end):add()
keybinding({ modkey, "Shift" }, "Right", function () awful.client.swap(-1) end):add()
keybinding({ modkey, "Control" }, "Left", function () awful.screen.focus(1) end):add()
keybinding({ modkey, "Control" }, "Right", function () awful.screen.focus(-1) end):add()
keybinding({ modkey, "Control" }, "space", awful.client.togglefloating):add()
keybinding({ modkey, "Control" }, "Return", function () client.focus:swap(awful.client.getmaster()) end):add()
keybinding({ modkey }, "o", awful.client.movetoscreen):add()
keybinding({ modkey }, "Tab", awful.client.focus.history.previous):add()
keybinding({ modkey }, "u", awful.client.urgent.jumpto):add()
keybinding({ modkey, "Shift" }, "r", function () client.focus:redraw() end):add()
--}}}
--{{{ Layout manipulation
keybinding({ modkey }, "Down", function () awful.tag.incmwfact(0.05) end):add()
keybinding({ modkey }, "Up", function () awful.tag.incmwfact(-0.05) end):add()
keybinding({ modkey, "Shift" }, "Up", function () awful.tag.incnmaster(1) end):add()
keybinding({ modkey, "Shift" }, "Down", function () awful.tag.incnmaster(-1) end):add()
keybinding({ modkey, "Control" }, "Up", function () awful.tag.incncol(1) end):add()
keybinding({ modkey, "Control" }, "Down", function () awful.tag.incncol(-1) end):add()
keybinding({ modkey }, "space", function () awful.layout.inc(layouts, 1) end):add()
keybinding({ modkey, "Shift" }, "space", function () awful.layout.inc(layouts, -1) end):add()
--}}}
--{{{ Prompt
keybinding({ modkey }, "F1", function ()
                                 awful.prompt.run({ prompt = "Run: " }, mypromptbox[mouse.screen], awful.util.spawn, awful.completion.bash,
                                                  awful.util.getdir("cache") .. "/history")
                             end):add()
keybinding({ modkey }, "F4", function ()
                                 awful.prompt.run({ prompt = "Run Lua code: " }, mypromptbox[mouse.screen], awful.util.eval, awful.prompt.bash,
                                                  awful.util.getdir("cache") .. "/history_eval")
                             end):add()

keybinding({ modkey, "Ctrl" }, "i", function ()
                                        local s = mouse.screen
                                        if mypromptbox[s].text then
                                            mypromptbox[s].text = nil
                                        else
                                            mypromptbox[s].text = nil
                                            if client.focus.class then
                                                mypromptbox[s].text = "Class: " .. client.focus.class .. " "
                                            end
                                            if client.focus.instance then
                                                mypromptbox[s].text = mypromptbox[s].text .. "Instance: ".. client.focus.instance .. " "
                                            end
                                            if client.focus.role then
                                                mypromptbox[s].text = mypromptbox[s].text .. "Role: ".. client.focus.role
                                            end
                                        end
                                    end):add()
--}}}
--{{{ Client awful tagging: this is useful to tag some clients and then do stuff like move to tag on them
keybinding({ modkey }, "t", awful.client.togglemarked):add()

for i = 1, keynumber do
    keybinding({ modkey, "Shift" }, "F" .. i,
                   function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                           for k, c in pairs(awful.client.getmarked()) do
                               awful.client.movetotag(tags[screen][i], c)
                           end
                       end
                   end):add()
end
-- }}}

-- }}}

-- {{{ My hooks
--{{{ cpu
cpu0_total = 0
cpu0_active = 0
cpu1_total = 0
cpu1_active = 0

function get_cpu()
    -- Return CPU usage percentage
    ---- Get /proc/stat
    local f = io.open('/proc/stat')
    for l in f:lines() do
    cpu_usage = splitbywhitespace(l)
    if cpu_usage[1] == "cpu0" then
            ---- Calculate totals
            total_new = cpu_usage[2]+cpu_usage[3]+cpu_usage[4]+cpu_usage[5]
            active_new = cpu_usage[2]+cpu_usage[3]+cpu_usage[4]
            
            ---- Calculate percentage
            diff_total = total_new-cpu0_total
            diff_active = active_new-cpu0_active
            usage_percent = math.floor(diff_active/diff_total*100)

            ---- Store totals
            cpu0_total = total_new
            cpu0_active = active_new
            
            cpu0graphwidget:plot_data_add("cpu",usage_percent)
     elseif cpu_usage[1] == "cpu1" then
            ---- Calculate totals
            total_new = cpu_usage[2]+cpu_usage[3]+cpu_usage[4]+cpu_usage[5]
            active_new = cpu_usage[2]+cpu_usage[3]+cpu_usage[4]
            
            ---- Calculate percentage
            diff_total = total_new-cpu1_total
            diff_active = active_new-cpu1_active
            usage_percent = math.floor(diff_active/diff_total*100)

            ---- Store totals
            cpu1_total = total_new
            cpu1_active = active_new

            cpu1graphwidget:plot_data_add("cpu",usage_percent)
        
    end

end
f:close()
end
--}}} 
--{{{ mem hook
function get_mem()
  local mem_free, mem_total, mem_c, mem_b
  local mem_percent, swap_percent, line, fh, count
  count = 0

  fh = io.open("/proc/meminfo")

  line = fh:read()
  while line and count < 4 do
    if line:match("MemFree:") then
      mem_free = string.match(line, "%d+")
      count = count + 1;
    elseif line:match("MemTotal:") then
      mem_total = string.match(line, "%d+")
      count = count + 1;
    elseif line:match("Cached:") then
      mem_c = string.match(line, "%d+")
      count = count + 1;
    elseif line:match("Buffers:") then
      mem_b = string.match(line, "%d+")
      count = count + 1;
    end
    line = fh:read()
  end
  io.close(fh)

  mem_percent = 100 * (mem_total - mem_free - mem_b - mem_c ) / mem_total;
 memwidget:plot_data_add("mem",mem_percent)
end
--}}}
--{{{ cfreq hook
function get_cfreq()
    local m = io.popen("cpufreq-info -p | awk '{print $3 }'")
      for line in m:lines() do
            cfreq = line
      end    

    m:close()
cfreqwidget.text =""..cfreq..""
end 
--}}} 
--{{{ temp hook
function get_temp()
    local m = io.popen("echo \"scale=0 ;`cat /sys/bus/pci/drivers/k8temp/*/temp1_input`/1000 \"| bc -l")
      for line in m:lines() do
            temp = line
      end    

    m:close()
tempwidget.text =""..temp.."°"
end 
--}}} 
--{{{ skb hook
function get_skb()
    local m = io.popen("skb -1")
      for line in m:lines() do
            skb = line
      end    

    m:close()
skbwidget.text ="<bg color=\"blue\"/><span font_desc=\"sans bold 9\" color=\"white\"> " ..skb.. " </span>"
end 
--}}} 
--{{{ wifi hook

local function get_iwinfo_iwcfg()
    local wlann="ath0"
	local f1 = io.popen("/sbin/iwconfig " .. wlann)
	if not f1 then
		return
	else
		local iwOut = f1:read('*a')
		f1:close()
		st,en,proto = string.find(iwOut, '(802.11[%-]*%a*)')
		st,en,ssid = string.find(iwOut, 'ESSID[=:]"([%w+%s*]*)"', en)
		st,en,bitrate = string.find(iwOut, 'Bit Rate[=:]([%s%w%.]*%/%a+)', en)
		bitrate = string.gsub(bitrate, "%s", "")
		st,en,linkq1,linkq2 = string.find(iwOut, 'Link Quality[=:](%d+)/(%d+)', en)
		st,en,signal = string.find(iwOut, 'Signal level[=:](%-%d+)', en)
		st,en,noise = string.find(iwOut, 'Noise level[=:](%-%d+)', en)
        linkq = math.floor(100*linkq1/linkq2)
		return proto, ssid, bitrate, linkq, signal, noise
	end
end

local function update_iwinfo()
	local proto, ssid, bitrate, linkq, signal, noise = get_iwinfo_iwcfg()

-- In case get_iwinfo_iwcfg doesn't return any values we don't want stupid lua
-- errors about concatenating nil values.
	ssid = ssid or "N/A"
	bitrate = bitrate or "N/A"
	linkq = linkq or "N/A"
	signal = signal or "N/A"
	noise = noise or "N/A"
	proto = proto or "N/A"

essidwidget.text ="<bg color=\"red\"/><span font_desc=\"sans bold 9\" color=\"white\"> "..ssid.." </span>"
ratewidget.text = "<span color=\"green\">"..bitrate.."</span>"
lqbarwidget:bar_data_add("lq",linkq )


end
--}}}
--{{{ batt hook
local function get_bat()
   local a = io.open("/sys/class/power_supply/BAT1/charge_full")
    for line in a:lines() do
            full = line
       end 
    a:close()
 local b = io.open("/sys/class/power_supply/BAT1/charge_now")
    for line in b:lines() do
            now = line
       end 
    b:close()
batt=math.floor(now*100/full)
battarywidget:bar_data_add("bat",batt )

end

--}}}
--{{{ date hook 
function hook_timer ()
    os.setlocale(os.getenv("LC_ALL"))
    datew.text ="<bg color=\"gray30\"/><span font_desc=\"sans bold 8\" color=\"white\">"..os.date('%a %d %b  %H:%M').."</span>"
end
-- }}}
-- {{{ splitbywhitespace stolen from wicked.lua
function splitbywhitespace(str) 
     values = {}
     start = 1
     splitstart, splitend = string.find(str, ' ', start)

     while splitstart do
            m = string.sub(str, start, splitstart-1)
            if m:gsub(' ','') ~= '' then
                 table.insert(values, m)
            end

            start = splitend+1
            splitstart, splitend = string.find(str, ' ', start)
     end

     m = string.sub(str, start)
     if m:gsub(' ','') ~= '' then
            table.insert(values, m)
     end

     return values
end
--}}}
--{{{ Set My some hooks

function onesec()
    hook_timer()
    get_mem()
    get_cpu()
    get_cfreq()
--    get_skb()
end

function fivesec()
--    update_iwinfo()
    get_bat()
    get_temp()

end

awful.hooks.timer.register(1, onesec)
awful.hooks.timer.register(5, fivesec)
--}}}
--}}}

-- {{{ Hooks
-- Hook function to execute when focusing a client.
awful.hooks.focus.register(function (c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_focus
    end
end)

-- Hook function to execute when unfocusing a client.
awful.hooks.unfocus.register(function (c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_normal
    end
end)

-- Hook function to execute when marking a client
awful.hooks.marked.register(function (c)
    c.border_color = beautiful.border_marked
end)

-- Hook function to execute when unmarking a client.
awful.hooks.unmarked.register(function (c)
    c.border_color = beautiful.border_focus
end)

-- Hook function to execute when the mouse enters a client.
awful.hooks.mouse_enter.register(function (c)
    -- Sloppy focus, but disabled for magnifier layout
    if awful.layout.get(c.screen) ~= "magnifier"
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

-- Hook function to execute when a new client appears.
awful.hooks.manage.register(function (c)
    if use_titlebar then
        -- Add a titlebar
        awful.titlebar.add(c, { modkey = modkey })
    end
    -- Add mouse bindings
    c:buttons({
        button({ }, 1, function (c) client.focus = c; c:raise() end),
        button({ modkey }, 1, function (c) c:mouse_move() end),
        button({ modkey }, 3, function (c) c:mouse_resize() end)
    })
    -- New client may not receive focus
    -- if they're not focusable, so set border anyway.
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_normal
    client.focus = c

    -- Check if the application should be floating.
    local cls = c.class
    local inst = c.instance
    if floatapps[cls] then
        c.floating = floatapps[cls]
    elseif floatapps[inst] then
        c.floating = floatapps[inst]
    end

    -- Check application->screen/tag mappings.
    local target
    if apptags[cls] then
        target = apptags[cls]
    elseif apptags[inst] then
        target = apptags[inst]
    end
    if target then
        c.screen = target.screen
        awful.client.movetotag(tags[target.screen][target.tag], c)
    end

    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- awful.client.setslave(c)

    -- Honor size hints: if you want to drop the gaps between windows, set this to false.
    -- c.honorsizehints = false
end)

-- Hook function to execute when arranging the screen.
-- (tag switch, new client, etc)
awful.hooks.arrange.register(function (screen)
    local layout = awful.layout.get(screen)
    if layout then
        mylayoutbox[screen].image = image(beautiful["layout_" .. layout])
    else
        mylayoutbox[screen].image = nil
    end

    -- Give focus to the latest client in history if no window has focus
    -- or if the current window is a desktop or a dock one.
    if not client.focus then
        local c = awful.client.focus.history.get(screen, 0)
        if c then client.focus = c end
    end

    -- Uncomment if you want mouse warping
    --[[
    if client.focus then
        local c_c = client.focus:fullgeometry()
        local m_c = mouse.coords()

        if m_c.x < c_c.x or m_c.x >= c_c.x + c_c.width or
            m_c.y < c_c.y or m_c.y >= c_c.y + c_c.height then
            if table.maxn(m_c.buttons) == 0 then
                mouse.coords({ x = c_c.x + 5, y = c_c.y + 5})
            end
        end
    end
    ]]
end)

-- Hook called every second
awful.hooks.timer.register(1, function ()
    -- For unix time_t lovers
 --   mytextbox.text = " " .. os.time() .. " time_t "
    -- Otherwise use:
    -- mytextbox.text = " " .. os.date() .. " "
end)
-- }}}
-- vim: set filetype=lua fdm=marker tabstop=4 shiftwidth=4 expandtab smarttab autoindent smartindent nu:
