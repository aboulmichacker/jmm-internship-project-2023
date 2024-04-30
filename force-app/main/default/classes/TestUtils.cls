/*
@Company name : EI Technologies Lebanon
@Author : Jean Michel Moukarzel
@Date : 26-07-2023
@Description : test utils class used for creating data more easily in a test class
*/
@istest
public with sharing class TestUtils {
    //function that creates an account
    public static Account CreateAccount(String name, String RecordType) {
        Account Acc = new Account(Name = name, RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(RecordType).getRecordTypeId());
        return Acc;
    }
    //function that creates a contact
    public static Contact CreateContact(String firstname, string lastname, string accountid)
    {
        Contact con = new Contact(FirstName = firstname, LastName = lastname, AccountId = accountid);
        return con;
    }
    //function that creates an opportunity
    public static Opportunity CreateOpportunity(String name, Date Closedate, String Stage, String AccountId, string Pricebook)
    {
        Opportunity Opp = new Opportunity(name = Name, CloseDate = Closedate, StageName = Stage, AccountId = AccountId, Pricebook2Id = Pricebook);
        return opp;
    }
    //function that creates a product
    public static Product2 CreateProduct(String name, String RecordType, String Type, String Color, Decimal Year, Decimal NumberofSeats)
    {
        Product2 vehicle = new Product2(Name = name, RecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName().get(RecordType).getRecordTypeId(),
        Type__c = Type, Color__c = Color, Year__c = Year, Seats__c = NumberofSeats);

        return vehicle;
    }
    //function that creates a pricebook entry
    public static PricebookEntry CreatePriceBookEntry(String Productid, String PricebookId, Decimal Price, Decimal MinPrice)
    {
        PricebookEntry vehicleprice = new PricebookEntry(Product2Id = Productid, Pricebook2Id = PricebookId, UnitPrice = Price, MinPrice__c = MinPrice);
        return vehicleprice;
    }
    //function that creates an opportunity line item
    public static OpportunityLineItem CreateOppLineItem(String ProductId, String OpportunityId, Decimal Quantity, Decimal Price){
        
        OpportunityLineItem OppProduct = new OpportunityLineItem(Product2Id = ProductId, OpportunityId = OpportunityId, Quantity = Quantity, TotalPrice = Price);
        return OppProduct;
    }
    //function that updates a stage of an opportunity
    public static void UpdateOpportunityStage(String Stage, string id){
        
        Opportunity Opp = [SELECT StageName FROM Opportunity WHERE id = :id LIMIT 1];
        Opp.StageName = Stage;
        update Opp;
    }
}