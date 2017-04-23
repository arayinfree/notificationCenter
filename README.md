# notificationCenter
provides a mechanism for broadcasting information within a program buy lua

# feature
. easy to use
. does not holding observer 
. remove/add observe in callback func safty

# API
```
-- add observer for event with func. func prototype func(self ,data ,obj)
function notificationCenter:addObserve(event,observer,func)

-- remove observer for specify event ,or if event == nil ,remove all event for observer
function notificationCenter:removeObserve(observer,event)

-- post event with data and obj. event required
function notificationCenter:post(event,data,obj)
```
# usage
  see test.lua
