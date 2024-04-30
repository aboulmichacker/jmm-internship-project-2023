/*
@Company name : EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : Account Trigger Handler test class
*/
@istest
private class AccountTriggerHandlerTest {

/*
@Company name :EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : test the method that prevents updating account record type 
@Param List : null
@Return List : void
*/
    @istest static void testpreventupdatingaccount() {
        try{
            Account business = TestUtils.CreateAccount('Test Account', label.Business);
            insert business;

            list<Contact> contactslist = new List<Contact>();

            Contact con1 = TestUtils.CreateContact('Test', 'Contact1', business.Id);
            contactslist.add(con1);
            Contact con2 = TestUtils.CreateContact('Test', 'Contact2', business.Id);
            contactslist.add(con2);

            insert contactslist;

            business.recordtypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(label.Individual).getRecordTypeId();

            update business;
        }
        catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains(label.CannotUpdateAccount) ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
        }
    }
}