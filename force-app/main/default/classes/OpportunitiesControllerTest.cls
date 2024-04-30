/*
@Company name : EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : Opportunities Controller Test Class
*/
@istest
private class OpportunitiesControllerTest {
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
@Description : test method for controller
@Param List : null
@Return List : void
*/
    @istest static void OpportunitiesControllerTest() {
        Opportunity opp = [SELECT Id FROM Opportunity WHERE Name = 'Jjopp2023' LIMIT 1];

        OpportunitiesController.WRP_Opportunity wrapper = OpportunitiesController.getOppDetails(opp.Id);

        system.assertEquals('2023-07-28', wrapper.CloseDate);

    }
}