/*
@Company name : EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : Opportunity Trigger Test Class
*/
@istest
private class TestOpportunityTrigger {
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
        DataFactory.makeopportunitydata();
    }
/*
@Company name :EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : test the method that creates the service contract
@Param List : null
@Return List : void
*/
    @istest static void TestifContractisCreatedCorrectly()
    {
        Opportunity JihadOpp = [SELECT Id FROM Opportunity WHERE Name = 'Jjopp2023' LIMIT 1];
        Account JihadAccount = [SELECT Id FROM Account WHERE Name ='Mr. Jalkh Account' LIMIT 1];
        TestUtils.UpdateOpportunityStage('Closed Won', JihadOpp.Id);

        list<ServiceContract> createdservicecontracts = [SELECT id,(SELECT Id FROM ContractLineItems)FROM ServiceContract WHERE AccountId = :JihadAccount.Id];

        system.assertEquals(1, createdservicecontracts.size());
        system.assertEquals(3, createdservicecontracts[0].ContractLineItems.Size());

    }
}