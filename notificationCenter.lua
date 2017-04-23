
notificationCenter = {}

notificationCenter.listener = {}

-- add observer for event with func. func prototype func(self ,data ,obj)
function notificationCenter:addObserve(event,observer,func)
    assert(event,"notificationCenter addObserve, event eq nil")
    assert(observer,"notificationCenter addObserve; observer eq nil")
    assert(func,"notificationCenter addObserve; func eq nil")

    if self.listener[event] then
        self.listener[event][observer] = func
    else
        local w = {}
        setmetatable(w, {__mode = "k"});
        w[observer] = func;
        self.listener[event] = w;
    end
end

-- remove observer for specify event ,or if event == nil ,remove all event for observer
function notificationCenter:removeObserve(observer,event)
    assert(observer,"notificationCenter removeObserve; observer eq nil")

    if event then
        if self.listener[event] then
            self.listener[event][observer] = nil;
        end
    else
        for k ,v in pairs(self.listener) do
            if v[observer] then
                v[observer] = nil;
            end
        end
    end
end

-- post event with data and obj
function notificationCenter:post(event,data,obj)
    assert(event,"notificationCenter post event eq nil")

    if  self.listener[event] then
        local colist = {}
        for observer ,func in pairs(self.listener[event]) do
            co = coroutine.create(function ()
                func(observer,data,obj)
            end)
            table.insert( colist, co )
        end
        for k,v in pairs(colist) do
            coroutine.resume(v)
        end
        colist = nil;
    end
end
