/*
@Company name : EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : Data Factory Class 
*/

@istest
public with sharing class DataFactory {
   
/*
@Company name :EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : method that is used to call test data
@Param List : null
@Return List : void
*/
    @istest public static void makeopportunitydata() {
        Account Jihad_Account = TestUtils.CreateAccount('Mr. Jalkh Account', 'Individual');
        insert Jihad_Account;

        Contact Jihad = TestUtils.CreateContact('Jihad', 'Jalkh', Jihad_Account.Id);
        insert Jihad;

        Opportunity JihadOpp = TestUtils.CreateOpportunity('Jjopp2023', Date.newInstance(2023, 07, 28), 'Prospecting', Jihad_Account.Id, Test.getStandardPricebookId());
        insert JihadOpp;

        list<Product2> ProductsList = new List<Product2>();
        Product2 Infiniti = TestUtils.CreateProduct('Infiniti FX35', 'SUV', 'Infiniti', 'Grey', 2009, 5);
        ProductsList.add(infiniti);
        
        Product2 Picanto = TestUtils.CreateProduct('Kia Picanto', 'Car', 'Kia', 'Black', 2012, 5);
        ProductsList.add(Picanto);

        Product2 Citroen = TestUtils.CreateProduct('Citroen Xsara', 'Car', 'Citroen', 'Red', 2002, 5);
        ProductsList.add(Citroen);

        insert ProductsList;
        
        List<PricebookEntry> PricesList = new List<PricebookEntry>();
        
        PricebookEntry InfinitiPrice = TestUtils.CreatePriceBookEntry(Infiniti.Id, Test.getStandardPricebookId(), 20, 15);
        InfinitiPrice.IsActive=true;
        PricesList.add(InfinitiPrice);

        PricebookEntry PicantoPrice = TestUtils.CreatePriceBookEntry(Picanto.Id, Test.getStandardPricebookId(), 15, 10);
        PicantoPrice.IsActive=true;
        PricesList.add(PicantoPrice);

        PricebookEntry CitroenPrice = TestUtils.CreatePriceBookEntry(Citroen.Id, Test.getStandardPricebookId(), 10, 7);
        CitroenPrice.IsActive=true;
        PricesList.add(CitroenPrice);

        insert PricesList;

        list<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
        
        OpportunityLineItem JihadVehicle1 = TestUtils.CreateOppLineItem(Infiniti.Id, JihadOpp.Id, 1, InfinitiPrice.UnitPrice);
        oliList.add(JihadVehicle1);

        OpportunityLineItem JihadVehicle2 = TestUtils.CreateOppLineItem(Picanto.Id, JihadOpp.Id, 1, PicantoPrice.UnitPrice);
        oliList.add(JihadVehicle2);

        OpportunityLineItem JihadVehicle3 = TestUtils.CreateOppLineItem(Citroen.Id, JihadOpp.Id, 1, CitroenPrice.UnitPrice);
        oliList.add(JihadVehicle3);

        insert oliList;
    }
}