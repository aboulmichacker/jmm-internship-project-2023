/*
@Company name : EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : Account Trigger Handler 
@Test Class: AccountTriggerHandlerTest
@Test Class Coverage: 100%
*/
public with sharing class AccountTriggerHandler {
    
/*
@Company name :EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : method that prevents updating account record type 
@Param List : list of accounts used by trigger.new, map of id and account used by trigger.oldmap and trigger.newmap
@Return List : void
*/
    public static void preventupdatingrecordtype(list<Account> Triggernew, Map<Id,account> triggeroldmap,Map<Id,account> triggernewmap)
    {
        
        set<string> businessaccts = new set<string>();
        //get record type ids
        String individualRecordTypeId =  Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(label.Individual).getRecordTypeId(); 
        String businessRecordTypeId =  Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(label.Business).getRecordTypeId();
        
        //get business account ids
        for (Account a: Triggernew )
        {
            if(a.recordtypeId == individualRecordTypeId && triggeroldmap.get(a.id).recordtypeId == businessRecordTypeId)
            {   
                businessaccts.add(a.id);
            }
        }
        //check if account has a contact and throw error
        for(account acc : [SELECT id, (SELECT Id FROM Contacts) 
                                            FROM Account WHERE Id IN :businessaccts]){                                  
            if(acc.Contacts.size()>1)
            {
                triggernewmap.get(acc.Id).addError(label.CannotUpdateAccount);
            }                                    
        }
    }
}