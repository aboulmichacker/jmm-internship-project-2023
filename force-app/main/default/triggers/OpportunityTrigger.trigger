/*
@Company name : EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : Opportunity Trigger 
@Test Class: TestOpportunityTrigger
@Test Class Coverage: 100%
*/
trigger OpportunityTrigger on Opportunity (before insert, before update, after insert, after update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
            OpportunityTriggerHandler.CreateContract(Trigger.new);
        }
    }
}