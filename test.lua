-- test
require("notificationCenter")
ob0 = 'ob0'
ob1 = 'ob1'
ob2 = {}

notificationCenter:addObserve(0,ob0, function(self,data) print(tostring(self).." receive "..data)
    print ('you can add/remove in notify func safty')
    notificationCenter:post(2,"before remove")
    print ('remove ob1 from event list. ')
    notificationCenter:removeObserve(ob1)
    notificationCenter:post(2,"after remove")
    notificationCenter:addObserve(2,ob2, function(self,data) print(tostring(self).." receive "..data)end)
    notificationCenter:addObserve(3,ob2, function(self,data) print(tostring(self).." receive "..data) end)
    notificationCenter:addObserve(3,ob1, function(self,data) print(tostring(self).." receive "..data) end)
    notificationCenter:addObserve(2,ob1, function(self,data) print(tostring(self).." receive "..data) end)
 end )

notificationCenter:addObserve(2,ob1, function(self,data) print(tostring(self).." receive "..data) end)
notificationCenter:post(0,"0")
notificationCenter:post(1,"1")

print ('ob2 holding')
notificationCenter:post(2,"2")

ob2 = nil
collectgarbage()
print ('collectgarbage obj2 will auto remove from notifcationcenter')

print ('remove ob1 for event 3')
notificationCenter:removeObserve(ob1,3)
print ('ob1 remove observing event 3')
notificationCenter:post(2,"4")
notificationCenter:post(3,"5")

notificationCenter:addObserve(4,ob1, function(self,data,obj) 
    if obj == ob0 then
        -- onliy process event from ob0
        print("process evnet onliy from ob0") 
    end
end)
notificationCenter:post(4)
notificationCenter:post(4,"process evnet onliy from ob0",ob0)