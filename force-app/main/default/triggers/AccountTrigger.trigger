/*
@Company name : EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : Account Trigger  
@Test Class: AccountTriggerHandlerTest
@Test Class Coverage: 100%
*/
trigger AccountTrigger on Account (before insert, before update, after insert, after update) {
    if(trigger.isBefore)
    {
        if(trigger.isUpdate){
            AccountTriggerHandler.preventupdatingrecordtype(Trigger.New, Trigger.oldMap, Trigger.newMap);
        }
    }
}