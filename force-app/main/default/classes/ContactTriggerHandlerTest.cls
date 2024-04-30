/*
@Company name : EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : Contact Trigger Handler Test Class
*/


@istest
private class ContactTriggerHandlerTest {
/*
@Company name :EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : test setup method
@Param List : null
@Return List : void
*/
    
    @TestSetup
    static void makeData(){
        Account individual = TestUtils.CreateAccount('Test Account', label.Individual);
        insert individual;

        Account business = TestUtils.CreateAccount('Test Account 2', label.Business);
        insert business;
    }

/*
@Company name :EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : test insert more than 1 account on individual method
@Param List : null
@Return List : void
*/
    @istest static void testindividualaccounttrigger(){
        try{

            Account individual = [SELECT id FROM Account WHERE Name = 'Test Account' LIMIT 1];

            list<Contact> contactslist = new List<Contact>();

            Contact con1 = TestUtils.CreateContact('Test', 'Contact1', individual.id);
            contactslist.add(con1);
            Contact con2 = TestUtils.CreateContact('Test', 'Contact2', individual.id);
            contactslist.add(con2);

            insert contactslist;

        }
        catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains(label.CannotAddContact) ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
        }
    }

/*
@Company name :EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : test update contact's account that is invalid 
@Param List : null
@Return List : void
*/

    @istest static void testindividualaccountupdate(){
        try{
            Account individual = [SELECT id FROM Account WHERE Name = 'Test Account' LIMIT 1];
            Account business = [SELECT id FROM Account WHERE Name = 'Test Account 2' LIMIT 1];

            list<Contact> contactslist = new List<Contact>();

            Contact con1 = TestUtils.CreateContact('Test', 'Contact1', business.Id);
            contactslist.add(con1);
            Contact con2 = TestUtils.CreateContact('Test', 'Contact2', business.Id);
            contactslist.add(con2);

            insert contactslist;

            contactslist[0].AccountId = individual.Id;
            contactslist[1].AccountId = individual.Id;

            update contactslist;

        }

        catch(Exception e){
            Boolean expectedExceptionThrown =  e.getMessage().contains(label.CannotUpdateContact) ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
        }
    }
}