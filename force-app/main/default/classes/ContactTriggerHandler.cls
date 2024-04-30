/*
@Company name : EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : Contact Trigger Handler
@Test Class: ContactTriggerHandlerTest
@Test Class Coverage: 100% 
*/
public with sharing class ContactTriggerHandler {
    
/*
@Company name :EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : Method that prevents adding more than 1 contact to an account of record type individual
@Param List : List of Contacts that is used by trigger.new in the trigger
@Return List : void
*/
    public static void PreventAddingContacts(List<Contact> triggernew) {
        Set<string> accountIds = new set<string>();
        Map<String,Integer> contactcountmap = new Map<String,Integer>();
        Map<String,String> recordtypemap = new Map<String,String>();

        //retrieve the record type id
        String IndividualRecordtypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(label.Individual).getRecordTypeId();

        //fill the contactcountmap with the account id as key and the corresponding contact count as value
        for(contact c : triggernew)
        {   
            accountIds.add(c.accountId);

            if(contactcountmap.containskey(c.accountId)){
                contactcountmap.put(c.accountId, contactcountmap.get(c.accountId)+1);
            }else{
                contactcountmap.put(c.accountId, 1);
            }
        }

        //retrieve accounts present in the database
        list<Account> orgAccounts = [SELECT Id, recordtypeid, (SELECT Id FROM Contacts)
                                    FROM Account
                                    WHERE Id IN :accountIds]; 

        //add the database contacts to the contact count map                            
        for(Account a: orgAccounts)
        {
            recordtypemap.put(a.id, a.recordtypeid);
            if(contactcountmap.containsKey(a.id))
            {
                contactcountmap.put(a.id,contactcountmap.get(a.id) + a.Contacts.size());
            }
        }

        //check conditions and throw an error
        for(Contact c: triggernew)
        {   
            if(recordtypemap.get(c.accountId) == IndividualRecordtypeId && contactcountmap.get(c.accountId)>1)
            {
                c.addError(label.CannotAddContact);
            }
        }
    }
/*
@Company name :EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : Method that prevents updating a contact's account that is of type individual
@Param List : List of Contacts  and map of contacts that is used by trigger.new and trigger.oldmap
@Return List : void
*/
    public static void preventUpdatingContactAccount(List<Contact> triggernew, Map<Id,Contact> triggeroldmap)
    {   
        list<Account> IndividualAccounts = [SELECT Id, (SELECT Id FROM Contacts)
                                                        FROM Account WHERE recordtype.name = :label.Individual];

        set<string> IndividualAcctIdswithcontacts = new set<string>();

        //get the ids of indivudual accounts with contacts
        for(Account acct: IndividualAccounts)
        {
            if(acct.contacts.size() >= 1)
            {
                IndividualAcctIdswithcontacts.add(acct.Id);
            }
        }
        //check conditions and throw error
        for(Contact c : triggernew)
        {
            if((c.accountId!= triggeroldmap.get(c.id).AccountId) && IndividualAcctIdswithcontacts.contains(c.accountId))
            {
                c.addError(label.CannotUpdateContact);
            }
        }
    }
}