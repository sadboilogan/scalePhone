function openMessagesMenu(scaleform, messages, selectID, title)
    SetMobilePhoneRotation(-90.0,0.0,0.0) -- 75<X<75
    SetPhoneLean(false)
    Scaleform.CallFunction(scaleform, false, "SET_HEADER", title)
    Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT_EMPTY", 6)
    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 1, false, 4)
    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 2, true, 10)
    Scaleform.CallFunction(scaleform, false, "SET_SOFT_KEYS", 3, true, 4)
    for i,k in pairs(messages) do
        local var = ""
        if k.isentthat == true then
            var = "To: "
        end
        --Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 6, slotID, Hour, Minute, Player Name, Message)
        Scaleform.CallFunction(scaleform, false, "SET_DATA_SLOT", 6, i, k.h, k.m, var..k.contact, k.message)
    end
    Scaleform.CallFunction(scaleform, false, "DISPLAY_VIEW", 6, selectID)
end

AddEventHandler('scalePhone.HandleInput.messagesList', function(input)
    if input == "left" then
        CellCamMoveFinger(4)
        Scaleform.CallFunction(phoneScaleform, false, "SET_INPUT_EVENT", 4)
    elseif input == 'right' then
        CellCamMoveFinger(3)
        Scaleform.CallFunction(phoneScaleform, false, "SET_INPUT_EVENT", 2)
    elseif input == 'up' then
        CellCamMoveFinger(1)
        Scaleform.CallFunction(phoneScaleform, false, "SET_INPUT_EVENT", 1)
    elseif input == 'down' then
        CellCamMoveFinger(2)
        Scaleform.CallFunction(phoneScaleform, false, "SET_INPUT_EVENT", 3)
    elseif input == 'select' then
        CellCamMoveFinger(5)
        --TriggerEvent('scalePhone.BuildMessageView', apps[appOpen].buttons[appSelectID])
        TriggerEvent(apps[appOpen].buttons[appSelectID].event, apps[appOpen].buttons[appSelectID].eventParams)
    elseif input == 'back' then
        CellCamMoveFinger(5)
        RemoveNotifications(appOpen)
        --apps[0].buttons[1].notif = 0
        TriggerEvent(apps[appOpen].backEvent, apps[appOpen].data)
    end

    local ret = Scaleform.CallFunction(phoneScaleform, true, "GET_CURRENT_SELECTION")
    while true do
        if IsScaleformMovieMethodReturnValueReady(ret) then
            appSelectID = GetScaleformMovieMethodReturnValueInt(ret) --output
            break
        end
        Citizen.Wait(0)
    end
end)