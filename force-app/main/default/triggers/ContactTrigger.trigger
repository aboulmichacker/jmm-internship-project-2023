/*
@Company name : EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : Contact Trigger 
@Test Class: ContactTriggerHandlerTest
@Test Class Coverage: 100% 
*/
trigger ContactTrigger on Contact (before insert, before update, after insert, after update) {
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            ContactTriggerHandler.PreventAddingContacts(Trigger.new);
        }
    }
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            ContactTriggerHandler.preventUpdatingContactAccount(Trigger.new, Trigger.oldMap);
        }
    }
}